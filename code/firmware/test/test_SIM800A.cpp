#include <Arduino.h>
#include <unity.h>

#include <SoftwareSerial.h>
#define TINY_GSM_MODEM_SIM800 // Do not remove this line. It is used to select the correct modem by the TinyGSM library.
#include <TinyGsmClient.h>
#include <PubSubClient.h>

// SIM800A
SoftwareSerial SIM800A(9, 10); // RX, TX

TinyGsm modem(SIM800A);

void test_if_modem_is_connected()
{
    modem.restart();
    delay(2000);
    //  This doesnt seem to work :(
    String output = modem.getModemInfo();
    String expected = "SIM800 R14.18";

    TEST_ASSERT_EQUAL_STRING(expected.c_str(), output.c_str());
}