// if enter == 1: digital ouput 12 ==1
// if enter == 0: digital ouput 12 ==0
// digitalWrite(12, HIGH); // sets the digital pin 12 on
// digitalWrite(12, LOW);  // sets the digital pin 12 off
#include <Arduino.h>

#define BAUD_RATE 115200
#define LED_PIN 12


int data = '1';   // temp storage

void setup() {
    pinMode(LED_PIN, OUTPUT);
    Serial.begin(BAUD_RATE); // create connection
    Serial.println("Initiating board...");
}


void loop() {
    if (Serial.available() > 0) {  // if serial available
        data = Serial.read();  // read byte
        // Serial.println(data, BIN);
        
        if (data == '1'){
            digitalWrite(LED_PIN,HIGH);
            Serial.println("on.");
//            digitalWrite(LED_PIN, HIGH);
        }
        if (data == '0'){
            digitalWrite(LED_PIN,LOW);
            Serial.println("off.");
//            digitalWrite(LED_PIN, LOW);
        }
    }
}

// 
// digitalWrite(LED_PIN, LOW);  // 12 gets OFF (0/LOW/0V/GND)

