#include <Arduino.h>
#include <unity.h>

#define RainSensorPIN A0

int RainSensorReading()
{
    Serial.print("RainSensorReading: ");
    int value = analogRead(RainSensorPIN);
    Serial.println(value);
    return value;
}

void test_rain_sensor_is_connected()
{
    int first = RainSensorReading();
    delay(500);
    int second = RainSensorReading();

    int difference = abs(first - second);
    TEST_ASSERT_LESS_THAN(50, difference);
}