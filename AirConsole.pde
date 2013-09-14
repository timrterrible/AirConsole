
import processing.serial.*;
Serial myPort;
String serialCommand = ""; //Command to be sent to Arduino
String serialStatus = ""; //Current status received from Arduino
PImage logo;

int red = #FF0009;
int green = #03FF00;
int grey = #B7B7B7;

//int indicatorX = 10; //X pos (rect) 
//int indicatorY = 10; //Y pos (rect)
int indicatorX = 20; //X pos (ellipse)
int indicatorY = 20; //Y pos (ellipse)
int indicatorW = 25; //Width
int indicatorH = 25; //Height
int indicatorO = 30; //Offset
int[] indicatorC = { 
  grey, grey, grey, grey, grey, grey, grey, grey,
}; //Fill all indicator colours as neutral for startup.

void setup() {
  size(320, 240, P2D);
  background(0);
  logo = loadImage("logo.png");
  myPort = new Serial(this, "COM5", 115200); //TODO: Dropdown box selecting comport.
  myPort.bufferUntil('\n');
}

void draw() {
  image(logo, 0, 0);
  int i = 0;
  while (i<8) {
    fill(indicatorC[i]);
    //rect(indicatorX+indicatorO*i, indicatorY, indicatorW, indicatorH);
    ellipse(indicatorX+indicatorO*i, indicatorY, indicatorW, indicatorH);
    i++;
  }
}


//Debug function. Randomly changes colour of a random indicator. 
void keyPressed() {
  int c = 0;
  int i = 0; 
  int n = 0;

  if (key == 's') {
    c = (int)random(0.0, 2.0);
    i = (int)random(0.0, 8.0);

    if (c == 0) { 
      n = green;
    } 
    else if (c == 1) { 
      n = red;
    }

    indicatorC[i] =n ;
  }
}

void serialEvent(Serial myPort) { 
  String serialStatus = myPort.readStringUntil('\n');
  serialStatus = trim(serialStatus);
  print("Current status: ");
  println(serialStatus);
}

