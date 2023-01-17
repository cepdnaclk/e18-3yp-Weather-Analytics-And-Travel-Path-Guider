const mongoose = require('mongoose');

const Schema = mongoose.Schema;

const EmergencyButtonPressSchema = new Schema({
    dateTime: String,
    location: String,
    device_id: String
});

const EmergencyButtonPress = mongoose.model("EmergencyButtonPress", EmergencyButtonPressSchema);
module.exports = { EmergencyButtonPress };