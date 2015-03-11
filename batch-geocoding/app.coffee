fs = require('fs')
path = require('path')
request = require('request')

appRoot = __dirname

appConfigFilePath = path.join(appRoot, 'config.json')
config = JSON.parse(fs.readFileSync(appConfigFilePath, 'utf8'))

(->
  config.batchFilePath = path.join(appRoot, config.batchFilePath)
  config.outputFilePath = path.join(appRoot, config.outputFilePath)
  return
)()

genRequestUrl = (addr) ->
  params = '?address=' + addr + '&sensor=' + config.defaultSensor
  return config.googleMapsDomain + config.geocodingUri + config.defaultOutput + params

requestAPIUrls = JSON.parse(fs.readFileSync(config.batchFilePath, 'utf8')).map(genRequestUrl)
total = requestAPIUrls.length

count = 0
result = []
batchQuery = (urls) ->
  count += 1
  if urls.length != 0
    request.get({
      url: urls.shift()
      json: true
      encoding: 'utf8'
      timeout: 10000
    }, (err, res, json) ->
      if err
        throw err
      else if res.statusCode != 200
        console.log('response status code unexpected, %s', res.statusCode)
        console.log('response body:')
        console.log(res.body)
      else
        console.log('coding %s/%s', count, total)
        result.push(json)
        setTimeout((-> batchQuery(urls)), config.requestInterval)
      return
    )
  else
    console.log('batch geocoding done.')
    fs.writeFileSync(config.outputFilePath, JSON.stringify(result))
  return

batchQuery(requestAPIUrls)
