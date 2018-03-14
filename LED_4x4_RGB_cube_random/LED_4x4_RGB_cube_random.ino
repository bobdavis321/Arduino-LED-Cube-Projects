// 4x4x4 RGB Cube with Random sparkles

// These Pins Connect to 74585's
int data = 2; 
int latch = 3;
int clock = 4;
// These Pins Connect to ULN2003
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
    int rdata = random(48);
    for (int shift=0; shift <48; shift++){
      // Data is inverted!
      digitalWrite(data, HIGH);
      if (rdata==shift){
        digitalWrite(data, LOW);
      }
      // Clocks in the new data
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
    delay(50);
  } 
}
