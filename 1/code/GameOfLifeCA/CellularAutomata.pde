class ConwayLife_CA { 

  int[][][] world;
  int cellsX;
  int cellsY;

  int time;
  int topWorld;

  float widthCell;
  float heightCell;
  
  int liveColor = color(0);
  int deadColor = color(255);

  ConwayLife_CA(int[][] initialWorld, float widthCell, float heightCell) {
    this.cellsX = initialWorld.length;
    this.cellsY = initialWorld[0].length;

    time = 0;

    this.world = new int[cellsX][cellsY][2];
    for (int i = 0; i < cellsX; i++) {
      for (int j = 0; j < cellsY; j++) {
        this.world[i][j][time] = initialWorld[i][j];
      }
    }

    this.widthCell = widthCell;
    this.heightCell = heightCell;
  }

  void evolve() {
    topWorld = time % 2;
    int nextWorld = (topWorld + 1) % 2;

    for (int i = 0; i < cellsX; i++) {
      for (int j = 0; j < cellsY; j++) {
        world[i][j][nextWorld] = getRule(i, j);
      }
    }

    time++;
  }

  void render() {
    for (int i = 0; i < cellsX; i++) {
      for (int j = 0; j < cellsY; j++) {
        if (world[i][j][topWorld] == 1) {
          fill(liveColor);
        } 
        else {
          fill(deadColor);
        }

        rect(i * widthCell, j * heightCell, widthCell, heightCell);
      }
    }
  }

  int getRule(int i, int j) {
    int countNeighbors = neighbors(i, j);
    int cellValue = world[i][j][topWorld];
    
    // Si estoy vivo
    if (cellValue == 1) {
      
      // Y hay 1 o 0 vivos
      if (countNeighbors == 1 || countNeighbors == 0) {
        // Muero de soledad
        return 0;
      }
      // Y si hay exactamente 2 o exactamente 3
      else if (countNeighbors == 2 || countNeighbors == 3) {
        // Sigo vivo
        return 1;
      } 
      // O si hay mas de 3
      else if (countNeighbors > 3) {
        // Muero por sobrepoblacion (hambre)
        return 0;
      }
    } 
    // Si estoy muerto
    else {
      // Y hay exactamente 3 vecinos
      if (countNeighbors == 3) {
        // Regreso del mas alla
        return 1;
      } 
      // Otro caso
      else {
        // Sigo muerto
        return 0;
      }
    }

    return -1;
  }

  int neighbors(int i, int j) {
    int neighbors = 0;
    //Top
    neighbors += world[(i + cellsX - 1) % cellsX][(j + cellsY - 1) % cellsY][topWorld];
    neighbors += world[i][(j + cellsY - 1) % cellsY][topWorld];
    neighbors += world[(i + 1) % cellsX][(j + cellsY - 1) % cellsY][topWorld];

    //Middle
    neighbors += world[(i + cellsX - 1) % cellsX][j][topWorld];
    neighbors += world[(i + 1) % cellsX][j][topWorld];

    //Down
    neighbors += world[(i + cellsX - 1) % cellsX][(j + 1) % cellsY][topWorld];
    neighbors += world[i][(j + 1) % cellsY][topWorld];
    neighbors += world[(i + 1) % cellsX][(j + 1) % cellsY][topWorld];

    return neighbors;
  }
}

