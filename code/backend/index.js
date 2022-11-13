const express = require('express')
const mqtt = require('mqtt')
require('dotenv').config()

const app = express()
const port = process.env.PORT

// connect to mqtt broker
const mqttClient = mqtt.connect(process.env.MQTT_URL, options = {
  clientId: process.env.CLIENT_ID,
  username: process.env.USERNAME,
  password: process.env.PASSWORD,
  clean: true
});

data = {}


app.get('/', (req, res) => {
  res.send(data);
  console.log('Page requested ' + req.url);
})

// when connected to broker, subscribe to topic
mqttClient.on('connect', function () {
  mqttClient.subscribe('test', function (err) {
    if (!err) {
      console.log("MQTT Connected");
    }
  })
})

let count = 0;

// when a new msg arrives on mqtt
mqttClient.on('message', function (topic, message) {
  // message is Buffer
  data[topic + count++] = message.toString()
  console.log(topic, message.toString())
})

// start web server
app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})