
RockPaperScissors_CA cellAut = null;

float sizeCell = 4;
int stateToPut = 1;

void setup() {
  size(250, 250);
  noStroke();

  int resX = width  / (int) sizeCell;
  int resY = height / (int) sizeCell;

  // Generamos el estado inicial
  int[][] initialState = new int[resX][resY];
  for (int i = 0; i < initialState.length; i++) {
    for (int j = 0; j < initialState[i].length; j++) {
      initialState[i][j] = 0;
    }
  }

  cellAut = new RockPaperScissors_CA(initialState, sizeCell, sizeCell);
}

void draw() {
  cellAut.evolve();
  cellAut.drawGrid();
}

void mouseDragged() {
  int x = floor(mouseX / sizeCell);
  int y = floor(mouseY / sizeCell);
  
  cellAut.states[x][y][cellAut.time] = stateToPut;
  cellAut.values[x][y][cellAut.time] = 0;
}

void keyPressed() {
  if(key == '1') {
    stateToPut = 1;
  } else if(key == '2') {
    stateToPut = 2;
  } else if(key == '3') {
    stateToPut = 3;
  } else if(key == 's') {
    saveFrame();
  }
}
