class ConwayLife implements CellularAutomata {

  int[][][] grid;
  int time;
  int topGrid;
  int cellsX;
  int cellsY;

  ConwayLife(int cellsX, int cellsY) {
    this.cellsX = cellsX;
    this.cellsY = cellsY;
    grid = new int[cellsX][cellsY][2];
    
    time = 0;
    setInitialGrid();
  }

  ConwayLife(int[][] initialGrid, int widthCell, int heightCell) {  
    cellsX = initialGrid.length;
    cellsY = initialGrid.length;
    grid = new int[cellsX][cellsY][2];
    
    for(int i = 0; i < initialGrid.length; i++) {
      for(int j = 0; j < initialGrid[i].length; j++) {
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
        grid[i][j][nextGrid] = getRule(i, j, topGrid);
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
  
    if(grid[i][j][topGrid] == 1) {
      if(countNeighbors == 1 || countNeighbors == 0) {
        return 0;
      } else if(countNeighbors == 2 || countNeighbors == 3) {
        return 1;
      } else if(countNeighbors >= 4) {
        return 0;
      }
    } else {
      if(countNeighbors == 3) {
        return 1;
      } else {
        return 0;
      }
    }
  
    return -1;
  }

  int neighbors(int i, int j) {
    int neighbors = 0;
    //Top
    neighbors += grid[(i + cellsX - 1) % cellsX][(j + cellsY - 1) % cellsY][topGrid];
    neighbors += grid[i][(j + cellsY - 1) % cellsY][topGrid];
    neighbors += grid[(i + 1) % cellsX][(j + cellsY - 1) % cellsY][topGrid];
  
    //Middle
    neighbors += grid[(i + cellsX - 1) % cellsX][j][topGrid];
    neighbors += grid[(i + 1) % cellsX][j][topGrid];
  
    //Down
    neighbors += grid[(i + cellsX - 1) % cellsX][(j + 1) % cellsY][topGrid];
    neighbors += grid[i][(j + 1) % cellsY][topGrid];
    neighbors += grid[(i + 1) % cellsX][(j + 1) % cellsY][topGrid];
  
    return neighbors;
   }  
}
