const mongoose = require('mongoose');

const Schema = mongoose.Schema;

const UsersSchema = new Schema({
    author: String,
    title: String,
    body: String
});

const UserModel = mongoose.model("Users", UsersSchema);

module.exports = { UserModel };