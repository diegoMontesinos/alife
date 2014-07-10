
DLAggregation3D dla;

void setup() {
  size(500, 500);
  
  dla = new DLAggregation3D(500, 500, false, 1.0, 1.0, 1.0, new ToxiclibsSupport(this));
  dla.init(1, 10, false);
}

void draw() {
  dla.evolve();
  dla.render();
}

void keyPressed() {
  if (key == 's') {
    dla.saveMesh("dla_3d.stl");
    exit();
  }
}

