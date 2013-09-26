// Credit to Golan Levin for time boilerplate and Daniel Shiffman for Sine Wave Example

int prevSecond; 
int lastRolloverTime; 
int mils;

int h;
int m;
int s;

Wave secondsWave;
ArrayList<Wave> minutesWaves;
ArrayList<Wave> hoursWaves;
float baseWaveHeight;

void setup() {
  size(640, 360);
  baseWaveHeight = height/8;
  
  stroke(120);
  setupGlobalTimes();
  
  // initialize objects
  hoursWaves = createHoursWaves();
  minutesWaves = createMinutesWaves();
  secondsWave = createSecondsWave();
  
  lastRolloverTime = 0; 
}
 
void draw() {
  background(255); 
 
  setMils();
  setupGlobalTimes();
  // draw time as text for debugging
  drawTime();
  
  pushMatrix();
  // int hShift = mils();
  translate(0, height/2); // work relative to horizontal venter at middle
  
  float periodInSeconds = 60.0; 
  float periodInMilliseconds = periodInSeconds * 1000.0; 
  float timeBasedSinusoidallyVaryingQuantity = sin(TWO_PI * millis()/periodInMilliseconds);
  
  /* calculate and update seconds waves */
  float secondsVShift = map(timeBasedSinusoidallyVaryingQuantity, -1, 1, 0, (height/2.8));
  secondsWave.verticalShift = secondsVShift;
  
  float millisToCrossScreen = 1000.0;
  float secondsHShift = getCurrentHShift(millisToCrossScreen);
  
  secondsWave.horizontalShift = secondsHShift;
  secondsWave.update();
  secondsWave.display();
  
  /* calculate and update minutes wave */
  millisToCrossScreen = 3 * 1000.0;
  for (int i = 0; i < minutesWaves.size(); i+=5) {
    Wave minutesWave = minutesWaves.get(i);
    float minutesHShift = getCurrentHShift(millisToCrossScreen);
    minutesWave.horizontalShift = minutesHShift;
    minutesWave.update();
    minutesWave.display();
  }
  
  /* calculate and update hours wave */ 
  millisToCrossScreen = 30.0 * 1000.0;
  float hoursHShift = getCurrentHShift(millisToCrossScreen);
  for (int i = 0; i < hoursWaves.size(); i++) {
    Wave hWave = hoursWaves.get(i);
    hWave.horizontalShift = hoursHShift*(i/3);
    hWave.update();
    hWave.display();
  }  
  popMatrix();
}

float getCurrentHShift(float millisToCrossScreen) {
  float hShift = millis()/millisToCrossScreen;
  return hShift;
}
  

Wave createSecondsWave() {
  float amp = baseWaveHeight*1.1;
  float freq = 0.75;
  // arguments for Wave constructor are (amplitude, frequency, horizontalShift, verticalShift, pointSpacing)
  Wave sWave = new Wave(amp, freq, 0, (height/1.5), 5);
  return sWave;
}

ArrayList<Wave> createMinutesWaves() {
  ArrayList<Wave> minutesWaves= new ArrayList<Wave>();
  println("m " + m);
  for (int i=0; i < m; i++) {
    println("i " + i);
    float amplitude = baseWaveHeight/3;
    float frequency = 1.5;
    int pointSpacing = 5;
    float allShiftUp = -1*(height/10);
    float perWaveOffset = i*(baseWaveHeight/30);
    float vShift = allShiftUp + perWaveOffset;
    float hShift = i*(width/20);
    Wave mWave = new Wave(amplitude, frequency, hShift, vShift, pointSpacing);
    minutesWaves.add(mWave);
  }
  return minutesWaves;
}

ArrayList<Wave> createHoursWaves() {
  ArrayList<Wave> hoursWaves= new ArrayList<Wave>();
  // for every hour but the current one, draw a very slow moving wave at the top of the screen
  for (int i = 0; i < h; i++) {
    // arguments for Wave constructor are (amplitude, frequency, horizontalShift, verticalShift, pointSpacing)
    float amplitude = baseWaveHeight/4;
    float frequency = 1;
    float perWaveOffset = (i*(baseWaveHeight/4));
    float allShiftUp = -1*(height/2); 
    float vShift = allShiftUp + perWaveOffset;
    int pointSpacing = 5;
    Wave hWave = new Wave(amplitude, frequency, (i/3), vShift, pointSpacing);
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
