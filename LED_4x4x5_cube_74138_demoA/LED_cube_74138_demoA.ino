// Arduino 4x4x4 LED Cube with 74138 demo
// store data onboard Arduino
#include <avr/pgmspace.h>
// Defining pins connected to cube
int LEDPin[16] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, A0, A1};
int LevelPin[3] = {A2, A3, A4};
// A5 is available for a switch or analog input

// Data array
byte Line[][16]= {
 {0,1,1,0,1,1,1,0,1,1,1,0,1,0,0,1},
 {1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1},
 {1,1,1,1,1,1,1,0,1,0,0,1,1,0,0,1},
 {1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1},
 {1,0,0,1,1,0,0,1,1,1,1,0,0,1,1,0},
 };

// Setup Arduino pins
void setup(){
  // Set 16 LED pins as outputs HIGH=lit
  for (int pin=0; pin < 16; pin++) {
    pinMode( LEDPin[pin], OUTPUT );
  }
  // Set Level pins as outputs LOW=lit
  for (int pin=0; pin < 3; pin++) {
    pinMode( LevelPin[pin], OUTPUT );
  }
}
int shift = 0;
int cycle = 0;
// Start the program
void loop(){
  // send data to LED's
  for (int level=0; level < 5; level++){
    for (int led=0; led < 16; led++){
      if (Line[level+shift][led] == 1){
        digitalWrite(LEDPin[led],HIGH);
      } else {
        digitalWrite(LEDPin[led],LOW);
    } }
    // Select the level looking at bits
    if bitRead(level, 0){
      digitalWrite(A2,HIGH);
    } else {
      digitalWrite(A2,LOW);
    }
    if bitRead(level, 1){
      digitalWrite(A3,HIGH);
    } else {
      digitalWrite(A3,LOW);
    }
    if bitRead(level, 2){
      digitalWrite(A4,HIGH);
    } else {
      digitalWrite(A4,LOW);
    }
    delay(3);
  }
  cycle = cycle+1;
  // Rate of movement - one per 25 cycles
  if (cycle == 25) {
//    shift = shift+1;
    if (shift > 4) shift=0;
    cycle = 0;
  }

}

