// 8x8x8 RGB Cube demo of different patterns

// These Pins Connect to all 74585's
// Note pin change for compatability
int data = 11; 
int latch = 2;
int clock = 13;
int rotate = 0;
int cycle = 0;
// stock up on random numbers
int rdata1 = random(192);
int rdata2 = random(192);
int rdata3 = random(192);
int rdata4 = random(192);
int rdata5 = random(192);
int rdata6 = random(192);
int rdata7 = random(192);
int rdata8 = random(192);

// set up output pins
void setup() {
  pinMode(data, OUTPUT);
  pinMode(clock, OUTPUT);  
  pinMode(latch, OUTPUT);  
}

void loop() {
for (int tdelay=0; tdelay<400; tdelay++){
  for (int level=0; level <8; level++){
    for (int shift=0; shift <192; shift++){
      digitalWrite(data, LOW);
      int dshift=shift/8;
      if (rotate == 0){
        if (dshift==0 or dshift==3 or dshift==6 or dshift==9)digitalWrite(data, HIGH);  
        if (dshift==12 or dshift==15 or dshift==18 or dshift==21)digitalWrite(data, HIGH);  
      }
      if (rotate == 1){
        if (shift/8==1 or dshift==4 or dshift==7 or dshift==10)digitalWrite(data, HIGH);  
        if (shift/8==13 or dshift==16 or dshift==19 or dshift==22)digitalWrite(data, HIGH);  
      }
      if (rotate == 2){
        if (shift/8==2 or dshift==5 or dshift==8 or dshift==11)digitalWrite(data, HIGH);  
        if (shift/8==14 or dshift==17 or dshift==20 or dshift==23)digitalWrite(data, HIGH);  
      }
      if (rotate == 3){digitalWrite(data, HIGH);}  
      // Clock in the new data
      digitalWrite(clock, LOW); digitalWrite(clock, HIGH);    
    }
    for (int lshift=0; lshift <8; lshift++){
      digitalWrite(data, LOW);
      if (lshift == level) digitalWrite(data, HIGH);
      // Clocks in the level data
      digitalWrite(clock, LOW); digitalWrite(clock, HIGH);    
    }
    //Latch and display the new data
    digitalWrite(latch, LOW); digitalWrite(latch, HIGH);    
  } 
  // Rate of movement - one per 100 cycles
  cycle=cycle+1;
  if (cycle == 100) {
    rotate = rotate+1;
  cycle = 0;
  }
  if (rotate > 3) rotate=0;
}
for (int tdelay=0; tdelay<300; tdelay++){
  for (int level=0; level <8; level++){
    for (int shift=0; shift <192; shift++){
      digitalWrite(data, LOW);
      // select the random number for the correct level
      if (level==0 and rdata1==shift) digitalWrite(data, HIGH);
      if (level==1 and rdata2==shift) digitalWrite(data, HIGH);
      if (level==2 and rdata3==shift) digitalWrite(data, HIGH);
      if (level==3 and rdata4==shift) digitalWrite(data, HIGH);
      if (level==4 and rdata5==shift) digitalWrite(data, HIGH);
      if (level==5 and rdata6==shift) digitalWrite(data, HIGH);
      if (level==6 and rdata7==shift) digitalWrite(data, HIGH);
      if (level==7 and rdata8==shift) digitalWrite(data, HIGH);      
      // Clocks in the new data
      digitalWrite(clock, LOW); digitalWrite(clock, HIGH);    
    }
    for (int lshift=0; lshift <8; lshift++){
      digitalWrite(data, LOW);
      if (lshift == level) digitalWrite(data, HIGH);
      // Clocks in the level data
      digitalWrite(clock, LOW); digitalWrite(clock, HIGH);    
    }

    //Latche and display the new data
    digitalWrite(latch, LOW); digitalWrite(latch, HIGH);    
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
    rdata1 = random(192);
  }
}
for (int tdelay=0; tdelay<200; tdelay++){
  for (int level=0; level <8; level++){
    int rdata1 = random(192);
    int rdata2 = random(192);
    for (int shift=0; shift <192; shift++){
      digitalWrite(data, LOW);
      if (rdata1==shift or rdata2==shift) digitalWrite(data, HIGH);
      // Clocks in the new data
      digitalWrite(clock, LOW); digitalWrite(clock, HIGH);    
    }
    for (int lshift=0; lshift <8; lshift++){
      digitalWrite(data, LOW);
      if (lshift == level) digitalWrite(data, HIGH);
      // Clocks in the level data
      digitalWrite(clock, LOW); digitalWrite(clock, HIGH);    
    }
    //Latche and display the new data
    digitalWrite(latch, LOW); digitalWrite(latch, HIGH);    
  }
} }
