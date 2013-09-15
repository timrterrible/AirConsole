/*
// @lhsbikeshed compressed air controller
 //
 // Q = quit
 // 1 - 8 = toggle relays on and off
 // 
 // Indicator lights show what state each channel is in, according to the arduino.
 //
 // COM port is currently hardcoded because effort. Change the line in setup()
 //
 */

import processing.serial.*;

Serial myPort;
PImage logo;

String serialCommand = "";
String serialStatus = "";
boolean commandUpdate = false;
boolean statusUpdate = false;

int red = #FF0009;
int green = #03FF00;
int grey = #B7B7B7;
int indicatorX = 55;
int indicatorY = 25;
int indicatorW = 25;
int indicatorH = 25;
int indicatorO = 30;
int[] indicatorC = { 
  grey, grey, grey, grey, grey, grey, grey, grey,
};

void setup() {
  size(320, 240, P2D);
  background(0);
  logo = loadImage("logo.png");
  myPort = new Serial(this, "COM5", 115200);
  myPort.bufferUntil('\n');
}

void draw() {   
  int i = 0;

  if (statusUpdate) {
    while (i<8) {
      switch(serialStatus.charAt(i))
      {
      case '1': 
        indicatorC[i] = green;
        break;        
      case '0':       
        indicatorC[i] = red;
        break;
      }
      i++;
    }    
    statusUpdate = false;
  }

  if (commandUpdate) {
    //TODO: serialCommand has been changed by numkeys, push it out to serial.
    commandUpdate = false;
  }

  image(logo, 0, 0);

  i = 0;
  while (i<8) {
    fill(indicatorC[i]);
    ellipse(indicatorX+indicatorO*i, indicatorY, indicatorW, indicatorH);
    i++;
  }
}

void keyPressed() {
  if (key == 'q') {
    myPort.stop();
    exit();
  } 
  //TODO: 1 - 8 (numpad and row) should flip relevant addresses in serialCommand
}

void serialEvent(Serial myPort) { 
  serialStatus = myPort.readStringUntil('\n');
  print("Current status: ");
  println(serialStatus);
  statusUpdate = true;
}

