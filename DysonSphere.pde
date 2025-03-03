import peasy.*;
import java.math.BigInteger;

PeasyCam cam;
Sun sun;
Dodecahedron dyson;
Button increase;
Button decrease;

float newRadius = 696340;
float dodecahedronRotation = 0.07145; //for it not to collapse, must spin 14.29x faster than sun
float sunRotation = 0.005;

void setup(){
  size(800, 800, P3D);
  frameRate(60);
  background(0);
  
  dyson = new Dodecahedron();
  sun = new Sun(newRadius);
  
  increase = new Button(10, 700, 100, 40, "Radius+");
  decrease = new Button(120, 700, 100, 40, "Radius-");
  
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(10 * newRadius / 25000); //camera for starting sun radius
  cam.setMaximumDistance(25 * newRadius / 25000);
  
  PeasyDragHandler orbitDH = cam.getRotateDragHandler();
  cam.setCenterDragHandler(orbitDH);
  
  PeasyDragHandler panDH = cam.getPanDragHandler();     
  cam.setRightDragHandler(panDH);
  
  PeasyDragHandler rotateDH = cam.getRotateDragHandler();     
  cam.setLeftDragHandler(rotateDH); 
}


void draw(){
  background(0);
  dyson.createDodecahedron();
  dyson.drawDodecahedron(dodecahedronRotation);   
  dodecahedronRotation += 0.07145; //rotation period is around 41 hrs, about 0.07 of the suns, which is 24.47 days (14.29 times longer)
  
  sun.drawSun(sunRotation);
  sun.drawLines();
  sunRotation += 0.005;      
  
  drawHUD();
}

String formatWithCommas(Number value){
  String stringValue = String.valueOf(value);
  int length = stringValue.length();
  StringBuilder result = new StringBuilder();
  int commaPosition = length % 3;
  
  if(commaPosition == 0){
    commaPosition = 3;
  }

  for(int i = 0; i < length; i++){
    result.append(stringValue.charAt(i));
    commaPosition--;
    
    if(commaPosition == 0 && i < length - 1){
        result.append(",");
        commaPosition = 3;
    }
  }
  return result.toString();
}

void drawHUD(){
  sun.getOutput();

  cam.beginHUD();
  textSize(20);
  textAlign(BASELINE);
  fill(255, 255, 255);
  text("Dyson Sphere Measurements:", 5, 30);
  text("Surface Area: " + formatWithCommas(dyson.getSurfaceArea()) + " KM^2", 5, 60);
  text("Volume: " + formatWithCommas(dyson.getVolume()) + " KM^3", 5, 90); 
  text("Edge Length: " + formatWithCommas(dyson.getEdgeLength()) + " KM", 5, 120); //radius about 6 times larger than our sun
  text("Cost: $" + formatWithCommas(dyson.getCost()), 5, 150);
  text("Mass: " + formatWithCommas(dyson.getMass()) + " KG", 5, 180);
  text("Power Generated: " + formatWithCommas(sun.returnOutput()) + " Watts/Second", 5, 210); //considering dyson sphere is 100% efficent
  increase.display();
  decrease.display();
  cam.endHUD();
}

void mouseClicked(){
  if(increase.clicked(mouseX, mouseY)){
    sun.increasedRadius();
    sun.drawLines();
    sun.getOutput();
  }else if(decrease.clicked(mouseX, mouseY)){
    sun.decreasedRadius();
    sun.drawLines();
    sun.getOutput();
  }
}
