#include "libraries/Timer/Timer.h"

Timer timer;

int LED = 2;
int ledState = LOW;

void sendMeasurement(void *)
{
  String temp=String(random(5,35),DEC);
  String json=String("{ \"temp\": " + temp + " }");
  Serial.println(json);
}

void toggleLED(void *)
{
 if(ledState==LOW)
   ledState = HIGH;
 else
   ledState = LOW;

  digitalWrite(LED, ledState);
}

void setup()
{
  pinMode(LED, OUTPUT);
  timer.every(1000, sendMeasurement, 0);
  timer.every(350, toggleLED, 0);
  Serial.begin(115200);
  Serial.println("{ }");
}



void loop()
{
  timer.update();
}


