util = require('util')
request = require('request')
config = require('./config.js')
StationRecord = require('./model.js').StationRecord

pollTimer = null
timers = [pollTimer]

pollUrl = config.cityAllDetailJson + '?token=' + config.token

requestErrorHandler = (err, cb) ->
  logger.error('caught request error: %s', err.message)
  cb()
  return

abnormalResponseHandler = (res, cb) ->
  logger.error('api return code %s', res.statusCode)
  logger.debug('response body:')
  logger.debug(res.body)
  cb()
  return

returnErrorHandler = (ret, cb) ->
  logger.error('query failed, error: %s', ret.error)
  cb()
  return

writeResult = (result, cb) ->
  logger.debug(result)
  now = new Date()
  result.forEach((elt) ->
    new StationRecord({
      query_date: now.toUTCString()
      aqi: elt.aqi
      area: elt.area
      co: elt.co
      co_24h: elt.co_24h
      no2: elt.no2
      no2_24h: elt.no2_24h
      o3: elt.o3
      o3_24h: elt.o3_24h
      o3_8h: elt.o3_8h
      o3_8h_24h: elt.o3_8h_24h
      so2: elt.so2
      so2_24h: elt.so2_24h
      pm10: elt.pm10
      pm10_24h: elt.pm10_24h
      pm2_5: elt.pm2_5
      pm2_5_24h: elt.pm2_5_24h
      position_name: elt.position_name
      primary_pollutant: elt.primary_pollutant
      quality: elt.quality
      station_code: elt.station_code
      time_point: elt.time_point
    }).save()
    logger.info('%s: fetch data ok, write to database done', now.toUTCString())
    cb()
    return
  )

exports.startPoll = ->
  poll = ->
    request.get({
      url: pollUrl
      json: true
      encoding: 'utf8'
      timeout: config.requestTimeout
    }, (err, res, ret) ->
      if err
        requestErrorHandler(err, retry)
      else if res.statusCode != 200
        abnormalResponseHandler(res, retry)
      else if ret.error
        returnErrorHandler(ret, retry)
      else
        writeResult(ret, pendingNextPoll)
    )
    return
  retry = -> setTimeout((-> poll()), config.retryDelay)
  pendingNextPoll = -> setTimeout((-> poll()), config.pollInterval)

  poll()
  return

exports.clearTimers = -> timers.forEach((t) -> t and clearInterval(t))

module.exports = exports
