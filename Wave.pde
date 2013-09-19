class Wave {
  int xspacing;     // How far apart should each horizontal location be spaced
  int w;            // Width of entire wave
  float theta;      // Start angle at 0
  float amplitude;  // Height of wave
  float period;     // How many pixels before the wave repeats
  float dx;         // Value for incrementing X, a function of period and xspacing
  float[] yvalues;  // Using an array to store height values for the wave
  float angularVelocity; //value by which to incrememnt theta
  
  Wave(float thisAmplitude, float numWavesOnScreen, float startAngle, float thisAV) {
    w = width;
    xspacing = 10;
    theta = startAngle;
    angularVelocity = thisAV;
    
    amplitude = thisAmplitude;
    float period = width/numWavesOnScreen;
    dx = (TWO_PI / period) * xspacing;
    yvalues = new float[w/xspacing];
  }
  
  void update() {
    // Increment theta (try different values for 'angular velocity' here
    theta += angularVelocity;
  
    // For every x value, calculate a y value with sine function
    float x = theta;
    for (int i = 0; i < yvalues.length; i++) {
      yvalues[i] = sin(x) * amplitude;
      x+=dx;
    }
  }
  
  void display() {
    smooth();
    noFill();
    beginShape();
    // A simple way to draw the wave with an ellipse at each location
    for (int x = 0; x < yvalues.length; x++) {
      curveVertex(x*xspacing, height/2+yvalues[x]);
    }
    endShape();
  }
}
