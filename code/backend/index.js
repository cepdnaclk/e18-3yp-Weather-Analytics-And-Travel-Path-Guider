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

const signup = require('./routes/signup')
app.use('/signup', signup);

const seed = require('./routes/seed')
app.use('/seed', seed);

// v1
const latestReading = require('./routes/v1/latestReading')
const emergencyButton = require('./routes/v1/emergency');
app.use('/v1', latestReading);
app.use('/v1',emergencyButton);

// start web server
const port = process.env.PORT
app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})