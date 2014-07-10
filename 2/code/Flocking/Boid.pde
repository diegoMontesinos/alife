
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

    LinkedList<Boid> brothers = this.parentFlock.boids; 

    //Sacamos el vecinadario que alcanza a percibir el elemento
    LinkedList<Boid> neighborhood = new LinkedList<Boid>();
    for (int i = 0; i < brothers.size(); i++) {
      float distance = PVector.dist(this.pos, brothers.get(i).pos);
      if ((distance > 0) && (distance <= this.parentFlock.eyesight)) {
        neighborhood.add(brothers.get(i));
      }
    }

    // Obtenemos el cambio de velocidad del elemento con las 3 reglas de manada
    PVector vAvoid = avoidRule(neighborhood);
    vAvoid.mult(this.parentFlock.wAvoidRule);
    
    PVector vCopy = copyRule(neighborhood);
    vCopy.mult(this.parentFlock.wCopyRule);
    
    PVector vCenter = centerRule(neighborhood);
    vCenter.mult(this.parentFlock.wCenterRule);

    // Obtenemos el vector de cambio en base a las reglas
    PVector vRules = new PVector(0, 0);
    vRules.add(vAvoid);
    vRules.add(vCopy);
    vRules.add(vCenter);

    this.vel.add(vRules);
    this.vel.limit(this.parentFlock.maxSpeed);
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

    ellipse(pos.x, pos.y, 6, 6);
  }

  PVector avoidRule(LinkedList<Boid> neighborhood) {
    PVector vAvoid = new PVector(0, 0);

    for (int i = 0; i < neighborhood.size(); i++) {
      Boid neighbor = neighborhood.get(i);

      float distance = PVector.dist(this.pos, neighbor.pos);
      if ((distance > 0) && distance < (this.parentFlock.minDistance)) {
        PVector diff = PVector.sub(this.pos, neighbor.pos);
        diff.normalize();
        diff.div(distance);
        vAvoid.add(diff);
      }
    }

    if (!neighborhood.isEmpty()) {
      vAvoid.div((float) neighborhood.size());
    }

    if (vAvoid.mag() > 0) {
      vAvoid.normalize();
      vAvoid.mult(this.parentFlock.maxSpeed);
      vAvoid.sub(this.vel);
      vAvoid.limit(this.parentFlock.maxForce);
    }

    return vAvoid;
  }

  PVector copyRule(LinkedList<Boid> neighborhood) {
    PVector vCopy;

    PVector averageVelocity = new PVector(0, 0);
    for (int i = 0; i < neighborhood.size(); i++) {
      Boid neighbor = neighborhood.get(i);
      averageVelocity.add(neighbor.vel);
    }

    if (!neighborhood.isEmpty()) {
      averageVelocity.div((float) neighborhood.size());
      averageVelocity.normalize();
      averageVelocity.mult(this.parentFlock.maxSpeed);
      vCopy = PVector.sub(averageVelocity, this.vel);
      vCopy.limit(this.parentFlock.maxForce);
    } 
    else {
      vCopy = new PVector(0, 0);
    }

    return vCopy;
  }

  PVector centerRule(LinkedList<Boid> neighborhood) {
    PVector vCenter;

    PVector averagePosition = new PVector(0, 0);
    for (int i = 0; i < neighborhood.size(); i++) {
      Boid neighbor = neighborhood.get(i);
      averagePosition.add(neighbor.pos);
    }

    if (!neighborhood.isEmpty()) {
      averagePosition.div(neighborhood.size());
      PVector desiredPosition = PVector.sub(averagePosition, this.pos);
      desiredPosition.normalize();
      desiredPosition.mult(this.parentFlock.maxSpeed);
      vCenter = PVector.sub(desiredPosition, this.vel);
      vCenter.limit(this.parentFlock.maxForce);
    } 
    else {
      vCenter = new PVector(0, 0);
    }

    return vCenter;
  }
}

