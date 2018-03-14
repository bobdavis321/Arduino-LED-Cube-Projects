// 8x8x8 RGB Cube testing all LED's

// These Pins Connect to 74585's
int data = 11; 
int latch = 2;
int clock = 13;

int rotate = 0;
int cycle = 0;

// set up output pins
void setup() {
  pinMode(data, OUTPUT);
  pinMode(clock, OUTPUT);  
  pinMode(latch, OUTPUT);  
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
    for (int lshift=0; lshift <8; lshift++){
      digitalWrite(data, LOW);
      if (lshift == level) digitalWrite(data, HIGH);
      // Clocks in the level data
      digitalWrite(clock, LOW);    
      digitalWrite(clock, HIGH);    
    }
    //Latches the new data
    digitalWrite(latch, LOW);    
    digitalWrite(latch, HIGH);    
    delay(.5);
  } 
// Rate of movement - one per 100 cycles
  cycle=cycle+1;
  if (cycle == 100) {
    rotate = rotate+1;
  cycle = 0;
  }
  if (rotate > 4) rotate=0;
}
