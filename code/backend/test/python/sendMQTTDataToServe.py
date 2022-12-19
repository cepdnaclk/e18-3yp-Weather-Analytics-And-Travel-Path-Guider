## Author: E/18/098 Ishan Fernando - e18098@eng.pdn.ac.lk

import paho.mqtt.client as paho  ## pip install paho-mqtt
from dotenv import load_dotenv  ## pip intsall python-dotenv
import os
import json
import datetime
import time

load_dotenv("../../.env")

broker = "weatheranalytics.tk"
port = 1883


def on_publish(client, userdata, result):  # create function for callback
    print("data published " + datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
    pass


client1 = paho.Client("control1")  # create client object
client1.on_publish = on_publish  # assign function to callback
client1.username_pw_set(os.environ.get("MQTT_USERNAME"), os.getenv("MQTT_PASSWORD"))
print(os.environ.get("MQTT_USERNAME"), os.getenv("MQTT_PASSWORD"))

client1.connect(broker, port)  # establish connection

# ret = client1.publish("test", "on")  # publish

while True:
    data = {}

    # need to send only the data we need. here only a sample is sent
    # location: String,
    # device_id: String,
    # topic: String,
    # temperature: String,
    # humidity: String,
    # isRaining: Boolean,
    # lightIntensity: String,
    # windSpeed: String,
    data["location"] = "Ridma's Macbook"
    data["device_id"] = 0
    data["topic"] = "test"
    data["temperature"] = 30
    data["humidity"] = 80
    data["isRaining"] = 1
    data["lightIntensity"] = 125
    data["windSpeed"] = 125
    data["time"] = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    print(len(json.dumps(data)))
    client1.publish("test", json.dumps(data))
    time.sleep(5)
