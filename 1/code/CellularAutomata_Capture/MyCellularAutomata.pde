class MyCellularAutomata implements CellularAutomata {

  int[][][] grid;
  int time;
  int topGrid;
  int cellsX;
  int cellsY;

  MyCellularAutomata(int cellsX, int cellsY) {
    this.cellsX = cellsX;
    this.cellsY = cellsY;
    grid = new int[cellsX][cellsY][2];

    time = 0;
    setInitialGrid();
  }

  MyCellularAutomata(int[][] initialGrid, int widthCell, int heightCell) {  
    cellsX = initialGrid.length;
    cellsY = initialGrid.length;
    grid = new int[cellsX][cellsY][2];

    for (int i = 0; i < initialGrid.length; i++) {
      for (int j = 0; j < initialGrid[i].length; j++) {
        grid[i][j][0] = initialGrid[i][j];
      }
    }

    time = 0;
  }

  void evolve() {
    topGrid = time % 2;
    updateGrid();
    time++;
  }

  void setInitialGrid() {
    for(int i = 0; i < cellsX; i++) {
      for(int j = 0; j < cellsY; j++) {
        grid[i][j][0] = (int)(Math.random() * 2) % 2;
      }
    }
  }

  void updateGrid() {
    int nextGrid = (topGrid + 1) % 2;
  
    for(int i = 0; i < cellsX; i++) {
      for(int j = 0; j < cellsY; j++) {
        int nextState = getRule(i, j, topGrid);
        if(nextState == -1) {
          grid[i][j][nextGrid] = grid[i][j][topGrid];
        } else {
          grid[i][j][nextGrid] = nextState;
        }
      }
    }
  }

  void drawGrid() {
    loadPixels();
    for(int i = 0; i < cellsX; i++) {
      for(int j = 0; j < cellsY; j++) {
        int col = grid[i][j][topGrid] == 1 ? color(255) : color(0);
        set(i, j, col);
      }
    }
    updatePixels();
  }

  int getRule(int i, int j, int topGrid) {
    int countNeighbors = neighbors(i, j);
    
    if(countNeighbors == 2) {
       return 1;
     } else if(countNeighbors >= 6) {
       return 0;
     }
     
     return -1;
  }

  int neighbors(int x, int y) {
    int neighbors = 0;
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        if((i == 0 && j == 0) ||
           (x+i < 0) || (y+j < 0) ||
           (x+i >= cellsX) || (y+j >= cellsY)) { 
          continue;
        }
        
        neighbors = grid[x+i][y+j][topGrid] == 1 ? neighbors + 1 : neighbors;
      }
    }
    return neighbors;
  }

}

