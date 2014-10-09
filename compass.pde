import processing.serial.*;

int x, y;
PVector circle = new PVector(0, 0);
PVector compassNorth = new PVector(0,-250);
int diameter = 300;
float angle;
boolean firstRead = true;

int serialInCount = 0;
char [] serialInArray = new char[99];
String serialRead = "";
float serialHeading = 0;
Serial serialPort;


void setup () {
  serialPort = new Serial(this, Serial.list()[3], 115200);
  size(500, 500);
  x = y = width / 2;
  noStroke();
  smooth(8);
  noCursor();
}

void draw () {
  background(51);
  translate(width/2, height/2);
  
  fill(255);
  ellipse(0, 0, diameter, diameter);
  
  //PVector m = new PVector(mouseX-width/2, mouseY-height/2);
  //PVector m = compassNorth.fromAngle(radians(77 - 90));
  PVector m = compassNorth.fromAngle(radians(serialHeading));
  //if (dist(m.x, m.y, circle.x, circle.y) > diameter/2) {
    m.sub(circle);
    m.normalize();
    m.mult(diameter/2);
    m.add(circle);
  //}


fill(255, 0 , 0);
ellipse(m.x, m.y, 24, 24);

/*
fill(255);
text("m.x = " + m.x, -width / 2 + 35, height / 2 - 35);
text("m.y = " + m.y, -width / 2 + 155, height / 2 - 35);
angle = PVector.angleBetween(compassNorth, m);
if (m.x >= 0) {
  text("angle = " + int(degrees(angle)), -width / 2 + 270, height / 2 - 35);
} else {
  text("angle = " + (360 - int(degrees(angle))), -width / 2 + 270, height / 2 - 35);
}
text("angle = " + (360 - int(serialHeading)), -width / 2 + 400, height / 2 - 35);
*/

stroke(0);
line(0,0, compassNorth.x, compassNorth.y);
stroke(255,0,0);
line(0, 0, m.x, m.y);
noStroke();

}


void serialEvent(Serial serialPort) {
  //firstRead = false;
  char inChar = (char) serialPort.read();
  //println(inChar);
  //serialInArray[serialInCount++] = inChar;
  serialRead += inChar;
  //print(inChar);
  if (inChar == '\n' /*&& !firstRead*/) {
    try {
    serialHeading = Float.parseFloat(serialRead);
    } catch (Exception e) {
      println("I caught: " + e);
    }
    //print(serialRead);
    serialRead = "";
    //println();
  }
  /*
  if (inChar == '\n' && firstRead) {
    serialRead = "";
    firstRead = false;
  }
  */
}
