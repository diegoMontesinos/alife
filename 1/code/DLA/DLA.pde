
DLAggregation dla;

void setup() {
  size(500, 500);
  
  // Crear el objeto DLA
  //int cellsX, int cellsY, boolean showMovs, float widthCell, float heightCell
  dla = new DLAggregation(250, 250, false, 2, 2);
  
  //int nStucked, int nMovs, boolean randomPosition
  dla.init(1, 100, false);
}

void draw() {
  // Evolucionamos
  dla.evolve();
  
  // Rendereamos
  dla.render();
}

