mongoose = require('mongoose')
config = require('./config.js')

PredictRecordSchema = new mongoose.Schema({
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

LocationRecordSchema = new mongoose.Schema({
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
  prediction: [ PredictRecordSchema ]
})

(mongoose.modelNames().indexOf('PredictRecord') == -1) and
  mongoose.model('PredictRecord', PredictRecordSchema)
(mongoose.modelNames().indexOf('LocationRecord') == -1) and
  mongoose.model('LocationRecord', LocationRecordSchema)

module.exports = exports = {
  PredictRecord: mongoose.model('PredictRecord')
  LocationRecord: mongoose.model('LocationRecord')
}
