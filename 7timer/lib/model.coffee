mongoose = require('mongoose')
config = require('./config.js')

CivilPredictionSchema = new mongoose.Schema({
  time_point: {
    type: Number
    required: true
    min: 0
    max: 192
  }
  cloud_cover: {
    type: Number
    required: true
    min: 1
    max: 9
  }
  lifted_index: {
    type: Number
    required: true
    min: -10
    max: 15
  }
  predict_type: {
    type: String
    required: true
    trim: true
    enum: ['snow', 'rain', 'frzr', 'icep', 'none']
  }
  predict_amount: {
    type: Number
    required: true
    min: 0
    max: 9
  }
  temperature_2m: {
    type: Number
    required: true
    min: -76
    max: 60
  }
  relative_humidity_2m: {
    type: Number
    required: true
    min: 0
    max: 100
  }
  wind_direction_10m: {
    type: String
    required: true
    trim: true
    enum: ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW']
  }
  wind_speed_10m: {
    type: Number
    required: true
    min: 1
    max: 8
  }
  weather: {
    type: String
    required: true
    trim: true
    enum: [
      'clearday', 'clearnight',
      'pcloudyday', 'pcloudynight',
      'mcloudyday', 'mcloudynight',
      'cloudyday', 'cloudynight',
      'humidday', 'humidnight',
      'lightrainday', 'lightrainnight',
      'oshowerday', 'oshowernight',
      'ishowerday', 'ishowernight',
      'lightsnowday', 'lightsnownight',
      'rainday', 'rainnight',
      'snowday', 'snownight',
      'rainsnowday', 'rainsnownight',
      'tsday', 'tsnight',
      'tsrainday', 'tsrainnight'
    ]
  }
})

CivilRecordSchema = new mongoose.Schema({
  query_date: {
    type: Date
    required: true
  }
  product_type: {
    type: String
    required: true
    trim: true
  }
  report_timepoint: {
    type: Date
    required: true
  }
  prediction: [ CivilPredictionSchema ]
})

(mongoose.modelNames().indexOf('CivilPrediction') == -1) and
  mongoose.model('CivilPrediction', CivilPredictionSchema)
(mongoose.modelNames().indexOf('CivilRecord') == -1) and
  mongoose.model('CivilRecord', CivilRecordSchema)

CivilPrediction = mongoose.model('CivilPrediction')
CivilRecord = mongoose.model('CivilRecord')

createCivilRecord = (json) ->
  now = new Date()
  prediction = json.dataseries.map((prec) ->
    new CivilPrediction({
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

  new CivilRecord({
    query_date: now.toUTCString()
    product_type: json.product
    report_timepoint: new Date(
      parseInt(json.init.slice(0, 4)),
      parseInt(json.init.slice(4, 6)),
      parseInt(json.init.slice(6, 8)),
      parseInt(json.init.slice(8, 10))
    )
    prediction: prediction
  }).save()

  logger.debug('write civil record done')
  return

module.exports = exports = {
  createCivilRecord: createCivilRecord
}
