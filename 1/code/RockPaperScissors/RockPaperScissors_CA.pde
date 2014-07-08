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
  }
  
}

