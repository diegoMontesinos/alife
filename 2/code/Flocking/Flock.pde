
class Flock {

  // Boids (Elementos de la manada)
  LinkedList<Boid> boids;
  int nBoids;

  // Alcance de vista de los boids
  float eyesight = 35.0;
  float minDistance = 15.0;

  // Reglas
  float wAvoidRule = 2.5;
  float wCopyRule = 1.0;
  float wCenterRule = 1.0;

  float maxSpeed = 2;
  float maxForce = 0.06;

  ToxiclibsSupport gfx;
  Voronoi voronoi;

  Flock(int nBoids, ToxiclibsSupport gfx) {
    this.nBoids = nBoids;

    this.boids = new LinkedList<Boid>();
    for (int i = 0; i < nBoids; i++) {
      this.boids.add(new Boid(random(width), random(height), this));
    }

    this.gfx = gfx;
  }

  void update() {
    for (int i = 0; i < this.boids.size(); i++) { 
      this.boids.get(i).update();
    }
  }

  void render() {
    voronoi = new Voronoi(Voronoi.DEFAULT_SIZE);

    for (int i = 0; i < this.boids.size(); i++) {
      //this.boids.get(i).render();
      
      Boid boid = this.boids.get(i);
      voronoi.addPoint(new Vec2D(boid.pos.x, boid.pos.y));
    }
    
    //noFill();
    //stroke(0);
    noStroke();
    beginShape(CLOSE);
    for (Polygon2D p : voronoi.getRegions()) {
      fill(color(random(255), random(255), random(255)));
      gfx.polygon2D(p);
    }
    endShape();
  }
}

