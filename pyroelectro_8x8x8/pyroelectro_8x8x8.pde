/********************************
* CHR @ Instructables Made Most Of This Code I Just Modified It!
*
* Chris @ PyroElectro.com
* Project Website: http://www.pyroelectro.com/projects/8x8x8_led_cube/
*
* Description:
* This is the control code and some example effect code for an 8x8x8 LED
* cube. The control work was all done by CHR and he did a terrific job.
* I messed around using his great functions to create some neat effects
* for the 8x8x8 LED cube that I built. 
*
*********************************/

#include <avr/interrupt.h>
#include <string.h>
#define AXIS_X 1
#define AXIS_Y 2
#define AXIS_Z 3

volatile unsigned char cube[8][8];
volatile int current_layer = 0;

void setup()
{
  int i;
  
  for(i=0; i<14; i++)
    pinMode(i, OUTPUT);
  
  // pinMode(A0, OUTPUT) as specified in the arduino reference didn't work. So I accessed the registers directly.
  DDRC = 0xff;
  PORTC = 0x00;
  
  // Reset any PWM configuration that the arduino may have set up automagically!
  TCCR2A = 0x00;
  TCCR2B = 0x00;

  TCCR2A |= (0x01 << WGM21); // CTC mode. clear counter on TCNT2 == OCR2A
  OCR2A = 10; // Interrupt every 25600th cpu cycle (256*100)
  TCNT2 = 0x00; // start counting at 0
  TCCR2B |= (0x01 << CS22) | (0x01 << CS21); // Start the clock with a 256 prescaler
  
  TIMSK2 |= (0x01 << OCIE2A);
}

ISR (TIMER2_COMPA_vect)
{
  int i;
  
  // all layer selects off
  PORTC = 0x00;
  PORTB &= 0x0f;
  
  PORTB |= 0x08; // output enable off.
  
  for (i=0; i<8; i++)
  {
    PORTD = cube[current_layer][i];
    PORTB = (PORTB & 0xF8) | (0x07 & (i+1));
  }
  
  PORTB &= 0b00110111; // Output enable on.
  
  if (current_layer < 6)
  {
    PORTC = (0x01 << current_layer);
  } else if (current_layer == 6)
  {
    digitalWrite(12, HIGH);
  } else
  {
    digitalWrite(13, HIGH);
  }
  
  current_layer++;
  
  if (current_layer == 8)
    current_layer = 0;
}

void loop()
{
  int cnt;
  while (true)
  {
  
  effect_intro();
  
  zoom_pyramid();
  zoom_pyramid_clear();
  zoom_pyramid();
  zoom_pyramid_clear();
  
  firework(0,0,0);
  firework(-2,-2,50);
  firework(1,1,-250);
  firework(0,1,200);
  firework(1,-3,400);
  firework(2,-3,600);
  firework(2,1,500);
  firework(2,-2,200);  
  firework(2,1,0);
  firework(0,0,0);
  
  pyro();
  pyro();

  firework(2,-2,500);
  
  space(100);
  space(100);

  firework(-2,1,600);  
  
  for(cnt=0;cnt<501;cnt+=100)
    turning_cross_animation(cnt);
  for(cnt=500;cnt>=0;cnt-=100)
    turning_cross_animation(cnt);
  
  turning_cross(300);
  
  syd_rox();
  syd_rox();
  
  }
}


