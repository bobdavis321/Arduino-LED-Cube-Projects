// LED Cube with 74595's and ULN2003 sound demo

// These Pins Connect to 74585's
int data = 2; 
int clock = 3;
int latch = 4;
// These Pins Connect to ULN2003
int Level1 = 5; 
int Level2 = 6; 
int Level3 = 7; 
int Level4 = 8; 
int Level5 = 9; 

int rotate = 0;
int cycle = 0;

// set up output pins
void setup() {
  pinMode(data, OUTPUT);
  pinMode(clock, OUTPUT);  
  pinMode(latch, OUTPUT);  
  pinMode(Level1, OUTPUT);
  pinMode(Level2, OUTPUT); 
  pinMode(Level3, OUTPUT);
  pinMode(Level4, OUTPUT);
  pinMode(Level5, OUTPUT);
}

void loop() {
  for (int level=0; level <5; level++){
    // collect audio samples
    int input1=analogRead(0)/16;
    for (int shift=0; shift <16; shift++){
      if (shift < input1){
        digitalWrite(data, HIGH);
      } else {
        digitalWrite(data, LOW);
      }
      // Clocks in the new data
      digitalWrite(clock, LOW);    
      digitalWrite(clock, HIGH);    
    }
    // Turn the levels off
    digitalWrite(Level1, LOW);
    digitalWrite(Level2, LOW);
    digitalWrite(Level3, LOW);
    digitalWrite(Level4, LOW);
    digitalWrite(Level5, LOW);
    //Latches in the new data
    digitalWrite(latch, LOW);    
    digitalWrite(latch, HIGH);    
    // Select the new level to turn on
    if (level==0)digitalWrite(Level1, HIGH);   
    if (level==1)digitalWrite(Level2, HIGH);   
    if (level==2)digitalWrite(Level3, HIGH);   
    if (level==3)digitalWrite(Level4, HIGH);   
    if (level==4)digitalWrite(Level5, HIGH);   
    delay(3);
  } 
}
