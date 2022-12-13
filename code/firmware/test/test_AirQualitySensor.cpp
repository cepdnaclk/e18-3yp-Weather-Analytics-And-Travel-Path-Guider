#include <Arduino.h>
#include <unity.h>

#define AirQualitySensorPIN A2

int AirQualitySensorReading()
{
    Serial.print("AirQualitySensorReading: ");
    int value = analogRead(AirQualitySensorPIN);
    Serial.println(value);
    return value;
}

void test_air_quality_sensor_is_connected(void)
{
    int first = AirQualitySensorReading();
    delay(500);
    int second = AirQualitySensorReading();

    int difference = abs(first - second);
    TEST_ASSERT_LESS_THAN(100, difference);
}