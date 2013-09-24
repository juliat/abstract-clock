class Wave {
  float amplitude;
  float frequency;
  float horizontalShift;
  float verticalShift;
  int pointSpacing;
  ArrayList<PVector> points;
  
  Wave(float thisAmplitude, float thisFrequency, float thisHorizontalShift, float thisVerticalShift, int thisPointSpacing) {
   amplitude = thisAmplitude;
   frequency = thisFrequency;
   horizontalShift = thisHorizontalShift;
   verticalShift = thisVerticalShift;
   pointSpacing = thisPointSpacing;
   points = new ArrayList<PVector>();
  }
  
  // gets the y value for a given x position on this wave
  float getY(float xAngle) {
    float y = amplitude * sin((frequency * xAngle) + horizontalShift) + verticalShift;
    return y;
  }
  
  // calculate and store positions for each point that's a part of this wave
  void update() {
    // for each x position across the window, get the y outputted by the wave function
    for (int x=0; x < width; x++) {
      float xAngle = map(x, 0, width, 0, TWO_PI);
      PVector xyPoint = new PVector(x, getY(xAngle));
      points.add(xyPoint);
    }
  }
  
  void display() {
    // setup drawing settings
    smooth();
    noFill();

    // draw points that make up the curve
    beginShape();
    for (int pointNum = 0; pointNum < points.size(); pointNum++) {
      PVector point = points.get(pointNum);
      vertex(point.x, point.y);
    }
    endShape();
  }
}
