// 8x8x8 RGB Cube with Random sparkles
// This version uses a 74595 to select the level

// These Pins Connect to 74595's
// They are reassigned for compatability.
int data = 11;  // 595 pin 14 
int latch = 2; // 595 pin 12
int clock = 13; // 595 pin 11
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
    int rdata1 = random(96);
    int rdata2 = random(96);
    for (int shift=0; shift <96; shift++){
      digitalWrite(data, LOW);
      if (rdata1==shift or rdata2==shift){
        digitalWrite(data, HIGH);
      }
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
    delay(5);
  } 
}
