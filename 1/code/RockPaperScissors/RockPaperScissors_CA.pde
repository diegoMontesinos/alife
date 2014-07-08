class RockPaperScissors_CA {

  // Constantes para referencia
  final int BLANK_VALUE = 0;
  final int ROCK_VALUE = 1;
  final int PAPER_VALUE = 2;
  final int SCISSOR_VALUE = 3;  

  int[][][] states; // Estados
  int[][][] values; // Valores
  int time;
  int topGrid;
  int cellsX;
  int cellsY;

  int hits = 5;

  // Render vars
  float widthCell;
  float heightCell;

  int[] colors = { 
    color(255), color(255, 0, 0), color(0, 255, 0), color(0, 0, 255)
  };

  RockPaperScissors_CA(int[][] initialStates, float widthCell, float heightCell) {  
    cellsX = initialStates.length;
    cellsY = initialStates[0].length;

    states = new int[cellsX][cellsY][2];
    values = new int[cellsX][cellsY][2];
    time = 0;

    for (int i = 0; i < cellsX; i++) {
      for (int j = 0; j < cellsY; j++) {
        states[i][j][time] = initialStates[i][j];
        values[i][j][time] = 0;
      }
    }

    this.widthCell  = widthCell;
    this.heightCell = heightCell;
  }

  void evolve() {
    int nextTime = (time + 1) % 2;

    for (int x = 0; x < cellsX; x++) {
      for (int y = 0; y < cellsY; y++) {
        evolveCell(x, y, nextTime);
      }
    }

    time = nextTime;
  }

  void drawGrid() {
    for (int x = 0; x < cellsX; x++) {
      for (int y = 0; y < cellsY; y++) {
        fill(colors[states[x][y][time]]);
        rect(x * widthCell, y * heightCell, widthCell, heightCell);
      }
    }
  }

  void evolveCell (int x, int y, int nextTime) {
    // Elegimos uno de los 8 vecinos al azar
    int i = 0;
    int j = 0;
    while (true) {
      i = floor(random(-1, 2));
      j = floor(random(-1, 2));

      // Prevenimos que no sea el centro
      if (i != 0 || j != 0) {
        break;
      }
    }

    // Correjimos la frontera
    int xNeighbor = 0;
    if ((x + i) < 0) {
      xNeighbor = cellsX - 1;
    } 
    else if ((x + i) >= cellsX) {
      xNeighbor = 0;
    } 
    else {
      xNeighbor = x + i;
    }

    int yNeighbor = 0;
    if ((y + j) < 0) {
      yNeighbor = cellsY - 1;
    } 
    else if ((y + j) >= cellsY) {
      yNeighbor = 0;
    }
    else {
      yNeighbor = y + j;
    }

    int cellState = states[x][y][time];
    int cellValue = values[x][y][time];

    int neighborState = states[xNeighbor][yNeighbor][time];
    int neighborValue = values[xNeighbor][yNeighbor][time];

    states[x][y][nextTime] = cellState;
    values[x][y][nextTime] = cellValue;

    // Si la celula es blanca, tomamos un vecino de color con valor menor a los hits
    if (cellState == BLANK_VALUE && neighborState != BLANK_VALUE && neighborValue < hits) {
      // Tomamos su valor
      states[x][y][nextTime] = neighborState;
      values[x][y][nextTime] = neighborValue + 1;
    }
    else {
      int result = fight(cellState, neighborState);

      if (result == -1) {
        values[x][y][nextTime] = cellValue + 1;
        values[xNeighbor][yNeighbor][nextTime] = 0;

        if (values[x][y][nextTime] > hits) {
          states[x][y][nextTime] = neighborState;
          values[x][y][nextTime] = 0;
        }
      } 
      else if (result == 1) {
        values[xNeighbor][yNeighbor][nextTime] = neighborValue + 1;
        values[x][y][nextTime] = 0;

        if (values[xNeighbor][yNeighbor][nextTime] > hits) {
          states[xNeighbor][yNeighbor][nextTime] = cellState;
          values[xNeighbor][yNeighbor][nextTime] = 0;
        }
      }
    }
  }

  int fight(int stateA, int stateB) {
    if (enemy(stateA) == stateB) {
      return -1;
    } 
    else if (enemy(stateB) == stateA) {
      return 1;
    }

    return 0;
  }

  int enemy(int state) {
    switch(state) {
    case ROCK_VALUE:
      return PAPER_VALUE;

    case PAPER_VALUE:
      return SCISSOR_VALUE;

    case SCISSOR_VALUE:
      return ROCK_VALUE;
    }

    return -1;
  }
}