// ==========================================================================================
//   Effect functions
// ==========================================================================================
void turning_cross_animation(int time){
int i,j,k;

fill(0x00);

//Cross

//1
for(i=0;i<8;i++){
setvoxel(7,3,i);
setvoxel(7,4,i);
setvoxel(7,i,3);
setvoxel(7,i,4);
}

shift(AXIS_X,-1);
delay_ms(1000-time);  

//2
setvoxel(6,7,5);
setvoxel(6,6,5);
clrvoxel(6,7,3);
clrvoxel(6,6,3);

setvoxel(6,2,7);
setvoxel(6,2,6);
clrvoxel(6,4,7);
clrvoxel(6,4,6);

setvoxel(6,0,2);
setvoxel(6,1,2);
clrvoxel(6,0,4);
clrvoxel(6,1,4);

setvoxel(6,5,0);
setvoxel(6,5,1);
clrvoxel(6,3,0);
clrvoxel(6,3,1);

shift(AXIS_X,-1);
delay_ms(1000-time);

//3
setvoxel(5,6,6);
setvoxel(5,5,5);
clrvoxel(5,7,4);
clrvoxel(5,6,4);

setvoxel(5,1,6);
setvoxel(5,2,5);
clrvoxel(5,3,7);
clrvoxel(5,3,6);

setvoxel(5,2,2);
setvoxel(5,1,1);
clrvoxel(5,0,3);
clrvoxel(5,1,3);

setvoxel(5,6,1);
setvoxel(5,5,2);
clrvoxel(5,4,0);
clrvoxel(5,4,1);

shift(AXIS_X,-1);
delay_ms(1000-time);

//4
//Corners
setvoxel(4,7,7);
setvoxel(4,7,0);
setvoxel(4,0,7);
setvoxel(4,0,0);

setvoxel(4,6,7);
setvoxel(4,5,6);
clrvoxel(4,7,5);
clrvoxel(4,6,5);

setvoxel(4,0,6);
setvoxel(4,1,5);
clrvoxel(4,2,7);
clrvoxel(4,2,6);

setvoxel(4,1,0);
setvoxel(4,2,1);
clrvoxel(4,0,2);
clrvoxel(4,1,2);

setvoxel(4,7,1);
setvoxel(4,6,2);
clrvoxel(4,5,0);
clrvoxel(4,5,1);

shift(AXIS_X,-1);
delay_ms(1000-time);

//5
//Corners
clrvoxel(3,7,7);
clrvoxel(3,7,0);
clrvoxel(3,0,7);
clrvoxel(3,0,0);

setvoxel(3,7,2);
setvoxel(3,6,3);
clrvoxel(3,6,1);
clrvoxel(3,5,2);

setvoxel(3,0,5);
setvoxel(3,1,4);
setvoxel(3,4,5);
clrvoxel(3,1,6);
clrvoxel(3,2,5);

setvoxel(3,3,1);
setvoxel(3,2,0);
clrvoxel(3,1,1);
clrvoxel(3,2,2);

setvoxel(3,4,6);
setvoxel(3,5,7);
clrvoxel(3,6,6);
clrvoxel(3,5,5);

shift(AXIS_X,-1);
delay_ms(1000-time);

//6
setvoxel(2,7,3);
setvoxel(2,6,4);
clrvoxel(2,7,1);
clrvoxel(2,6,2);

setvoxel(2,0,5);
setvoxel(2,1,4);
clrvoxel(2,0,6);
clrvoxel(2,1,5);

setvoxel(2,0,4);
setvoxel(2,1,3);
clrvoxel(2,1,6);
clrvoxel(2,2,5);

setvoxel(2,3,6);
setvoxel(2,4,7);
clrvoxel(2,5,6);
clrvoxel(2,6,7);

setvoxel(2,4,1);
setvoxel(2,3,0);
clrvoxel(2,1,0);
clrvoxel(2,2,1);

shift(AXIS_X,-1);
delay_ms(1000-time);

//7

setvoxel(1,7,4);
clrvoxel(1,7,2);

setvoxel(1,0,4);
clrvoxel(1,0,2);

setvoxel(1,0,3);
clrvoxel(1,0,5);

setvoxel(1,3,7);
clrvoxel(1,5,7);
  
shift(AXIS_X,-1);
delay_ms(1000-time);

//8
setvoxel(0,7,5);
setvoxel(0,6,5);
clrvoxel(0,7,3);
clrvoxel(0,6,3);

setvoxel(0,2,7);
setvoxel(0,2,6);
clrvoxel(0,4,7);
clrvoxel(0,4,6);

setvoxel(0,0,2);
setvoxel(0,1,2);
clrvoxel(0,0,4);
clrvoxel(0,1,4);

setvoxel(0,5,0);
setvoxel(0,5,1);
clrvoxel(0,3,0);
clrvoxel(0,3,1);

shift(AXIS_X,-1);
delay_ms(1000-time);
  
}


void turning_cross(int time){
int i,j,k;

fill(0x00);

//Cross

//1
for(i=0;i<8;i++){
setvoxel(0,3,i);
setvoxel(0,4,i);
setvoxel(0,i,3);
setvoxel(0,i,4);
}

delay_ms(1000-time);  

//2
setvoxel(0,7,5);
setvoxel(0,6,5);
clrvoxel(0,7,3);
clrvoxel(0,6,3);

setvoxel(0,2,7);
setvoxel(0,2,6);
clrvoxel(0,4,7);
clrvoxel(0,4,6);

setvoxel(0,0,2);
setvoxel(0,1,2);
clrvoxel(0,0,4);
clrvoxel(0,1,4);

setvoxel(0,5,0);
setvoxel(0,5,1);
clrvoxel(0,3,0);
clrvoxel(0,3,1);

delay_ms(1000-time);

//3
setvoxel(0,6,6);
setvoxel(0,5,5);
clrvoxel(0,7,4);
clrvoxel(0,6,4);

setvoxel(0,1,6);
setvoxel(0,2,5);
clrvoxel(0,3,7);
clrvoxel(0,3,6);

setvoxel(0,2,2);
setvoxel(0,1,1);
clrvoxel(0,0,3);
clrvoxel(0,1,3);

setvoxel(0,6,1);
setvoxel(0,5,2);
clrvoxel(0,4,0);
clrvoxel(0,4,1);

delay_ms(1000-time);

//4
//Corners
setvoxel(0,7,7);
setvoxel(0,7,0);
setvoxel(0,0,7);
setvoxel(0,0,0);

setvoxel(0,6,7);
setvoxel(0,5,6);
clrvoxel(0,7,5);
clrvoxel(0,6,5);

setvoxel(0,0,6);
setvoxel(0,1,5);
clrvoxel(0,2,7);
clrvoxel(0,2,6);

setvoxel(0,1,0);
setvoxel(0,2,1);
clrvoxel(0,0,2);
clrvoxel(0,1,2);

setvoxel(0,7,1);
setvoxel(0,6,2);
clrvoxel(0,5,0);
clrvoxel(0,5,1);

delay_ms(1000-time);

//5
//Corners
clrvoxel(0,7,7);
clrvoxel(0,7,0);
clrvoxel(0,0,7);
clrvoxel(0,0,0);

setvoxel(0,7,2);
setvoxel(0,6,3);
clrvoxel(0,6,1);
clrvoxel(0,5,2);

setvoxel(0,0,5);
setvoxel(0,1,4);
setvoxel(0,4,5);
clrvoxel(0,1,6);
clrvoxel(0,2,5);

setvoxel(0,3,1);
setvoxel(0,2,0);
clrvoxel(0,1,1);
clrvoxel(0,2,2);

setvoxel(0,4,6);
setvoxel(0,5,7);
clrvoxel(0,6,6);
clrvoxel(0,5,5);

delay_ms(1000-time);

//6
setvoxel(0,7,3);
setvoxel(0,6,4);
clrvoxel(0,7,1);
clrvoxel(0,6,2);

setvoxel(0,0,5);
setvoxel(0,1,4);
clrvoxel(0,0,6);
clrvoxel(0,1,5);

setvoxel(0,0,4);
setvoxel(0,1,3);
clrvoxel(0,1,6);
clrvoxel(0,2,5);

setvoxel(0,3,6);
setvoxel(0,4,7);
clrvoxel(0,5,6);
clrvoxel(0,6,7);

setvoxel(0,4,1);
setvoxel(0,3,0);
clrvoxel(0,1,0);
clrvoxel(0,2,1);

delay_ms(1000-time);

//7

setvoxel(0,7,4);
clrvoxel(0,7,2);

setvoxel(0,0,4);
clrvoxel(0,0,2);

setvoxel(0,0,3);
clrvoxel(0,0,5);

setvoxel(0,3,7);
clrvoxel(0,5,7);
  
}

