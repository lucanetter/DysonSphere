public float radius; //sun in our system has radius of 696,340 km
import java.math.BigInteger;
import java.math.BigDecimal;
import java.math.MathContext;


class Sun{
float mass; //suns mass is 1.989 × 10^30 kg
BigInteger output; //must use Stefan-Boltzmann law, L = 4πR^2σT^4, σ = 5.67037442 × 10^-8
ArrayList<PVector[]> lines;
int numberOfRays;
float rotate;
float calculatedRadius;

  Sun(float newRadius){
    calculatedRadius = newRadius * 1000; //meters
    radius = newRadius / 100000; //to smaller number
    numberOfRays = 25;
    lines = new ArrayList<PVector[]>(numberOfRays); //numberOfRays is amount of rays i want to draw
  }

  void getOutput(){
    BigDecimal radiusSquared = new BigDecimal(calculatedRadius).pow(2, MathContext.DECIMAL128);
    BigDecimal sigmaSB = new BigDecimal("5.67037442e-8");
    BigDecimal temperature = new BigDecimal(5778); //temp in kelvin
    BigDecimal piMultiplier = BigDecimal.valueOf(4).multiply(BigDecimal.valueOf(Math.PI));
    
    //calculate L = 4 * π * R^2 * σSB * T^4
    BigDecimal outputDecimal = piMultiplier
            .multiply(radiusSquared)
            .multiply(sigmaSB)
            .multiply(temperature.pow(4));
    
    output = outputDecimal.toBigInteger();
  }
  
  BigInteger returnOutput(){
    return output;
  }
  
  void increasedRadius(){
    radius += 1;
    calculatedRadius = radius * 100000 * 1000;
  }
  
  void decreasedRadius(){
    radius = max(1, radius - 1);
    calculatedRadius = radius * 100000 * 1000;
  }  
  
  void drawSun(float rotate){  
    rotateY(rotate);

    pushMatrix();
    strokeWeight(0);
    stroke(200, 200, 0);
    fill(200, 200, 0);
    sphere(radius);
    popMatrix();
  }
  
  void drawLines(){
    lines.clear(); //clear array for new set of lines with new radius
    for(int i = 0; i < numberOfRays; i++){
      float x1 = cos(TWO_PI / numberOfRays * i) * radius;
      float y1 = sin(TWO_PI / numberOfRays * i) * radius;

      float x2 = cos(TWO_PI / numberOfRays * i) * (radius + dyson.getEdgeLength() / 120000); //
      float y2 = sin(TWO_PI / numberOfRays * i) * (radius + dyson.getEdgeLength() / 120000);

      PVector[] lineX = {new PVector(x1, y1, 0), new PVector(x2, y2, 0)}; //lines on x axis
      lines.add(lineX);

      PVector[] lineY = {new PVector(x1, 0, y1), new PVector(x2, 0, y2)}; //lines on y axis
      lines.add(lineY);

      PVector[] lineZ = {new PVector(0, x1, y1), new PVector(0, x2, y2)}; //lines on z axis
      lines.add(lineZ);
    }
    
    for(PVector[] line : lines){
      strokeWeight(1);
      stroke(200, 0, 0);
      line(line[0].x, line[0].y, line[0].z, line[1].x, line[1].y, line[1].z);
    }
    
    stroke(0, 255, 0);
    line(-(radius + dyson.getEdgeLength() / 120000) - radius, 0, 0, (radius + dyson.getEdgeLength() / 120000) + radius , 0, 0);
  }
}
