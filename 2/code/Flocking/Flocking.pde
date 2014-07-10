import java.util.LinkedList;

Flock flock;

void setup() {
  size(500, 500);
  
  flock = new Flock(10);
}

void draw() {
  background(255);
  
  flock.update();
  flock.render();
}

