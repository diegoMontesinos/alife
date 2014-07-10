
class Boid {

  // Esta sujeto a una manada
  Flock parentFlock;

  // Posición y el movimiento del boid
  PVector pos;
  PVector vel;

  Boid(float posX, float posY, Flock parentFlock) {
    this.pos = new PVector(posX, posY);
    this.vel = new PVector(random(-1, 1), random(-1, 1));
    this.parentFlock = parentFlock;
  }

  void update() {
    this.pos.add(vel);

    // Corregimos la posicion
    if (this.pos.x > width)  this.pos.x = 0;
    if (this.pos.x < 0)      this.pos.x = width;  
    if (this.pos.y > height) this.pos.y = 0;
    if (this.pos.y < 0)      this.pos.y = height;
  }

  void render() {
    fill(0);
    noStroke();

    ellipse(pos.x, pos.y, 4, 4);
  }
}