void space(int iterations){

	int i, ii;
	int rnd_y;
	int rnd_z;
	int rnd_num;
        int time;
	
        time = 700;

	for (ii=0;ii<iterations;ii++)
	{
                time = time - (iterations/15);
		rnd_num = rand()%4;
		
		for (i=0; i < rnd_num;i++)
		{
			rnd_y = rand()%8;
			rnd_z = rand()%8;
			setvoxel(7,rnd_y,rnd_z);
		}
		
		delay_ms(time);
		shift(AXIS_X,-1);
	} 

	for (ii=0;ii<iterations;ii++)
	{
                time = time + (iterations/15);
		rnd_num = rand()%4;
		
		for (i=0; i < rnd_num;i++)
		{
			rnd_y = rand()%8;
			rnd_z = rand()%8;
			setvoxel(7,rnd_y,rnd_z);
		}
		
		delay_ms(time);
		shift(AXIS_X,-1);
	} 

}

void syd_rox(){

fill(0x00);  
  
//S
setvoxel(0,7,7);
setvoxel(0,6,7);
setvoxel(0,7,6);
setvoxel(0,7,5);
setvoxel(0,6,5);
setvoxel(0,6,4);
setvoxel(0,6,3);
setvoxel(0,7,3);

//Y
setvoxel(0,4,7);
setvoxel(0,4,6);
setvoxel(0,4,5);
setvoxel(0,3,7);
setvoxel(0,3,6);
setvoxel(0,3,5);
setvoxel(0,3,4);
setvoxel(0,3,3);
setvoxel(0,4,3);

//D
setvoxel(0,1,7);
setvoxel(0,1,6);
setvoxel(0,1,5);
setvoxel(0,1,4);
setvoxel(0,1,3);
setvoxel(0,0,6);
setvoxel(0,0,5);
setvoxel(0,0,4);

delay_ms(15000);
fill(0x00);
 
//R
setvoxel(0,7,7);
setvoxel(0,7,6);
setvoxel(0,7,5);
setvoxel(0,7,4);
setvoxel(0,7,3);
setvoxel(0,6,7);
setvoxel(0,5,7);
setvoxel(0,5,6);
setvoxel(0,5,5);
setvoxel(0,6,5);
setvoxel(0,6,4);
setvoxel(0,5,3);

//0
setvoxel(0,4,7);
setvoxel(0,4,6);
setvoxel(0,4,5);
setvoxel(0,4,4);
setvoxel(0,4,3);
setvoxel(0,3,7);
setvoxel(0,3,6);
setvoxel(0,3,5);
setvoxel(0,3,4);
setvoxel(0,3,3);

//X
setvoxel(0,2,7);
setvoxel(0,2,6);
setvoxel(0,2,4);
setvoxel(0,2,3);
setvoxel(0,1,5);
setvoxel(0,0,7);
setvoxel(0,0,6);
setvoxel(0,0,4);
setvoxel(0,0,3);


delay_ms(15000);
  
}

