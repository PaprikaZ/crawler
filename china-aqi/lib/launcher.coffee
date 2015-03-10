db = require('./db.js')
query = require('./query.js')

module.exports.launch = ->
  process.on('SIGINT', ->
    logger.info('Caught SIGINT, try cancelling polling timers')
    query.clearTimers()
    setTimeout((-> process.exit(1)), 1000)
    return
  )

  db.connectMongoDB()
  setTimeout((-> query.startPoll()), 1000)
  return
