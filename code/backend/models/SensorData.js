const mongoose = require('mongoose');

const Schema = mongoose.Schema;

const SensorDataSchema = new Schema({
    dateTime: Date,
    topic: String,
    msg: String,
    sensorType: String
});

const SensorData = mongoose.model("SensorData", SensorDataSchema);

module.exports = { SensorData };