void pyro(){

fill(0x00);
//P
setvoxel(0,0,0);
setvoxel(0,0,1);
setvoxel(0,0,2);
setvoxel(0,0,3);
setvoxel(0,0,4);
setvoxel(0,0,5);
setvoxel(0,0,6);
setvoxel(0,0,7);
shift(AXIS_Y,1);
delay_ms(4000);
setvoxel(0,0,4);
setvoxel(0,0,7);
shift(AXIS_Y,1);
delay_ms(4000);

setvoxel(0,0,7);
setvoxel(0,0,7);
setvoxel(0,0,6);
setvoxel(0,0,5);
setvoxel(0,0,4);
shift(AXIS_Y,1);
delay_ms(4000);

shift(AXIS_Y,1);
delay_ms(5000);

//y
setvoxel(0,0,4);
setvoxel(0,0,5);
setvoxel(0,0,6);
setvoxel(0,0,7);
setvoxel(0,0,0);

shift(AXIS_Y,1);
delay_ms(4000);

setvoxel(0,0,4);
setvoxel(0,0,0);
shift(AXIS_Y,1);
delay_ms(4000);

setvoxel(0,0,7);
setvoxel(0,0,6);
setvoxel(0,0,5);
setvoxel(0,0,4);
setvoxel(0,0,3);
setvoxel(0,0,2);
setvoxel(0,0,1);
setvoxel(0,0,0);
shift(AXIS_Y,1);
delay_ms(4000);

shift(AXIS_Y,1);
delay_ms(5000);

//r
setvoxel(0,0,0);
setvoxel(0,0,1);
setvoxel(0,0,2);
setvoxel(0,0,3);
setvoxel(0,0,4);
setvoxel(0,0,5);
setvoxel(0,0,6);
setvoxel(0,0,7);
shift(AXIS_Y,1);
delay_ms(4000);

setvoxel(0,0,7);
setvoxel(0,0,4);
setvoxel(0,0,3);
shift(AXIS_Y,1);
delay_ms(4000);

setvoxel(0,0,7);
setvoxel(0,0,6);
setvoxel(0,0,5);
setvoxel(0,0,4);
setvoxel(0,0,2);
setvoxel(0,0,1);
setvoxel(0,0,0);
shift(AXIS_Y,1);
delay_ms(4000);

shift(AXIS_Y,1);
delay_ms(5000);

//0
setvoxel(0,0,0);
setvoxel(0,0,1);
setvoxel(0,0,2);
setvoxel(0,0,3);
setvoxel(0,0,4);
setvoxel(0,0,5);
setvoxel(0,0,6);
setvoxel(0,0,7);
shift(AXIS_Y,1);
delay_ms(4000);

setvoxel(0,0,7);
setvoxel(0,0,0);
shift(AXIS_Y,1);
delay_ms(4000);

setvoxel(0,0,7);
setvoxel(0,0,6);
setvoxel(0,0,5);
setvoxel(0,0,4);
setvoxel(0,0,3);
setvoxel(0,0,2);
setvoxel(0,0,1);
setvoxel(0,0,0);
shift(AXIS_Y,1);
delay_ms(4000);


shift(AXIS_Y,1);
delay_ms(4000);
shift(AXIS_Y,1);
delay_ms(4000);
shift(AXIS_Y,1);
delay_ms(4000);
shift(AXIS_Y,1);
delay_ms(4000);
shift(AXIS_Y,1);
delay_ms(4000);
shift(AXIS_Y,1);
delay_ms(4000);
shift(AXIS_Y,1);
delay_ms(4000);
shift(AXIS_Y,1);
delay_ms(2500);

fill(0x00);

}

void firework(int i,int j, int time){

fill(0x00);

setvoxel(3-i,4-j,0);  
delay_ms(900-time);

clrvoxel(3-i,4-j,0);  
setvoxel(4-i,4-j,1);  
delay_ms(1200-time);

clrvoxel(4-i,4-j,1);  
setvoxel(4-i,5-j,2);  
delay_ms(1400-time);

clrvoxel(4-i,5-j,2);  
setvoxel(3-i,5-j,3);  
delay_ms(1700-time);

clrvoxel(3-i,5-j,3);  
setvoxel(3-i,4-j,4);  
delay_ms(2000-time);

clrvoxel(3-i,4-j,4);  
setvoxel(4-i,4-j,5);  
delay_ms(2000-time);

clrvoxel(4-i,4-j,5);  
setvoxel(4-i,3-j,6);  
delay_ms(2000-time);

//Explode
clrvoxel(4-i,3-j,6);
setvoxel(4-i,3-j,7);
setvoxel(4-i,4-j,6);
setvoxel(4-i,2-j,6);
setvoxel(3-i,3-j,6);
setvoxel(5-i,3-j,6);
delay_ms(2000-time);

shift(AXIS_Z,-1);
setvoxel(4-i,5-j,5);
setvoxel(4-i,1-j,5);
setvoxel(2-i,3-j,5);
setvoxel(6-i,3-j,5);
delay_ms(900-time);

shift(AXIS_Z,-1);
setvoxel(4-i,6-j,3);
setvoxel(4-i,0-j,3);
setvoxel(1-i,3-j,3);
setvoxel(7-i,3-j,3);
delay_ms(900-time);

shift(AXIS_Z,-1);
setvoxel(4-i,7-j,1);
setvoxel(3-i,0-j,1);
setvoxel(0-i,3-j,1);
setvoxel(7-i,2-j,1);
delay_ms(1400-time);

shift(AXIS_Z,-1);
delay_ms(1400-time);

shift(AXIS_Z,-1);
delay_ms(1400-time);

shift(AXIS_Z,-1);
delay_ms(1400-time);

shift(AXIS_Z,-1);
delay_ms(700-time);

fill(0x00);

}

