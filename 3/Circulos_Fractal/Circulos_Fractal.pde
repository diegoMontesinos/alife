
void setup() {
  size(1500, 1500);
  background(255);
  noFill();
  
  pintaCirculo(500, 500, 200);
}

void draw() {
}

void pintaCirculo(float x, float y, float radius) {
  ellipse(x, y, radius * 2.0, radius * 2.0);
  
  if(radius < 20) {
    return;
  } else {
    pintaCirculo(x + radius, y, radius * 0.5);
    pintaCirculo(x - radius, y, radius * 0.5);
    
    pintaCirculo(x, y + radius, radius * 0.5);
    pintaCirculo(x, y - radius, radius * 0.5);
  }
}
