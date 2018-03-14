// 4x4x4 RGB Cube with falling rain

// These Pins Connect to 74585's
int data = 2; 
int latch = 3;
int clock = 4;
// These Pins Connect to ULN2803
int Level1 = 5; 
int Level2 = 6; 
int Level3 = 7; 
int Level4 = 8; 

int rotate = 0;
int cycle = 0;
// stock up on random numbers
int rdata1 = random(96);
int rdata2 = random(96);
int rdata3 = random(96);
int rdata4 = random(96);

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
  // stock up on random numbers.
  for (int level=0; level <4; level++){
    for (int shift=0; shift <48; shift++){
      // data is inverted!
      digitalWrite(data, HIGH);
      // select the random number for the correct level
      if (level==0 and rdata1==shift) digitalWrite(data, LOW);
      if (level==1 and rdata2==shift) digitalWrite(data, LOW);
      if (level==2 and rdata3==shift) digitalWrite(data, LOW);
      if (level==3 and rdata4==shift) digitalWrite(data, LOW);
      digitalWrite(clock, LOW);    
      digitalWrite(clock, HIGH);    
    }
    // Turn the levels off
    digitalWrite(Level1, HIGH);
    digitalWrite(Level2, HIGH);
    digitalWrite(Level3, HIGH);
    digitalWrite(Level4, HIGH);
     //Latches in the new data
    digitalWrite(latch, LOW);    
    digitalWrite(latch, HIGH);    
    // Select the new level to turn on
    if (level==0)digitalWrite(Level1, LOW);   
    if (level==1)digitalWrite(Level2, LOW);   
    if (level==2)digitalWrite(Level3, LOW);   
    if (level==3)digitalWrite(Level4, LOW);   
    delay(2);
  } 
  // Rate of movement - one per 8 cycles
  rotate = rotate+1;
  if (rotate > 12) {
    rotate=0;
    // shift the random numbers down
    rdata4 = rdata3;
    rdata3 = rdata2;
    rdata2 = rdata1;
    rdata1 = random(48);
  }
}
