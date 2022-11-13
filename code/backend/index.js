const express = require('express')
const mqtt = require('./mqtt')
const mongoose = require('mongoose');
require('dotenv').config()

const port = process.env.PORT

// db
mongoose.connect(process.env.MONGO_URL);
const db = mongoose.connection;
db.on("error", console.error.bind(console, "MongoDB connection error:"));

// mqtt
mqtt.run();

// express
const app = express()

const home = require('./routes/root')
app.use('/', home);

// start web server
app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})