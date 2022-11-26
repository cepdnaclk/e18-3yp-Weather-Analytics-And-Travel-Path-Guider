const mongoose = require('mongoose');

const Schema = mongoose.Schema;

const UsersSchema = new Schema({
    email: {
        type: String,
        required: [true, 'Email is required'],
    },
    password: {
        type: String,
        required: [true, 'Password is required'],
    },
    name: String,
    addSomeOtherData: String
});

const Users = mongoose.model("Users", UsersSchema);

module.exports = { Users };