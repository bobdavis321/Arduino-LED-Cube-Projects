// 8x8x8 RGB Cube testing all LED's

// These Pins Connect to 74585's
int data = 2; 
int latch = 3;
int clock = 4;
// These Pins Connect to ULN2003
int Level1 = 5; 
int Level2 = 6; 
int Level3 = 7; 
int Level4 = 8; 
int Level5 = 9; 
int Level6 = 10; 
int Level7 = 11; 
int Level8 = 12; 

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
  pinMode(Level6, OUTPUT);
  pinMode(Level7, OUTPUT);
  pinMode(Level8, OUTPUT);
}

void loop() {
  for (int level=0; level <8; level++){
    for (int shift=0; shift <96; shift++){
      digitalWrite(data, LOW);
      if (rotate == 0){
        if (shift >= 0 and shift < 8){digitalWrite(data, HIGH);}  
        if (shift > 23 and shift < 32){digitalWrite(data, HIGH);}  
        if (shift > 47 and shift < 56){digitalWrite(data, HIGH);}  
        if (shift > 71 and shift < 80){digitalWrite(data, HIGH);}  
      }
      if (rotate == 1){
        if (shift > 7 and shift < 16){digitalWrite(data, HIGH);}  
        if (shift > 31 and shift < 40){digitalWrite(data, HIGH);}  
        if (shift > 55 and shift < 64){digitalWrite(data, HIGH);}  
        if (shift > 79 and shift < 88){digitalWrite(data, HIGH);}  
      }
      if (rotate == 2){
        if (shift > 15 and shift < 24){digitalWrite(data, HIGH);}  
        if (shift > 39 and shift < 48){digitalWrite(data, HIGH);}  
        if (shift > 63 and shift < 72){digitalWrite(data, HIGH);}  
        if (shift > 87 and shift < 96){digitalWrite(data, HIGH);}  
      }
      if (rotate == 3){digitalWrite(data, HIGH);}  
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
    digitalWrite(Level6, LOW);
    digitalWrite(Level7, LOW);
    digitalWrite(Level8, LOW);
     //Latches in the new data
    digitalWrite(latch, LOW);    
    digitalWrite(latch, HIGH);    
    // Select the new level to turn on
    if (level==0)digitalWrite(Level1, HIGH);   
    if (level==1)digitalWrite(Level2, HIGH);   
    if (level==2)digitalWrite(Level3, HIGH);   
    if (level==3)digitalWrite(Level4, HIGH);   
    if (level==4)digitalWrite(Level5, HIGH);   
    if (level==5)digitalWrite(Level6, HIGH);   
    if (level==6)digitalWrite(Level7, HIGH);   
    if (level==7)digitalWrite(Level8, HIGH);   
    delay(.5);
  } 
  // Rate of movement - one per 50 cycles
  cycle=cycle+1;
  if (cycle == 50) {
    rotate = rotate+1;
  cycle = 0;
  }
  if (rotate > 4) rotate=0;
}
