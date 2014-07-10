
Colony colonia;

void setup() {
  size(500, 500);

  // Construir el mundo inicial
  int[][] initialWorld = new int[250][250];
  for (int i = 0; i < 1000; i++) {
    initialWorld[floor(random(250))][floor(random(250))] = 1;
  }

  //int nTermites, int[][] initialWorld, float widthCell, float heightCell
  colonia = new Colony(20, initialWorld, 2, 2);
}

void draw() {
  background(255);
  for (int i = 0; i < 500; i++) {
    colonia.evolve();
  }
  
  colonia.render();
}

