const mongoose = require('mongoose');

const Schema = mongoose.Schema;

const UsersSchema = new Schema({
    email: String,
    password: String,
    name: String,
    addSomeOtherData: String
});

const UserModel = mongoose.model("Users", UsersSchema);

module.exports = { UserModel };