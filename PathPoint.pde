class PathPoint {
  
  PVector longLat = new PVector();
  long timeStamp;
  Date date;
  
  PVector pos = new PVector();
  PVector tpos = new PVector();
  
  float lon;
  float lat;
  
  color col = 255;
  
  void update(){
    pos.lerp(tpos, 0.1);
  }
  
  void render(){
    pushMatrix();
      translate(pos.x, pos.y, pos.z);
      fill(col);
      noStroke();
      //ellipse(0, 0, 5, 5);
      rect(0, 0, 1.5, 1.5);
    popMatrix();
  }
}
