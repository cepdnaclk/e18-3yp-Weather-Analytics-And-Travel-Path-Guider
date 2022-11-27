const mqtt = require('mqtt')
const helper = require('./helper');
const { SensorData } = require('./models/SensorData');
function run() {
    // connect to mqtt broker
    const mqttClient = mqtt.connect(process.env.MQTT_URL, options = {
        clientId: process.env.MQTT_CLIENT_ID,
        username: process.env.MQTT_USERNAME,
        password: process.env.MQTT_PASSWORD,
        clean: true
    });

    // when connected to broker, subscribe to topic
    mqttClient.on('connect', function () {
        mqttClient.subscribe('test', function (err) {
            if (!err) {
                console.log("MQTT Connected");
            }
        })
    })


    // when a new msg arrives on mqtt
    mqttClient.on('message', function (topic, message) {
        // message is Buffer
        console.log(helper.getDateTime() + ": MQTT msg received: Topic: " + topic + ", message: " + message.toString())
        mqttClient.publish("confirm", "got the msg");

        // location: String,
        // device_id: String,
        // topic: String,
        // temperature: String,
        // humidity: String,
        // isRaining: Boolean,
        // lightIntensity: String,
        // windSpeed: String,
        // const msg = message.toString()
        const data = JSON.parse(message.toString())
        // console.log(data);
        new SensorData({
            'dateTime': helper.getDateTime(),
            ...data
        }).save();
    })
}

module.exports = { run } 