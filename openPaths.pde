import java.util.Date;

//{
//        "lon": -73.993293762207031, 
//        "lat": 40.729747772216797, 
//        "version": "1.1", 
//        "t": 1410198272, 
//        "device": "iPhone6,1", 
//        "alt": 17.601266860961914, 
//        "os": "7.1.2"
//    }, 

////boundingbox.klokantech.com (mapping resource!!!) (choose to copy as csv raw)


ArrayList<PathPoint> allPoints = new ArrayList();

int step = 0;

void setup(){
  size(1280, 720, P3D);
  loadPaths("openpaths_fletcher2.json");
}

void draw(){
  background(0);
  for(int i = 0; i < allPoints.size(); i++){
    PathPoint p = allPoints.get(i);
    p.update();
    p.render();
    //render the leader
//    if(i == step){
//      stroke(255,0,0);
//      pushMatrix();
//        translate(p.pos.x, p.pos.y, p.pos.z);
//        ellipse(0,0,10,10);
//      popMatrix();
//      
//      //time stamp animated as text
//      fill(255);
//      text(p.date.toString(), 50, 50);
//    }
  }
//  step++;
  if(step == allPoints.size()) step = 0;
}

void loadPaths(String fileName){
  //load the JSON
  JSONArray path = loadJSONArray(fileName);
  
  //iterate through the entries
  for(int i = 0; i < path.size(); i++){
    JSONObject point = path.getJSONObject(i);
    //println(point.getFloat("lat"));
    float lat = point.getFloat("lat");
    float lon = point.getFloat("lon");
    float x = map(lon, -180, 180, 0, width);
    float y = map(lat, -90, 90, height, 0);
    
    //Make a PathPoint object to hold the data
    PathPoint p = new PathPoint();
    p.lat = lat;
    p.lon = lon;
    p.tpos.x = x;
    p.tpos.y = y;
    
    //Add the new PathPoint to our arraylist
    allPoints.add(p);
    
    //Time
    p.timeStamp = point.getLong("t") * 1000;
    p.date = new Date(p.timeStamp);
  } 
}

void positionByBounds(float left, float bottom, float right, float top){
   //-74.11, 40.66, -73.83, 40.79
   for(PathPoint p:allPoints){
     float x = map(p.lon, left, right, 0, width);
     float y = map(p.lat, bottom, top, height, 0);
     p.tpos.set(x,y);
     
     float c = map(p.date.getHours(), 0, 23, 0, 255);
     //p.col = color(255, c, 0);  //warm colors
     p.col = color(80, 210, c);//cool colors
     //p.col = color(c, 255, 255); //raindbow colors
   }
}

void positionByTime(){
  
  long start = allPoints.get(0).timeStamp;
  long end = allPoints.get(allPoints.size() - 1).timeStamp;
  
  for(PathPoint p:allPoints){
     float x = map(p.timeStamp, start, end, 0, width);
     float y = map(p.lat, -90, 90, 600, 300);
     p.tpos.set(x,y);
   }
}

void keyPressed(){
  if(key == 'n') positionByBounds(-74.11, 40.66, -73.83, 40.79);
  if(key == 'g') positionByBounds(-180, -90, 180, 90);
  if(key == 't') positionByTime();
}



