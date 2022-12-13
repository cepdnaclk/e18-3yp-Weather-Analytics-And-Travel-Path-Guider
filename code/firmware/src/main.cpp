#include <Arduino.h>
#include <Adafruit_Sensor.h>
#include <DHT.h>
#include <DHT_U.h>
#include <SoftwareSerial.h>
#define TINY_GSM_MODEM_SIM800 // Do not remove this line. It is used to select the correct modem by the TinyGSM library.
#include <TinyGsmClient.h>
#include <PubSubClient.h>

// DHT11
#define DHTPIN A3
#define DHTTYPE DHT11 // DHT 11
DHT_Unified dht(DHTPIN, DHTTYPE);

#define RainSensorPIN A0
#define LightSensorPIN A1
#define AirQualitySensorPIN A2

// SIM800A
SoftwareSerial SIM800A(9, 10); // RX, TX

// Network details
const char apn[] = "mobitel";
const char user[] = "";
const char pass[] = "";

// MQTT details
const char *broker = "weatheranalytics.tk";
const char *topicOut = "test";
// const char *topicIn = "test";

TinyGsm modem(SIM800A);
TinyGsmClient client(modem);
PubSubClient mqtt(client);

int RainSensorReading()
{
  Serial.print("RainSensorReading: ");
  int value = analogRead(RainSensorPIN);
  Serial.println(value);
  return value;
}

int LightSensorReading()
{
  Serial.print("LightSensorReading: ");
  int value = analogRead(LightSensorPIN);
  Serial.println(value);
  return value;
}

int AirQualitySensorReading()
{
  Serial.print("AirQualitySensorReading: ");
  int value = analogRead(AirQualitySensorPIN);
  Serial.println(value);
  return value;
}

int TemperatureReading()
{
  sensors_event_t event;
  dht.temperature().getEvent(&event);
  return event.temperature;
}

int HumidityReading()
{
  sensors_event_t event;
  dht.humidity().getEvent(&event);
  return event.relative_humidity;
}

boolean mqttConnect()
{
  if (!mqtt.connect("GsmClientTest", "weather-data", "nipunonazure@123@"))
  {
    Serial.print(".");
    return false;
  }
  Serial.println("Connected to broker.");
  // mqtt.subscribe(topicIn); // no need to subscribe
  return mqtt.connected();
}

// not used as we are not subsribing to any topic
void mqttCallback(char *topic, byte *payload, unsigned int len)
{
  Serial.print("Message receive: ");
  Serial.write(payload, len);
  Serial.println();
}

void sendSMS()
{
  Serial.println("Sending SMS..."); // Show this message on serial monitor
  SIM800A.print("AT+CMGF=1\r");     // Set the module to SMS mode
  delay(100);
  SIM800A.print("AT+CMGS=\"+94775610102\"\r"); // Your phone number don't forget to include your country code, example +212123456789"
  delay(500);
  SIM800A.print("SIM800A is working"); // This is the text to send to the phone number, don't make it too long or you have to modify the SoftwareSerial buffer
  delay(500);
  SIM800A.print((char)26); // (required according to the datasheet)
  delay(500);
  SIM800A.println();
  Serial.println("Text Sent.");
  delay(500);
}

void setup()
{
  Serial.begin(9600);
  SIM800A.begin(9600); // Module baude rate, this is on max, it depends on the version

  // DHT11
  dht.begin();
  sensor_t sensor;
  dht.temperature().getSensor(&sensor);

  // Rain Sensor
  pinMode(RainSensorPIN, INPUT);

  // Light Sensor
  pinMode(LightSensorPIN, INPUT);

  // Air Quality Sensor
  pinMode(AirQualitySensorPIN, INPUT);

  Serial.println("System start.");
  modem.restart();
  Serial.println("Modem: " + modem.getModemInfo());
  Serial.println("Searching for Mobitel provider.");
waitForNetwork:
  if (!modem.waitForNetwork())
  {
    Serial.println("Failed. Retrying...");
    goto waitForNetwork;
  }
  Serial.println("Connected to Mobitel.");
  Serial.println("Signal Quality: " + String(modem.getSignalQuality()));

  Serial.println("Connecting to GPRS network.");

ConnectToGPRS:
  if (!modem.gprsConnect(apn, user, pass))
  {
    Serial.println("Failed. Retrying...");
    goto ConnectToGPRS;
  }

  Serial.println("Connected to GPRS: " + String(apn));

  mqtt.setServer(broker, 1883);
  // mqtt.setCallback(mqttCallback);
  Serial.println("Connecting to MQTT Broker: " + String(broker));
  while (mqttConnect() == false)
    continue;
  Serial.println("Connected");
}

void loop()
{
  // Serial.print("RainSensorPin: ");
  // Serial.println(analogRead(RainSensorPIN));
  // Serial.print("LightSensorPin: ");
  // Serial.println(analogRead(LightSensorPIN));
  // Serial.print("AirQualitySensorPin: ");
  // Serial.println(analogRead(AirQualitySensorPIN));

  delay(2000);
  String msg = "{\"location\" : \"Ridmas Macbook\", \"device_id\" : 0, \"topic\" : \"test\", \"temperature\" : 30, \"humidity\" : 80, \"isRaining\" : 1, \"lightIntensity\" : 125, \"windSpeed\" : 125, \"time\" : \"2022-12-13 11:14:20\"}";
  mqtt.publish(topicOut, msg.c_str());
  Serial.println("sent");

  if (mqtt.connected())
  {
    mqtt.loop();
  }

  // // Delay between measurements.
  // delay(delayMS);
}