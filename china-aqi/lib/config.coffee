mkdirp = require('mkdirp')
path = require('path')
fs = require('fs')

appRoot = path.join(__dirname, '../')

appconfigFilePath = path.join(appRoot, 'config.json')
config = JSON.parse(fs.readFileSync(appconfigFilePath, 'utf8'))

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
  "cityPm25Json"
  "cityPm10Json"
  "cityCoJson"
  "cityNo2Json"
  "citySo2Json"
  "cityO3Json"
  "cityAqiDetailJson"
  "cityAqiJson"
  "cityStationNameJson"
  "cityNameJson"
  "cityAllDetailJson"
  "cityAqiRandingJson"
  "stationAqiJson"
].forEach((field) -> config[field] = [config.domain, config.queryPath, config[field]].join('/'))

[
  "pollInterval"
  "retryDelay"
  "requestTimeout"
].forEach((field) -> config[field] = config[field] * 1000)

config.pollInterval = Math.max((config.pollInterval - 300 * 1000), config.retryDelay)

module.exports = exports = config
