mongoose = require('mongoose')
config = require('./config.js')

mongoErrorHanlder = (err) ->
  logger.error('mongodb connection caught error')
  logger.error('msg: %s', err.message)
  throw err

connection = mongoose.connection
connection.on('error', mongoErrorHanlder)
connection.on('open', -> logger.info('mongodb connection established'))
connection.on('close', -> logger.info('mongodb connection closed'))
connection.on('reconnected', -> logger.warn('mongodb connection reconnected'))

mongoClient = null
exports.connectMongoDB = ->
  mongoClient = mongoose.connect(config.mongoUrl, config.mongoConnectionOptions)
  return

exports.getMongoClient = ->
  if mongoClient
    return mongoClient
  else
    logger.error('mongo client should be created before use')
    throw new Error('mongodb client not initialized')

module.exports = exports
