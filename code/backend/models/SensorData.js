const mongoose = require('mongoose');

const Schema = mongoose.Schema;
const ObjectId = Schema.ObjectId;

const SensorDataSchema = new Schema({
    dateTime: Date,
    topic: String,
    msg: String
});

const SensorData = mongoose.model("SensorData", SensorDataSchema);

module.exports = { SensorData };