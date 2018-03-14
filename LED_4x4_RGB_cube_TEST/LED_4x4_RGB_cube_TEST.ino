// 4x4x4 RGB Cube testing all LED's

// These Pins Connect to 74585's
int data = 2; 
int latch = 3;
int clock = 4;
// These Pins Connect to TIP125's
int Level1 = 5; 
int Level2 = 6; 
int Level3 = 7; 
int Level4 = 8; 

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
}

void loop() {
  for (int level=0; level <4; level++){
    for (int shift=0; shift <48; shift++){
      // Remember data is inverted!
      digitalWrite(data, HIGH);
      if (rotate == 0){
        if (shift >= 0 and shift < 8){digitalWrite(data, LOW);}  
        if (shift > 23 and shift < 32){digitalWrite(data, LOW);}  
      }
      if (rotate == 1){
        if (shift > 7 and shift < 16){digitalWrite(data, LOW);}  
        if (shift > 31 and shift < 40){digitalWrite(data, LOW);}  
      }
      if (rotate == 2){
        if (shift > 15 and shift < 24){digitalWrite(data, LOW);}  
        if (shift > 39 and shift < 48){digitalWrite(data, LOW);}  
      }
      if (rotate == 3){digitalWrite(data, LOW);}  
        // Clocks in the new data
      digitalWrite(clock, LOW);    
      digitalWrite(clock, HIGH);    
    }
    // Turn the levels off
    // Remember its inverted for common anode!
    digitalWrite(Level1, HIGH);
    digitalWrite(Level2, HIGH);
    digitalWrite(Level3, HIGH);
    digitalWrite(Level4, HIGH);
    //Latch in the new data
    digitalWrite(latch, LOW);    
    digitalWrite(latch, HIGH);    
    // Select the new level to turn on
    if (level==0)digitalWrite(Level1, LOW);   
    if (level==1)digitalWrite(Level2, LOW);   
    if (level==2)digitalWrite(Level3, LOW);   
    if (level==3)digitalWrite(Level4, LOW);   
    delay(2);
  } 
  // Rate of movement - one per 50 cycles
  cycle=cycle+1;
  if (cycle == 50) {
    rotate = rotate+1;
  cycle = 0;
  }
  if (rotate > 4) rotate=0;
}
