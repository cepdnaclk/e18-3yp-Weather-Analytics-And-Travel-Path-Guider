#include <Arduino.h>
#include <unity.h>

#define LightSensorPIN A1

int lightSensorReading()
{
    Serial.print("LightSensorReading: ");
    int value = analogRead(LightSensorPIN);
    Serial.println(value);
    return value;
}

void test_light_sensor_is_connected(void)
{
    int first = lightSensorReading();
    delay(500);
    int second = lightSensorReading();

    int difference = abs(first - second);
    TEST_ASSERT_LESS_THAN(50, difference);
}