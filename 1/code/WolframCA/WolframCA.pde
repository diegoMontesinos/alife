
Wolfram_CA pancho;
int regla = 0;

void setup() {
  // Ponemos la escena de processing
  size(500, 500);
  background(255);
  noStroke();

  // Fijo
  int[] estadoInicial = new int[250];
  for (int i = 0; i < estadoInicial.length; i++) {
    estadoInicial[i] = 0;
  }
  estadoInicial[125] = 1;

  // Creamos al automata
  pancho = new Wolfram_CA(estadoInicial, 2, 2, height / 2);
}

void draw() {
  pancho.evolve();
  pancho.render();
}

void keyPressed() {
  if(keyCode == UP) {
    regla++;
  } else if(keyCode == DOWN) {
    regla--;
  }
  
  println(regla);
  pancho.setRule(regla);
}



