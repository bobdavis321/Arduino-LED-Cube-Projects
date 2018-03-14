// 8x8x8 RGB Cube with falling rain

// These Pins Connect to 74585's
int data = 11; 
int latch = 2;
int clock = 13;

int rotate = 0;
int cycle = 0;
// stock up on random numbers
int rdata1 = random(96);
int rdata2 = random(96);
int rdata3 = random(96);
int rdata4 = random(96);
int rdata5 = random(96);
int rdata6 = random(96);
int rdata7 = random(96);
int rdata8 = random(96);

// set up output pins
void setup() {
  pinMode(data, OUTPUT);
  pinMode(clock, OUTPUT);  
  pinMode(latch, OUTPUT);  
}

void loop() {
  // stock up on random numbers.
  for (int level=0; level <8; level++){
    for (int shift=0; shift <96; shift++){
      digitalWrite(data, LOW);
      // select the random number for the correct level
      if (level==0 and rdata1==shift) digitalWrite(data, HIGH);
      if (level==1 and rdata2==shift) digitalWrite(data, HIGH);
      if (level==2 and rdata3==shift) digitalWrite(data, HIGH);
      if (level==3 and rdata4==shift) digitalWrite(data, HIGH);
      if (level==4 and rdata5==shift) digitalWrite(data, HIGH);
      if (level==5 and rdata6==shift) digitalWrite(data, HIGH);
      if (level==6 and rdata7==shift) digitalWrite(data, HIGH);
      if (level==7 and rdata8==shift) digitalWrite(data, HIGH);      // Clocks in the new data
      digitalWrite(clock, LOW);    
      digitalWrite(clock, HIGH);    
    }
        for (int lshift=0; lshift <8; lshift++){
      digitalWrite(data, LOW);
      if (lshift == level) digitalWrite(data, HIGH);
      // Clocks in the level data
      digitalWrite(clock, LOW);    
      digitalWrite(clock, HIGH);    
    }

    // Turn the levels off
     //Latches in the new data
    digitalWrite(latch, LOW);    
    digitalWrite(latch, HIGH);    
    delay(.5);
  } 
  // Rate of movement - one per 8 cycles
  rotate = rotate+1;
  if (rotate > 7) {
    rotate=0;
    // shift the random numbers down
    rdata8 = rdata7;
    rdata7 = rdata6;
    rdata6 = rdata5;
    rdata5 = rdata4;
    rdata4 = rdata3;
    rdata3 = rdata2;
    rdata2 = rdata1;
    rdata1 = random(96);
  }
}
