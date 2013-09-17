// Credit to Golan Levin for time boilerplate and Daniel Shiffman for Sine Wave Example

int prevSecond; 
int lastRolloverTime; 
int mils;

int framesPerSecond;

int h;
int m;
int s;

Wave secondsWave;
Wave minutesWave;
ArrayList<Wave> hoursWaves;

void setup() {
  size(640, 360);
  
  // Fetch the components of the time (hours, minutes, seconds, milliseconds).
  // Incidentally, you can also get day(), month(), year(), etc. 
  h = hour(); 
  m = minute(); 
  s = second(); 
  
  framesPerSecond = 30;
  // arguments for Wave constructor are amplitude, numWavesOnScreen, startAngle, howFrequentlyExitingScreen
  secondsWave = new Wave(10.0, 1, 0, 0.06);
  minutesWave = new Wave(15.0, 1, 0, 0.00);
  lastRolloverTime = 0; 
  hoursWaves = hoursWaves();
}
 
void draw() {
  background(255); 
  noFill();
  smooth();
 
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
  
  drawTime();
 
  secondsWave.update();
  secondsWave.display();
  minutesWave.update();
  minutesWave.display();
  
  for (int i = 0; i < hoursWaves.size(); i++) {
    Wave hWave= hoursWaves.get(i);
    hWave.update();
    pushMatrix();
    float startY = (height/h)*-1;
    translate(0, startY + (-10*(i^2)));
    hWave.display();
    popMatrix();
  }
}

ArrayList<Wave> hoursWaves() {
  ArrayList<Wave> hoursWaves= new ArrayList<Wave>();
  // for every hour but the current one, draw a very slow moving wave at the top of the screen
  for (int i = 0; i < h; i++) {
    float period =  1;// hours waves should go through --- pixels before the wave repeats
    float startAngle = 0.33*i;
    Wave hWave = new Wave(5.0, period, startAngle, 0.0001*i);
    hoursWaves.add(hWave);  
  }
  return hoursWaves;
}


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
