class Button{
  float x;
  float y;
  float w;
  float h;
  String label; 

  Button(float x, float y, float w, float h, String label){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
  }
  
  void display(){
    fill(255, 255, 255);
    stroke(0, 0, 0);
    rect(x, y, w, h);
    textSize(20);
    fill(0);
    
    textAlign(CENTER);
    text(label, x + w / 2, y + (h / 2));
  }
  
  boolean clicked(int mx, int my){
    if(mx > x && mx < x + w  && my > y && my < y + h){
      //mouse has been clicked
      if(label.equals("Radius+")){
        sun.increasedRadius(); //increases the radius by 100000 km
      }
      
      if(label.equals("Radius-")){
        sun.decreasedRadius(); //decreases the radius by 100000 km
      }
      return true;
    }
    return false;
  }
}
