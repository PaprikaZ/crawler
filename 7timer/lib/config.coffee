fs = require('fs')
path = require('path')
mkdirp = require('mkdirp')

appRoot = path.join(__dirname, '../')

appConfigFilePath = path.join(appRoot, 'config.json')
config = JSON.parse(fs.readFileSync(appConfigFilePath, 'utf8'))

config.logPath = path.join(appRoot, config.logPath)
config.logFile = path.join(config.logPath, config.logFile)

mkdirp.sync(config.logPath)
fs.closeSync(fs.openSync(config.logFile, 'a'))

logger = require('winston')
logger.add(logger.transports.File, {
  filename: config.logFile
  level: config.logLevel
})
global.logger = logger

[
  "pollInterval"
  "retryDelay"
  "requestTimeout"
].forEach((field) -> config[field] = config[field] * 1000)

config.locations = JSON.parse(fs.readFileSync(path.join(appRoot, config.queryLocationFile), 'utf8'))

module.exports = exports = config