void zoom_pyramid_clear(){


  //1
  
  box_walls(0,0,0,7,0,7); 
  delay_ms(500);  
  
  //2

  //Pyramid
    box_wireframe(0,0,0,7,0,1);    
    
   clrplane_y(0);
  delay_ms(500);  
  
  //3

  //Pyramid  
     clrplane_y(1);
  box_walls(0,2,0,7,2,7); 
  delay_ms(500);

  //4

  //Pyramid
     clrplane_y(2);
  box_walls(0,3,0,7,3,7);  
  delay_ms(500);

  //5

  //Pyramid
     clrplane_y(3);
  box_walls(0,4,0,7,4,7); 
  delay_ms(500);

  //5

  //Pyramid
  
     clrplane_y(4);
  box_walls(0,5,0,7,5,7); 
  delay_ms(500);
  //6
  

  //Pyramid
  
     clrplane_y(5);
      box_walls(0,6,0,7,6,7); 
  delay_ms(500);
  //7

  //Pyramid
  
  clrplane_y(6);
  box_walls(0,7,0,7,7,7);     
  delay_ms(500);  
    

  clrplane_y(7);
  delay_ms(10000);
  
}

void zoom_pyramid(){
int i,j,k,time;

  //1
  fill(0x00);
  
  box_walls(0,0,0,7,0,7); 
  delay_ms(500);  
  
  //2
  fill(0x00);  
  //Pyramid
    box_wireframe(0,0,0,7,0,1);    
    
   box_walls(0,1,0,7,1,7);    
  delay_ms(500);  
  
  //3
  fill(0x00);
  //Pyramid  
    box_wireframe(0,0,0,7,1,1);
    box_wireframe(1,1,2,6,1,3);  

  box_walls(0,2,0,7,2,7); 
  delay_ms(500);

  //4
  fill(0x00);
  //Pyramid
    box_wireframe(0,0,0,7,2,1);
    box_wireframe(1,1,2,6,2,3);  
    box_wireframe(2,2,4,5,2,5);  

  box_walls(0,3,0,7,3,7);  
  delay_ms(500);

  //5
  fill(0x00);
  //Pyramid
    box_wireframe(0,0,0,7,3,1);
    box_wireframe(1,1,2,6,3,3);  
    box_wireframe(2,2,4,5,3,5);
    box_wireframe(3,3,6,4,3,7);

  box_walls(0,4,0,7,4,7); 
  delay_ms(500);

  //5
  fill(0x00);
  //Pyramid
    box_wireframe(0,0,0,7,4,1);
    box_wireframe(1,1,2,6,4,3);  
    box_wireframe(2,2,4,5,4,5);
    box_wireframe(3,3,6,4,4,7);

  box_walls(0,5,0,7,5,7); 
  delay_ms(500);
  //6
  
  fill(0x00);
  //Pyramid
    box_wireframe(0,0,0,7,5,1);
    box_wireframe(1,1,2,6,5,3);  
    box_wireframe(2,2,4,5,5,5);
    box_wireframe(3,3,6,4,4,7);
    
      box_walls(0,6,0,7,6,7); 
  delay_ms(500);
  //7
  fill(0x00);  
  //Pyramid
    box_wireframe(0,0,0,7,6,1);
    box_wireframe(1,1,2,6,6,3);  
   box_wireframe(2,2,4,5,5,5);
    box_wireframe(3,3,6,4,4,7);
    
  box_walls(0,7,0,7,7,7);     
  delay_ms(500);  
    
  fill(0x00);
  box_wireframe(0,0, 0, 7, 7, 1);      
  box_wireframe(1,1, 2, 6, 6, 3);      
  box_wireframe(2,2, 4, 5, 5, 5);         
  box_wireframe(3,3, 6, 4, 4, 7); 

  delay_ms(10000);   
}


