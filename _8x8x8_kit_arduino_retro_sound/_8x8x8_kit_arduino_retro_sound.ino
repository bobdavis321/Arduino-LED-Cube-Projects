// 8x8x8 kit retrofitted with arduino sound demo
// This program uses some ports in parallel mode
// PORTD = D0 to D7 Data port to latches
// PORTB = D8, D9, D10 or bits 0, 1, 2 are latch select
// PORTB = D11, D12, D13 or bits 3, 4, 5 are level select 5, 6, 7
// PORTC = A0 to A4 are level selects 0-4 as D14 to D18
// PORTC = A5 is analog input <- NOTE THIS CHANGE
int level = 0;
int latch = 0;
int i;
// values for the X axis
byte cube[8]= {0x80, 0x40, 0x20, 0x10, 0x08, 0x04, 0x02, 0x01};

// set all pins to output mode
void setup(){
  // Leave A5 as an analog input
  for(i=0; i<19; i++) pinMode(i, OUTPUT);
  }

void loop(){
  for (level=0; level<8; level++) {
    // turn all level selects off
    PORTC = 0x00;
    digitalWrite(11, LOW);
    digitalWrite(12, LOW);
    digitalWrite(13, LOW);
    // Get analog sample and reduce it to 0-64
    int analog = analogRead(5)/16;
    // Get X and Y axis position
    int yaxis = analog/8;
    int xaxis = analog%8;
    for (latch=0; latch<8; latch++) {
      // load data
      PORTD = 0x00;
      if (latch == yaxis+1) PORTD = cube[xaxis];
      // PORTD = 0xFF; // all LED's on test
      // Select latch
      PORTB = (latch);
    }
  
  // Select the level and turn it on
  if (level == 0) digitalWrite(14, HIGH);
  if (level == 1) digitalWrite(15, HIGH);
  if (level == 2) digitalWrite(16, HIGH);
  if (level == 3) digitalWrite(17, HIGH);
  if (level == 4) digitalWrite(18, HIGH);
  if (level == 5) digitalWrite(11, HIGH);
  if (level == 6) digitalWrite(12, HIGH);
  if (level == 7) digitalWrite(13, HIGH);
  delay(2);
  } 
}


