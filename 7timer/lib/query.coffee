request = require('request')
config = require('./config.js')
model = require('./model.js')

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

returnErrorHandler = (json, cb) ->
  logger.debug('return error handler is empty')
  cb()
  return

writeRecord = (json, cb) ->
  logger.debug(json)
  model.createCivilRecord(json)
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