void effect_intro(){
int cnt,cnt_2,time; 
 
  //Bottom To Top  
   
  for(cnt=0;cnt<=7;cnt++){
   box_wireframe(0, 0, 0, 7, 7, cnt);   
   delay_ms(2000);
  }
  for(cnt=0;cnt<7;cnt++){
  clrplane_z(cnt);
  delay_ms(2000);  
  }
  
  //Shift Things Right
    //1
  shift(AXIS_Y,-1);
  for(cnt=0;cnt<=7;cnt++){
  setvoxel(cnt,0,6);  
  }
  delay_ms(2000);  
    //2
  shift(AXIS_Y,-1);
  for(cnt=0;cnt<=7;cnt++){
  setvoxel(cnt,0,5);  
  }
  setvoxel(0,0,6);
  setvoxel(7,0,6);
  delay_ms(2000);  
    //3
  shift(AXIS_Y,-1);
  for(cnt=0;cnt<=7;cnt++){
  setvoxel(cnt,0,4);  
  }
  setvoxel(0,0,5);
  setvoxel(7,0,5);
  setvoxel(0,0,6);
  setvoxel(7,0,6);
  delay_ms(2000);

    //4
  shift(AXIS_Y,-1);
  for(cnt=0;cnt<=7;cnt++){
  setvoxel(cnt,0,3);  
  }
  setvoxel(0,0,4);
  setvoxel(7,0,4);
  setvoxel(0,0,5);
  setvoxel(7,0,5);
  setvoxel(0,0,6);
  setvoxel(7,0,6);
  delay_ms(2000);
   
    //5
  shift(AXIS_Y,-1);
  for(cnt=0;cnt<=7;cnt++){
  setvoxel(cnt,0,2);  
  }
  setvoxel(0,0,3);
  setvoxel(7,0,3);
  setvoxel(0,0,4);
  setvoxel(7,0,4);
  setvoxel(0,0,5);
  setvoxel(7,0,5);
  setvoxel(0,0,6);
  setvoxel(7,0,6);
    delay_ms(2000);
  
    //6
  shift(AXIS_Y,-1);
  for(cnt=0;cnt<=7;cnt++){
  setvoxel(cnt,0,1);  
  }
  setvoxel(0,0,2);
  setvoxel(7,0,2);
  setvoxel(0,0,3);
  setvoxel(7,0,3);
  setvoxel(0,0,4);
  setvoxel(7,0,4);
  setvoxel(0,0,5);
  setvoxel(7,0,5);
  delay_ms(2000);
  
  
    //7
  shift(AXIS_Y,-1);
  for(cnt=0;cnt<=7;cnt++){
  setvoxel(cnt,0,0);  
  }
  setvoxel(0,0,1);
  setvoxel(7,0,1);
  setvoxel(0,0,2);
  setvoxel(7,0,2);
  setvoxel(0,0,3);
  setvoxel(7,0,3);
  setvoxel(0,0,4);
  setvoxel(7,0,4);  
  setvoxel(0,0,5);
  setvoxel(7,0,5);
  delay_ms(2000);

    //Right To Left   
  for(cnt=0;cnt<=7;cnt++){
   box_wireframe(0, 0, 0, 7, cnt, 7);   
   delay_ms(2000);
  }
  for(cnt=0;cnt<7;cnt++){
  clrplane_y(cnt);
  delay_ms(2000);  
  }

  //Shift to the bottom
  for(cnt_2=6;cnt_2>=0;cnt_2--){
    shift(AXIS_Z,-1);
    for(cnt=0;cnt<=7;cnt++){
      setvoxel(cnt,cnt_2,0);  
    }
      for(cnt=6;cnt>cnt_2;cnt--){
        setvoxel(0,cnt,0);
        setvoxel(7,cnt,0);      
      }
    
      delay_ms(2000);  
  }   

  //Make All Wall Box

  for(cnt=0;cnt<=6;cnt++){
    fill(0x00);    
    box_walls(0,0,0,7,7,cnt); 
    delay_ms(2000);  
  }  
  
  time = 2000;
  for(cnt_2=0;cnt_2<5;cnt_2++){
  time = time - 300;
  //Make Box Smaller
    for(cnt=0;cnt<=3;cnt++){
      fill(0x00);
      box_walls(cnt,cnt,cnt,7-cnt,7-cnt,7-cnt);   
      delay_ms(time);
    }  
    
    //Make Box Bigger
    for(cnt=0;cnt<=3;cnt++){
      fill(0x00);
      box_walls(3-cnt,3-cnt,3-cnt,4+cnt,4+cnt,4+cnt);   
      delay_ms(time);
    }  
  }
  for(cnt_2=0;cnt_2<5;cnt_2++){
  time = time + 300;
  //Make Box Smaller
  for(cnt=0;cnt<=3;cnt++){
    fill(0x00);
    box_walls(cnt,cnt,cnt,7-cnt,7-cnt,7-cnt);   
    delay_ms(time);
  }  
  
  //Make Box Bigger
  for(cnt=0;cnt<=3;cnt++){
    fill(0x00);
    box_walls(3-cnt,3-cnt,3-cnt,4+cnt,4+cnt,4+cnt);   
    delay_ms(time);
  }  
  }  
    delay_ms(2000);
  
}

void draw_positions_axis (char axis, unsigned char positions[64], int invert)
{
	int x, y, p;
	
	fill(0x00);
	
	for (x=0; x<8; x++)
	{
		for (y=0; y<8; y++)
		{
			if (invert)
			{
				p = (7-positions[(x*8)+y]);
			} else
			{
				p = positions[(x*8)+y];
			}
		
			if (axis == AXIS_Z)
				setvoxel(x,y,p);
				
			if (axis == AXIS_Y)
				setvoxel(x,p,y);
				
			if (axis == AXIS_X)
				setvoxel(p,y,x);
		}
	}
	
}


// Draw a plane on one axis and send it back and forth once.
void effect_planboing (int plane, int speed)
{
	int i;
	for (i=0;i<8;i++)
	{
		fill(0x00);
        setplane(plane, i);
		delay_ms(speed);
	}
	
	for (i=7;i>=0;i--)
	{
		fill(0x00);
        setplane(plane,i);
		delay_ms(speed);
	}
}

// ==========================================================================================
//   Draw functions
// ==========================================================================================


// Set a single voxel to ON
void setvoxel(int x, int y, int z)
{
	if (inrange(x,y,z))
		cube[z][y] |= (1 << x);
}


// Set a single voxel to ON
void clrvoxel(int x, int y, int z)
{
	if (inrange(x,y,z))
		cube[z][y] &= ~(1 << x);
}



