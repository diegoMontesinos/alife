import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.processing.*;
import toxi.geom.mesh2d.*;

import java.util.LinkedList;

Flock manada;

void setup() {
  size(500, 500);
  
  manada = new Flock(150, new ToxiclibsSupport(this));
}

void draw() {
  background(255);
  
  manada.update();
  manada.render();
}

