
import processing.serial.*;
Serial myPort;
int[] serialCommand;
int[] serialStatus;
boolean commandUpdate = false;
boolean statusUpdate = false;
PImage logo;

int red = #FF0009;
int green = #03FF00;
int grey = #B7B7B7;

int indicatorX = 50; //X pos
int indicatorY = 20; //Y pos
int indicatorW = 25; //Width
int indicatorH = 25; //Height
int indicatorO = 30; //Offset
int[] indicatorC = { 
  grey, grey, grey, grey, grey, grey, grey, grey,
};

void setup() {
  size(320, 240, P2D);
  background(0);
  logo = loadImage("logo.png");
  println(Serial.list());
  myPort = new Serial(this, "COM11", 115200); //TODO: Dropdown for selecting comport.
  myPort.bufferUntil('\n');
}

void draw() {  
  int i = 0;

  //Check if we have a new status and update the indicators
  if (statusUpdate) {
    //TODO    
    statusUpdate = false; //We've dealt with this update.
  }

  //Check if we have a new command and push it out
  if (commandUpdate) {
    //TODO
    commandUpdate = false; //We've dealt with this update.
  }

  //Draw the background
  image(logo, 0, 0);

  //Draw the indicators
  while (i<8) {
    fill(indicatorC[i]);
    ellipse(indicatorX+indicatorO*i, indicatorY, indicatorW, indicatorH);
    i++;
  }
}

void keyPressed() {
  if (key == 't') {
    int c = 0;
    int a = 0; 
    int n = 0;

    c = (int)random(0.0, 2.0);
    a = (int)random(0.0, 8.0);

    if (c == 0) { 
      n = green;
    } 
    else if (c == 1) { 
      n = red;
    }
    indicatorC[a] = n ;
  } 
  else if (key == 'q') {
    myPort.stop(); //Close serial port
    exit(); //Exit program
  }
}

void serialEvent(Serial myPort) { 
  String incoming;

  incoming = myPort.readStringUntil('\n');
  print("Current status: ");
  println(incoming);

  //TODO: Split incoming into serialStatus
  serialStatus = int(split(incoming, ' '));
  statusUpdate = true;
}

