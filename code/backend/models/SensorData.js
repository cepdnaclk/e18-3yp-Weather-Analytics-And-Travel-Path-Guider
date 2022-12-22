const mongoose = require('mongoose');

const Schema = mongoose.Schema;

const SensorDataSchema = new Schema({
    dateTime: String,
    location: String,
    device_id: String,
    topic: String,
    temperature: String,
    humidity: String,
    isRaining: String,
    lightIntensity: String,
    airQuality: String,
});

const SensorData = mongoose.model("SensorData", SensorDataSchema);

module.exports = { SensorData };