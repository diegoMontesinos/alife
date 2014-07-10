
ConwayLife_CA luis;

void setup() {
  size(500, 500);
  noStroke();

  // Creamos el estado inicial
  int[][] initialWorld = new int[100][100];
  for (int i = 0; i < initialWorld.length; i++) {
    for (int j = 0; j < initialWorld[i].length; j++) {
      // Aleotorio
      //initialWorld[i][j] = floor(random(2));
      
      // Limpio
      initialWorld[i][j] = 0;
    }
  }
  
  putGlider(50, 50, 3, initialWorld);
  putGlider(50, 0, 0, initialWorld);

  // Creamos al automata
  // con estos parametros int[][] initialWorld, float widthCell, float heightCell
  luis = new ConwayLife_CA(initialWorld, 5, 5);
}

void draw() {
  luis.evolve();
  luis.render();
}
