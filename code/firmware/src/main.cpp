#include <Arduino.h>
#include <Adafruit_Sensor.h>
#include <DHT.h>
#include <DHT_U.h>
#include <SoftwareSerial.h>

// DHT11
#define DHTPIN A3
#define DHTTYPE DHT11 // DHT 11
DHT_Unified dht(DHTPIN, DHTTYPE);

#define RainSensorPIN A0
#define LightSensorPIN A1
#define AirQualitySensorPIN A2

// SIM800A
SoftwareSerial SIM800A(9, 10);

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
}

void loop()
{
  // Serial.print("RainSensorPin: ");
  // Serial.println(analogRead(RainSensorPIN));
  // Serial.print("LightSensorPin: ");
  // Serial.println(analogRead(LightSensorPIN));
  // Serial.print("AirQualitySensorPin: ");
  // Serial.println(analogRead(AirQualitySensorPIN));

  if (SIM800A.available())
  { // Displays on the serial monitor if there's a communication from the module
    Serial.write(SIM800A.read());
  }

  // // Delay between measurements.
  // delay(delayMS);
}