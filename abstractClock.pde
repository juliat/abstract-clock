// Credit to Golan Levin for time boilerplate and Daniel Shiffman for Sine Wave Example

int prevSecond; 
int lastRolloverTime; 
int mils;

int h;
int m;
int s;

Wave secondsWave;
Wave minutesWave;
ArrayList<Wave> hoursWaves;

void setup() {
  size(640, 360);
  stroke(120);
  
  // Fetch the components of the time (hours, minutes, seconds, milliseconds).
  // Incidentally, you can also get day(), month(), year(), etc. 
  h = hour(); 
  m = minute(); 
  s = second(); 
  
  // arguments for Wave constructor are (amplitude, frequency, horizontalShift, verticalShift)
  

  lastRolloverTime = 0; 
  background(255); 
}
 
void draw() {
  background(255); 
  noFill();
 
  //-------------------------------------------------
  // Fetch the components of the time (hours, minutes, seconds, milliseconds).
  // Incidentally, you can also get day(), month(), year(), etc. 
  h = hour(); 
  m = minute(); 
  s = second(); 
 
  // The millis() are not synchronized with the clock time. 
  // Instead, the millis() represent the time since the program started. Grrr. 
  // To approximate the "clock millis", we have to check when the seconds roll over. 
  if (s != prevSecond){ 
    lastRolloverTime = millis(); 
  }
  mils = millis() - lastRolloverTime;
  prevSecond = s;
  
  // draw time as text for debugging
  drawTime();
 

}

ArrayList<Wave> hoursWaves() {
  ArrayList<Wave> hoursWaves= new ArrayList<Wave>();
  // for every hour but the current one, draw a very slow moving wave at the top of the screen
  for (int i = 0; i < h; i++) {
    Wave hWave = 
    hoursWaves.add(hWave);  
  }
  return hoursWaves;
}


// just here to help develop and debug
void drawTime() {
  //-------------------------------------------------
  // Assemble a string to display the time conventionally.
  String hourStr   = nf(((h > 12)? h-12:h), 2); // format String with 2 digits
  String minuteStr = nf(m, 2); // format String with 2 digits
  String secondStr = nf(s, 2); // format String with 2 digits
  String ampmStr   = (h < 12) ? "AM" : "PM"; 
  String milsStr   = nf(mils, 3); 
  String theTimeString = hourStr + ":" + minuteStr + ":" + secondStr; 
  theTimeString += "." + milsStr + " " + ampmStr; 
 
  fill (0); 
  textAlign (CENTER); 
  text (theTimeString, width/5, 10); 
  noFill();
}
