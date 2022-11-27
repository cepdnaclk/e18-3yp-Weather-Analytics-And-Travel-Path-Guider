const mongoose = require('mongoose');

const Schema = mongoose.Schema;

const SensorDataSchema = new Schema({
    dateTime: Date,
    location: String,
    device_id: String,
    topic: String,
    temperature: String,
    humidity: String,
    isRaining: Boolean,
    lightIntensity: String,
    windSpeed: String,
});

const SensorData = mongoose.model("SensorData", SensorDataSchema);

module.exports = { SensorData };