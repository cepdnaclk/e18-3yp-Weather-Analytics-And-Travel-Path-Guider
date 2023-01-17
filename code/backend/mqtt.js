const mqtt = require("mqtt");
const helper = require("./helper");
const { SensorData } = require("./models/SensorData");
const { EmergencyButtonPress } = require("./models/EmergencyButtonPress");
function run() {
  // connect to mqtt broker
  const mqttClient = mqtt.connect(
    process.env.MQTT_URL,
    (options = {
      clientId: process.env.MQTT_CLIENT_ID,
      username: process.env.MQTT_USERNAME,
      password: process.env.MQTT_PASSWORD,
      clean: true,
    })
  );

  // when connected to broker, subscribe to topic
  mqttClient.on("connect", function () {
    mqttClient.subscribe("test", function (err) {
      if (!err) {
        console.log("MQTT Connected");
      }
    });
  });

  // when a new msg arrives on mqtt
  mqttClient.on("message", function (topic, message) {
    // message is Buffer
    console.log(
      helper.getDateTime() +
        ": MQTT msg received: Topic: " +
        topic +
        ", message: " +
        message.toString()
    );
    if (topic == "test") {
      try {
        // MQTT msg  format
        // id,temp,humidity,rainSensor,lightSensor,airQualitySensor
        const splitted = message.toString().split(",");
        const id = splitted[0];
        const temp = splitted[1];
        const humidity = splitted[2];
        const rain = splitted[3];
        const light = splitted[4];
        const air = splitted[5];

        // console.log(splitted)
        new SensorData({
          dateTime: helper.getDateTime(),
          location: "hanthana",
          device_id: id,
          topic: "test",
          temperature: temp,
          humidity: humidity,
          isRaining: rain,
          lightIntensity: light,
          airQuality: air,
        }).save();
      } catch (error) {
        console.log("Error parsing JSON: " + error);
      }
    } else if (topic == "emergency") {
      try {
        new EmergencyButtonPress({
          dateTime: helper.getDateTime(),
          location: "hanthana",
          device_id: "1",
        }).save();
      } catch (error) {
        console.log("Error parsing JSON: " + error);
      }
    }
  });
}

module.exports = { run };