// This function validates that we are drawing inside the cube.
unsigned char inrange(int x, int y, int z)
{
	if (x >= 0 && x < 8 && y >= 0 && y < 8 && z >= 0 && z < 8)
	{
		return 0x01;
	} else
	{
		// One of the coordinates was outside the cube.
		return 0x00;
	}
}

// Get the current status of a voxel
unsigned char getvoxel(int x, int y, int z)
{
	if (inrange(x,y,z))
	{
		if (cube[z][y] & (1 << x))
		{
			return 0x01;
		} else
		{
			return 0x00;
		}
	} else
	{
		return 0x00;
	}
}

// In some effect we want to just take bool and write it to a voxel
// this function calls the apropriate voxel manipulation function.
void altervoxel(int x, int y, int z, int state)
{
	if (state == 1)
	{
		setvoxel(x,y,z);
	} else
	{
		clrvoxel(x,y,z);
	}
}

// Flip the state of a voxel.
// If the voxel is 1, its turned into a 0, and vice versa.
void flpvoxel(int x, int y, int z)
{
	if (inrange(x, y, z))
		cube[z][y] ^= (1 << x);
}

// Makes sure x1 is alwas smaller than x2
// This is usefull for functions that uses for loops,
// to avoid infinite loops
void argorder(int ix1, int ix2, int *ox1, int *ox2)
{
	if (ix1>ix2)
	{
		int tmp;
		tmp = ix1;
		ix1= ix2;
		ix2 = tmp;
	}
	*ox1 = ix1;
	*ox2 = ix2;
}

// Sets all voxels along a X/Y plane at a given point
// on axis Z
void setplane_z (int z)
{
	int i;
	if (z>=0 && z<8)
	{
		for (i=0;i<8;i++)
			cube[z][i] = 0xff;
	}
}

// Clears voxels in the same manner as above
void clrplane_z (int z)
{
	int i;
	if (z>=0 && z<8)
	{
		for (i=0;i<8;i++)
			cube[z][i] = 0x00;
	}
}

void setplane_x (int x)
{
	int z;
	int y;
	if (x>=0 && x<8)
	{
		for (z=0;z<8;z++)
		{
			for (y=0;y<8;y++)
			{
				cube[z][y] |= (1 << x);
			}
		}
	}
}

void clrplane_x (int x)
{
	int z;
	int y;
	if (x>=0 && x<8)
	{
		for (z=0;z<8;z++)
		{
			for (y=0;y<8;y++)
			{
				cube[z][y] &= ~(1 << x);
			}
		}
	}
}

void setplane_y (int y)
{
	int z;
	if (y>=0 && y<8)
	{
		for (z=0;z<8;z++)
			cube[z][y] = 0xff;
	} 
}

void clrplane_y (int y)
{
	int z;
	if (y>=0 && y<8)
	{
		for (z=0;z<8;z++)
			cube[z][y] = 0x00; 
	}
}

void setplane (char axis, unsigned char i)
{
    switch (axis)
    {
        case AXIS_X:
            setplane_x(i);
            break;
        
       case AXIS_Y:
            setplane_y(i);
            break;

       case AXIS_Z:
            setplane_z(i);
            break;
    }
}

void clrplane (char axis, unsigned char i)
{
    switch (axis)
    {
        case AXIS_X:
            clrplane_x(i);
            break;
        
       case AXIS_Y:
            clrplane_y(i);
            break;

       case AXIS_Z:
            clrplane_z(i);
            break;
    }
}

// Fill a value into all 64 byts of the cube buffer
// Mostly used for clearing. fill(0x00)
// or setting all on. fill(0xff)
void fill (unsigned char pattern)
{
	int z;
	int y;
	for (z=0;z<8;z++)
	{
		for (y=0;y<8;y++)
		{
			cube[z][y] = pattern;
		}
	}
}



// Draw a box with all walls drawn and all voxels inside set
void box_filled(int x1, int y1, int z1, int x2, int y2, int z2)
{
	int iy;
	int iz;

	argorder(x1, x2, &x1, &x2);
	argorder(y1, y2, &y1, &y2);
	argorder(z1, z2, &z1, &z2);

	for (iz=z1;iz<=z2;iz++)
	{
		for (iy=y1;iy<=y2;iy++)
		{
			cube[iz][iy] |= byteline(x1,x2);
		}
	}

}

// Darw a hollow box with side walls.
void box_walls(int x1, int y1, int z1, int x2, int y2, int z2)
{
	int iy;
	int iz;
	
	argorder(x1, x2, &x1, &x2);
	argorder(y1, y2, &y1, &y2);
	argorder(z1, z2, &z1, &z2);

	for (iz=z1;iz<=z2;iz++)
	{
		for (iy=y1;iy<=y2;iy++)
		{	
			if (iy == y1 || iy == y2 || iz == z1 || iz == z2)
			{
				cube[iz][iy] = byteline(x1,x2);
			} else
			{
				cube[iz][iy] |= ((0x01 << x1) | (0x01 << x2));
			}
		}
	}

}

