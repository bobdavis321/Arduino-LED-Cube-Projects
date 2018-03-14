// Arduino 4x4x4 LED Cube with 74138 demo
// store data onboard Arduino
#include <avr/pgmspace.h>
// Defining pins connected to cube
int LEDPin[16] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, A0, A1};
int LevelPin[4] = {A2, A3, A4};

// Data arrays
byte Line[][16]= {
 {0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0},
 {1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1},
 {0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0},
 {0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0},
 {0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0},
 {0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0},
 {1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1},
 {0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0},
 {0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0},
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
  for (int led=0; led < 16; led++){
    if (Line[0+shift][led] == 1){
      digitalWrite(LEDPin[led],HIGH);
    } else {
      digitalWrite(LEDPin[led],LOW);
  } }
  digitalWrite(A2,LOW);
  digitalWrite(A3,LOW);
  digitalWrite(A4,LOW);
  delay(3);
  for (int led=0; led < 16; led++){
    if (Line[1+shift][led] == 1){
      digitalWrite(LEDPin[led],HIGH);
    } else {
      digitalWrite(LEDPin[led],LOW);
  } }
  digitalWrite(A2,HIGH);
  digitalWrite(A3,LOW);
  digitalWrite(A4,LOW);
  delay(3);
  for (int led=0; led < 16; led++){
    if (Line[2+shift][led] == 1){
      digitalWrite(LEDPin[led],HIGH);
    } else {
      digitalWrite(LEDPin[led],LOW);
  } }
  digitalWrite(A2,LOW);
  digitalWrite(A3,HIGH);
  digitalWrite(A4,LOW);
  delay(3);
  for (int led=0; led < 16; led++){
    if (Line[3+shift][led] == 1){
      digitalWrite(LEDPin[led],HIGH);
    } else {
      digitalWrite(LEDPin[led],LOW);
  } }
  digitalWrite(A2,HIGH);
  digitalWrite(A3,HIGH);
  digitalWrite(A4,LOW);
  delay(3);
  for (int led=0; led < 16; led++){
    if (Line[4+shift][led] == 1){
      digitalWrite(LEDPin[led],HIGH);
    } else {
      digitalWrite(LEDPin[led],LOW);
  } }
  digitalWrite(A2,LOW);
  digitalWrite(A3,LOW);
  digitalWrite(A4,HIGH);
  delay(3);
  cycle = cycle+1;
  // Rate of movement one per 25 cycles
  if (cycle == 25) {
    shift = shift+1;
    cycle = 0;
  }
  if (shift > 4) shift=0;
}

