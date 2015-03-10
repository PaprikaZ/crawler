mongoose = require('mongoose')
config = require('./config.js')

StationRecordSchema = new mongoose.Schema({
  query_date: {
    type: Date
    required: true
  }
  aqi: {
    type: Number
    required: true
    min: 0
  }
  area: {
    type: String
    required: true
  }
  co: {
    type: Number
    required: true
    min: 0
  }
  co_24h: {
    type: Number
    required: true
    min: 0
  }
  no2: {
    type: Number
    required: true
    min: 0
  }
  no2_24h: {
    type: Number
    required: true
    min: 0
  }
  o3: {
    type: Number
    required: true
    min: 0
  }
  o3_24h: {
    type: Number
    required: true
    min: 0
  }
  o3_8h: {
    type: Number
    required: true
    min: 0
  }
  o3_8h_24h: {
    type: Number
    required: true
    min: 0
  }
  so2: {
    type: Number
    required: true
    min: 0
  }
  so2_24h: {
    type: Number
    required: true
    min: 0
  }
  pm10: {
    type: Number
    required: true
    min: 0
  }
  pm10_24h: {
    type: Number
    required: true
    min: 0
  }
  pm2_5: {
    type: Number
    required: true
    min: 0
  }
  pm2_5_24h: {
    type: Number
    required: true
    min: 0
  }
  position_name: {
    type: String
    required: true
  }
  primary_pollutant: [{
    type: String
    required: true
  }]
  quality: {
    type: String
    required: true
  }
  station_code: {
    type: String
    required: true
  }
  time_point: {
    type: Date
    required: true
  }
})

(mongoose.modelNames().indexOf('StationRecord') == -1) and
mongoose.model('StationRecord', StationRecordSchema)

module.exports = exports = {
  StationRecord: mongoose.model('StationRecord')
}
