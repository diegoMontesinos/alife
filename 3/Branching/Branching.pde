
float angle = 80;

void setup() {
  size(500, 500);
}

void draw() {
  background(255);

  translate(250, 500);
  branch(150);
  
  angle = map(mouseX, 0, width, -360, 360);
}

void branch(float len) {
  // Tronco
  line(0, 0, 0, -len);

  translate(0, -len);

  // Nueva longitud
  float newLen = len * 0.6;
  if (newLen < 2) {
    return;
  } 
  else {
    // Rama izquierda
    pushMatrix();
    rotate(radians(angle));
    branch(newLen);
    popMatrix();

    // Rama derecha
    pushMatrix();
    rotate(-radians(angle));
    branch(newLen);
    popMatrix();
  }
}

