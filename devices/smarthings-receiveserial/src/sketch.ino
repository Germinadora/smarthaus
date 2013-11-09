
int byteReceived = 0;
int ledState = LOW;
int ledPin = 2;

void setup()
{
    Serial.begin(115200);
    pinMode(ledPin, OUTPUT);
}

void loop()
{
    if (Serial.available() > 0)
    {
        byteReceived = Serial.read();
        Serial.println(byteReceived, DEC);
        if (ledState == LOW)
        {
            ledState = HIGH;
        }
        else
        {
            ledState = LOW;
        }
        digitalWrite(ledPin, ledState);
    }
    delay(1000);
}