// Draw a wireframe box. This only draws the corners and edges,
// no walls.
void box_wireframe(int x1, int y1, int z1, int x2, int y2, int z2)
{
	int iy;
	int iz;

	argorder(x1, x2, &x1, &x2);
	argorder(y1, y2, &y1, &y2);
	argorder(z1, z2, &z1, &z2);

	// Lines along X axis
	cube[z1][y1] = byteline(x1,x2);
	cube[z1][y2] = byteline(x1,x2);
	cube[z2][y1] = byteline(x1,x2);
	cube[z2][y2] = byteline(x1,x2);

	// Lines along Y axis
	for (iy=y1;iy<=y2;iy++)
	{
		setvoxel(x1,iy,z1);
		setvoxel(x1,iy,z2);
		setvoxel(x2,iy,z1);
		setvoxel(x2,iy,z2);
	}

	// Lines along Z axis
	for (iz=z1;iz<=z2;iz++)
	{
		setvoxel(x1,y1,iz);
		setvoxel(x1,y2,iz);
		setvoxel(x2,y1,iz);
		setvoxel(x2,y2,iz);
	}

}

// Returns a byte with a row of 1's drawn in it.
// byteline(2,5) gives 0b00111100
char byteline (int start, int end)
{
	return ((0xff<<start) & ~(0xff<<(end+1)));
}

// Flips a byte 180 degrees.
// MSB becomes LSB, LSB becomes MSB.
char flipbyte (char byte)
{
	char flop = 0x00;

	flop = (flop & 0b11111110) | (0b00000001 & (byte >> 7));
	flop = (flop & 0b11111101) | (0b00000010 & (byte >> 5));
	flop = (flop & 0b11111011) | (0b00000100 & (byte >> 3));
	flop = (flop & 0b11110111) | (0b00001000 & (byte >> 1));
	flop = (flop & 0b11101111) | (0b00010000 & (byte << 1));
	flop = (flop & 0b11011111) | (0b00100000 & (byte << 3));
	flop = (flop & 0b10111111) | (0b01000000 & (byte << 5));
	flop = (flop & 0b01111111) | (0b10000000 & (byte << 7));
	return flop;
}

// Draw a line between any coordinates in 3d space.
// Uses integer values for input, so dont expect smooth animations.
void line(int x1, int y1, int z1, int x2, int y2, int z2)
{
	float xy;	// how many voxels do we move on the y axis for each step on the x axis
	float xz;	// how many voxels do we move on the y axis for each step on the x axis 
	unsigned char x,y,z;
	unsigned char lasty,lastz;

	// We always want to draw the line from x=0 to x=7.
	// If x1 is bigget than x2, we need to flip all the values.
	if (x1>x2)
	{
		int tmp;
		tmp = x2; x2 = x1; x1 = tmp;
		tmp = y2; y2 = y1; y1 = tmp;
		tmp = z2; z2 = z1; z1 = tmp;
	}

	
	if (y1>y2)
	{
		xy = (float)(y1-y2)/(float)(x2-x1);
		lasty = y2;
	} else
	{
		xy = (float)(y2-y1)/(float)(x2-x1);
		lasty = y1;
	}

	if (z1>z2)
	{
		xz = (float)(z1-z2)/(float)(x2-x1);
		lastz = z2;
	} else
	{
		xz = (float)(z2-z1)/(float)(x2-x1);
		lastz = z1;
	}



	// For each step of x, y increments by:
	for (x = x1; x<=x2;x++)
	{
		y = (xy*(x-x1))+y1;
		z = (xz*(x-x1))+z1;
		setvoxel(x,y,z);
	}
	
}

// Delay loop.
// This is not calibrated to milliseconds,
// but we had allready made to many effects using this
// calibration when we figured it might be a good idea
// to calibrate it.
void delay_ms(uint16_t x)
{
  uint8_t y, z;
  for ( ; x > 0 ; x--){
    for ( y = 0 ; y < 90 ; y++){
      for ( z = 0 ; z < 6 ; z++){
        asm volatile ("nop");
      }
    }
  }
}



// Shift the entire contents of the cube along an axis
// This is great for effects where you want to draw something
// on one side of the cube and have it flow towards the other
// side. Like rain flowing down the Z axiz.
void shift (char axis, int direction)
{
	int i, x ,y;
	int ii, iii;
	int state;

	for (i = 0; i < 8; i++)
	{
		if (direction == -1)
		{
			ii = i;
		} else
		{
			ii = (7-i);
		}	
	
	
		for (x = 0; x < 8; x++)
		{
			for (y = 0; y < 8; y++)
			{
				if (direction == -1)
				{
					iii = ii+1;
				} else
				{
					iii = ii-1;
				}
				
				if (axis == AXIS_Z)
				{
					state = getvoxel(x,y,iii);
					altervoxel(x,y,ii,state);
				}
				
				if (axis == AXIS_Y)
				{
					state = getvoxel(x,iii,y);
					altervoxel(x,ii,y,state);
				}
				
				if (axis == AXIS_X)
				{
					state = getvoxel(iii,y,x);
					altervoxel(ii,y,x,state);
				}
			}
		}
	}
	
	if (direction == -1)
	{
		i = 7;
	} else
	{
		i = 0;
	}	
	
	for (x = 0; x < 8; x++)
	{
		for (y = 0; y < 8; y++)
		{
			if (axis == AXIS_Z)
				clrvoxel(x,y,i);
				
			if (axis == AXIS_Y)
				clrvoxel(x,i,y);
			
			if (axis == AXIS_X)
				clrvoxel(i,y,x);
		}
	}
}


