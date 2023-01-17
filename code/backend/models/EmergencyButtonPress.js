const mongoose = require('mongoose');

const Schema = mongoose.Schema;

const EmergencyButtonPress = new Schema({
    dateTime: String,
    location: String,
    device_id: String
});

const SensorData = mongoose.model("EmergencyButtonPress", EmergencyButtonPress);
module.exports = { SensorData };