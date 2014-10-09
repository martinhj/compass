#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_LSM303_U.h>

Adafruit_LSM303_Mag_Unified mag = Adafruit_LSM303_Mag_Unified(12345);

void setup(void) {
  Serial.begin(115200);
  /*Serial.println("Magnetometer test"); Serial.println("");*/

  if (!mag.begin()) {
    Serial.println("Didn't find the LSM303 sensor. Check wiring.");
    while(1);
  }
}


void loop(void) {
  sensors_event_t event;
  mag.getEvent(&event);

  float Pi = 3.14159;


  float heading = (atan2(event.magnetic.y, event.magnetic.x) * 180) / Pi;

  if (heading < 0) {
    heading = 360 + heading;
  }
  //Serial.print("Compass heading: ");
  Serial.println(heading);
  /*delay(5);*/
}