import java.math.BigInteger;
import java.math.BigDecimal;
import java.math.MathContext;

class Dodecahedron{
  PVector[] vert;
  int[][] faces;
  int face = 12;
  int verticies = 5;
  float gR = 1.618033989; //goldren ratio, from wikipedia article
  float gR2 = 0.618033989; //1/goldren ratio, from wikipedia article
  float rotate;
  
  void createDodecahedron(){
    vert = new PVector[20];
    
    //cartisian coordinates for verticies
    //https://en.wikipedia.org/wiki/Regular_dodecahedron#Facet-defining_equations
    //this is 95 worthy code please i need an a- in the class
    //(±1, ±1, ±1)
    //(0, ±ϕ, ±1/ϕ)
    //(±1/ϕ, 0, ±ϕ)
    //(±ϕ, ±1/ϕ, 0)

    //verticies for (±1, ±1, ±1)
    vert[0] = new PVector(1, 1, 1);
    vert[1] = new PVector(1, 1, -1);
    vert[2] = new PVector(1, -1, 1);
    vert[3] = new PVector(1, -1, -1);
    vert[4] = new PVector(-1, 1, 1);
    vert[5] = new PVector(-1, 1, -1);
    vert[6] = new PVector(-1, -1, 1);
    vert[7] = new PVector(-1, -1, -1);

    //verticies for (0, ±ϕ, ±1/ϕ)
    vert[8] = new PVector(0, gR2, gR);
    vert[9] = new PVector(0, gR2, -gR);
    vert[10] = new PVector(0, -gR2, gR);
    vert[11] = new PVector(0, -gR2, -gR);

    //verticies for (±1/ϕ, 0, ±ϕ)
    vert[12] = new PVector(gR2, gR, 0);
    vert[13] = new PVector(gR2, -gR, 0);
    vert[14] = new PVector(-gR2, gR, 0);
    vert[15] = new PVector(-gR2, -gR, 0);

    //verticies for (±ϕ, ±1/ϕ, 0)
    vert[16] = new PVector(gR, 0, gR2);
    vert[17] = new PVector(gR, 0, -gR2);
    vert[18] = new PVector(-gR, 0, gR2);
    vert[19] = new PVector(-gR, 0, -gR2);

    //creating the 12 pentagonal faces
    faces = new int[face][verticies];
    faces[0] = new int[]{0, 16, 2, 10, 8};
    faces[1] = new int[]{0, 8, 4, 14, 12};
    faces[2] = new int[]{16, 17, 1, 12, 0};
    faces[3] = new int[]{1, 9, 11, 3, 17};
    
    faces[4] = new int[]{1, 12, 14, 5, 9};
    faces[5] = new int[]{2, 13, 15, 6, 10};
    faces[6] = new int[]{13, 3, 17, 16, 2};
    faces[7] = new int[]{3, 11, 7, 15, 13};
    
    faces[8] = new int[]{4, 8, 10, 6, 18};
    faces[9] = new int[]{14, 5, 19, 18, 4};
    faces[10] = new int[]{5, 19, 7, 11, 9};
    faces[11] = new int[]{15, 7, 19, 18, 6};
  }

  
  long getEdgeLength(){
    long edgeLength = (long)(6 * (radius * 100000) * sqrt((3 + sqrt(5)) / 2));
    return edgeLength;
  }
  
  long getSurfaceArea(){
    //surface area equation: a = 3 * L^2(rad(25 + 10(rad5))) (l= length of edge, radius * 1.5)
    long surfaceArea = 3 * (long)(pow(this.getEdgeLength(), 2) * sqrt(25 + 10 * sqrt(5)));
    return surfaceArea;
  }
  
  BigInteger getCost(){ //its estimated that 1m^2 of solar panel is 200
    BigInteger surface = BigInteger.valueOf(this.getSurfaceArea());
    BigInteger panel = BigInteger.valueOf(200 * 1000000); //$200 x amount of m^2 in 1 km^2
    BigInteger cost = (surface.multiply(panel));
    
    return cost;
  }
  
  BigInteger getMass(){ //1m^2 solar panel around 7kg
    BigInteger surface = BigInteger.valueOf(this.getSurfaceArea());
    BigInteger panelMass = BigInteger.valueOf(7 * 1000000); //7kg x amount of m^2 in 1 km^2
    BigInteger mass = (surface.multiply(panelMass));
    
    return mass;
  }
  
  //from wikiepdia article
  BigInteger getVolume(){
    BigDecimal constant1 = new BigDecimal("15");
    BigDecimal constant2 = new BigDecimal("7");
    BigDecimal constant3 = new BigDecimal("5");

    float edgeLengthFloat = getEdgeLength();
    BigDecimal edgeLength = BigDecimal.valueOf(edgeLengthFloat);

    BigDecimal sqrtResult = BigDecimal.valueOf(Math.sqrt(constant3.doubleValue()));

    BigDecimal volumeDecimal = constant1.add(constant2.multiply(sqrtResult))
            .divide(new BigDecimal("4"), MathContext.DECIMAL128)
            .multiply(edgeLength.pow(3));
    BigInteger volume = volumeDecimal.toBigInteger();
    return volume;
  }
  
  
  void drawDodecahedron(float rotate){
    stroke(225);
    noFill();
    
    pushMatrix();
    rotateY(rotate);  

    for(int i = 0; i < face; i++){
      beginShape();
      strokeWeight(1);
      for(int j = 0; j < verticies; j++){
        PVector v = vert[faces[i][j]];
        vertex(v.x * radius * 6, v.y * radius * 6, v.z * radius * 6); //radius of sphere should be 4,178,040 km
      }
      endShape(CLOSE);
    }
    popMatrix();
  }
}
