#include <Arduino.h>
#include <unity.h>
#include <Header.hpp>

// DHT11
#include <Adafruit_Sensor.h>
#include <DHT.h>
#include <DHT_U.h>

// void setUp(void)
// {
//   // set stuff up here
// }

// void tearDown(void)
// {
//   // clean stuff up here
// }

void setup()
{
  // NOTE!!! Wait for >2 secs
  // if board doesn't support software reset via Serial.DTR/RTS
  delay(2000);

  pinMode(LED_BUILTIN, OUTPUT);

  UNITY_BEGIN(); // IMPORTANT LINE!
}

void loop()
{
  // Test Arduino UNO leds
  RUN_TEST(test_led_builtin_pin_number);
  RUN_TEST(test_led_state_high);
  RUN_TEST(test_led_state_low);

  // DHT11
  // Data pin to pin 2
  initDHT11();
  RUN_TEST(test_temperature);
  RUN_TEST(test_humidity);

  // AirQualitySensor
  RUN_TEST(test_air_quality_sensor_is_connected);

  // LightSensor
  RUN_TEST(test_light_sensor_is_connected);

  // RainSensor
  RUN_TEST(test_rain_sensor_is_connected);

  // SIM800A
  RUN_TEST(test_if_modem_is_connected);

  UNITY_END(); // stop unit testing
}