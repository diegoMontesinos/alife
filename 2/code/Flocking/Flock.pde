
class Flock {

  // Boids (Elementos de la manada)
  LinkedList<Boid> boids;
  int nBoids;

  /*
  // Alcance de vista de los boids
   float eyesight = 25.0;
   float minDistance = 15.0;
   
   // Reglas
   float wAvoidRule = 1.5;
   float wCopyRule = 1.0;
   float wCenterRule = 1.0;
   
   float maxSpeed = 2;
   float maxForce = 0.06;
   */

  Flock(int nBoids) {
    this.nBoids = nBoids;

    this.boids = new LinkedList<Boid>();
    for (int i = 0; i < nBoids; i++) {
      this.boids.add(new Boid(random(width), random(height), this));
    }
  }

  void update() {
    for (int i = 0; i < this.boids.size(); i++) { 
      this.boids.get(i).update();
    }
  }

  void render() {
    for (int i = 0; i < this.boids.size(); i++) {
      this.boids.get(i).render();
    }
  }
}

