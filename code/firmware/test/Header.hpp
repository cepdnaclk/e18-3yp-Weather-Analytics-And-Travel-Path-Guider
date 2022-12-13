#ifndef HEADER_HPP
#define HEADER_HPP

// Declarations

// UNO
void test_led_builtin_pin_number(void);
void test_led_state_high(void);
void test_led_state_low(void);

// DHT11
void initDHT11();
void test_temperature(void);
void test_humidity(void);

// AirQualitySensor
int AirQualitySensorReading();
int test_air_quality_sensor_is_connected(void);

// LightSensor
int lightSensorReading();
int test_light_sensor_is_connected(void);

// RainSensor
int RainSensorReading();
int test_rain_sensor_is_connected(void);

// SIM800A
int test_if_modem_is_connected(void);

#endif