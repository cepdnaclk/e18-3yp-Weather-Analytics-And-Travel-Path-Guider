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
app.use(express.json()); // parse req body json

// routes
const home = require('./routes/root')
app.use('/', home);

const login = require('./routes/login')
app.use('/login', login);

// start web server
const port = process.env.PORT
app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})