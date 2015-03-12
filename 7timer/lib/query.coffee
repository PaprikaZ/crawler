request = require('request')
config = require('./config.js')

LocationRecord = require('./model.js').LocationRecord
PredictRecord = require('./model.js').PredictRecord

pollTimer = null
timers = [pollTimer]

params = (->
  return [
    'lang=' + config.queryLang,
    'unit=' + config.queryUnit,
    'output=' + config.queryOutput,
    'tzshift=' + config.queryTzshift,
  ].join('&')
)()
pollUrl = config.domain + config.queryUri + config.queryType + params

requestErrorHandler = (err, cb) ->
  logger.error('caught request error: %s', err.message)
  cb()
  return

abnormalResponseHandler = (res, cb) ->
  logger.error('api return code %s', res.statusCode)
  logger.debug('response body:')
  logger.debug('res.body')
  cb()
  return

returnErrorHandler = (ret, cb) ->
  logger.debug('return error handler is empty')
  cb()
  return

writeRecord = (ret, cb) ->
  logger.debug(ret)
  now = new Date()
  prediction = ret.dataseries.map((prec) ->
    new PredictRecord({
      time_point: prec.timepoint
      cloud_cover: prec.cloudcover
      lifted_index: prec.lifted_index
      predict_type: prec.prec_type
      predict_amount: prec.prec_amount
      temperature_2m: prec.temp2m
      relative_humidity_2m: prec.rh2m.slice(0, -1)
      wind_direction_10m: prec.wind10m.direction
      wind_speed_10m: prec.wind10m.speed
      weather: prec.weather
    })
  )

  new LocationRecord({
    query_date: now.toUTCString()
    product_type: ret.product
    report_timepoint: new Date(
      parseInt(ret.init.slice(0, 4)),
      parseInt(ret.init.slice(4, 6)),
      parseInt(ret.init.slice(6, 8)),
      parseInt(ret.init.slice(8, 10))
    )
    prediction: prediction
  }).save()

  logger.debug('write record done')
  cb()
  return

exports.startPoll = ->
  poll = ->
    request.get({
      url: pollUrl
      json: true
      encoding: 'utf8'
      timeout: config.requestTimeout
    }, (err, res, json) ->
      if err
        requestErrorHandler(err, retry)
      else if res.statusCode != 200
        abnormalResponseHandler(res, retry)
      else
        writeRecord(json, pendingNextPoll)
      return
    )
    return
  retry = -> setTimeout((-> poll()), config.retryDelay)
  pendingNextPoll = -> setTimeout((-> poll()), config.pollInterval)

  poll()
  return

exports.clearTimers = -> timers.forEach((t) -> t and clearInterval(t))

module.exports = exports
