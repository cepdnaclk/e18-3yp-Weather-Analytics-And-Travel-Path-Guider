const express = require('express')
const mqtt = require('./mqtt')
const db = require('./db')
require('dotenv').config()


// db
db.connectDB();

// mqtt
mqtt.run();

// express
const app = express()

const home = require('./routes/root')
app.use('/', home);

// start web server
const port = process.env.PORT
app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})