request = require('request')
config = require('./config.js')
model = require('./model.js')

timers = []


generateQueryUrl = (lat, lon) ->
  params = [
    'lat=' + config.lat
    'lon=' + config.lon
    'lang=' + config.queryLang,
    'unit=' + config.queryUnit,
    'output=' + config.queryOutput,
    'tzshift=' + config.queryTzshift,
  ].join('&')
  return config.domain + config.queryUri + config.queryType + params

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

returnErrorHandler = (json, cb) ->
  logger.debug('return error handler is empty')
  cb()
  return

writeRecord = (location, json) ->
  model.createCivilRecord(location, json)
  return

exports.startPoll = ->
  poll = ->
    cnt = 0
    total = config.locations.length

    sendReq = (locations) ->
      cnt += 1
      logger.info('request %s/%s', cnt, total)
      if locations.length != 0
        location = locations.shift()
        retry = -> setTimeout((-> sendReq([location])), config.retryDelay)
        request.get({
          url: generateQueryUrl(location.lat, location.lon)
          json: true
          encoding: 'utf8'
          timeout: config.requestTimeout
        }, (err, res, json) ->
          if err
            requestErrorHandler(err, retry)
          else if res.statusCode != 200
            abnormalResponseHandler(res, retry)
          else
            writeRecord(location, json)
          return
        )
        setTimeout((-> sendReq(locations)), config.requestInterval)
      else
        logger.info('all request done')
      return

    sendReq(config.locations.slice())
    return

  poll()
  timers.push(setInterval(poll, config.pollInterval))
  return

exports.clearTimers = -> timers.forEach((t) -> t and clearInterval(t))

module.exports = exports
