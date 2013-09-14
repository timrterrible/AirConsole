
import processing.serial.*;
Serial myPort;
String serialCommand = ""; //Command to be sent to Arduino
String serialStatus = ""; //Current status received from Arduino
PImage logo;

void setup() {
  size(320, 240, P2D);
  background(0);
  logo = loadImage("logo.png");
  myPort = new Serial(this, "COM5", 115200); //TODO: Dropdown box selecting comport.
  myPort.bufferUntil('\n');
}

void draw() {
  image(logo, 0, 0);
}


void serialEvent(Serial myPort) { 
  String serialStatus = myPort.readStringUntil('\n');
  serialStatus = trim(serialStatus);
  print("Current status: ");
  println(serialStatus);
}

