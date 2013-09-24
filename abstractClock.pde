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
float baseWaveHeight;

void setup() {
  size(640, 360);
  baseWaveHeight = height/8;
  
  stroke(120);
  setupGlobalTimes();
  
  // initialize objects
  hoursWaves = createHoursWaves();
  minutesWave = createMinutesWave();
  secondsWave = createSecondsWave();
  
  lastRolloverTime = 0; 
}
 
void draw() {
  background(255); 
  noFill();
 
  setupGlobalTimes();
  // draw time as text for debugging
  drawTime();
  
  pushMatrix();
  translate(0, height/2);
  
  secondsWave.update();
  secondsWave.display();
  minutesWave.update();
  minutesWave.display();
  for (int i = 0; i < hoursWaves.size(); i++) {
    Wave hWave = hoursWaves.get(i);
    hWave.update();
    hWave.display();
  }
  
  popMatrix();
  // noLoop();
}

Wave createSecondsWave() {
  float amp = baseWaveHeight;
  float freq = 0.75;
  // arguments for Wave constructor are (amplitude, frequency, horizontalShift, verticalShift, pointSpacing)
  Wave sWave = new Wave(amp, freq, 0, (height/3), 5);
  return sWave;
}

Wave createMinutesWave() {
  float amplitude = baseWaveHeight/2;
  float frequency = 1.5;
  int pointSpacing = 5;
  Wave mWave = new Wave(amplitude, frequency, 0, 0, pointSpacing);
  return mWave;
}

ArrayList<Wave> createHoursWaves() {
  ArrayList<Wave> hoursWaves= new ArrayList<Wave>();
  // for every hour but the current one, draw a very slow moving wave at the top of the screen
  for (int i = 0; i < h; i++) {
    // arguments for Wave constructor are (amplitude, frequency, horizontalShift, verticalShift, pointSpacing)
    float amplitude = baseWaveHeight/4;
    float frequency = 1;
    float vShift = -1*(height/2) + (i*(baseWaveHeight/5));
    int pointSpacing = 5;
    Wave hWave = new Wave(amplitude, frequency, 0, vShift, pointSpacing);
    hoursWaves.add(hWave);  
  }
  return hoursWaves;
}

void setupGlobalTimes() {
  // Fetch the components of the time (hours, minutes, seconds, milliseconds).
  // Incidentally, you can also get day(), month(), year(), etc. 
  h = hour(); 
  m = minute(); 
  s = second(); 
}

void setMils(){
  // The millis() are not synchronized with the clock time. 
  // Instead, the millis() represent the time since the program started. Grrr. 
  // To approximate the "clock millis", we have to check when the seconds roll over. 
  if (s != prevSecond){ 
    lastRolloverTime = millis(); 
  }
  mils = millis() - lastRolloverTime;
  prevSecond = s;
}


// just here to help develop and debug
void drawTime() {
  setMils();
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
  text (theTimeString, width/5, 10); 
  noFill();
}
