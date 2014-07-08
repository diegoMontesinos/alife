class ConwayLife_CA { 

  int[][][] world;
  int cellsX;
  int cellsY;

  int time;
  int topWorld;

  float widthCell;
  float heightCell;

  PShape[] modules;

  ConwayLife_CA(int[][] initialWorld, float widthCell, float heightCell, PShape[] modules) {
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
    this.modules = modules;
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
    shapeMode(CENTER);
    for (int i = 0; i < cellsX; i++) {
      for (int j = 0; j < cellsY; j++) {
        if (world[i][j][topWorld] == 1) {
          String binaryResult = "";

          // N
          if ((j - 1) < 0) {
            binaryResult = "0";
          } 
          else {
            binaryResult = "" + world[i][j - 1][topWorld];
          }

          // W
          if ((i - 1) < 0) {
            binaryResult += "0";
          } 
          else {
            binaryResult += "" + (world[i - 1][j][topWorld]);
          }

          // S
          if ((j + 1) >= cellsY) {
            binaryResult += "0";
          } 
          else {
            binaryResult += "" + (world[i][j + 1][topWorld]);
          }

          // E
          if ((i + 1) >= cellsX) {
            binaryResult += "0";
          } 
          else {
            binaryResult += "" + (world[i + 1][j][topWorld]);
          }

          // convert the binary string to a decimal value from 0-15
          int decimalResult = unbinary(binaryResult);
          float posX = widthCell * i;
          float posY = heightCell * j;

          fill(0);
          noStroke();

          // decimalResult is the also the index for the shape array
          shape(modules[decimalResult], posX, posY, widthCell, heightCell);
        }
      }
    }
  }

  int getRule(int i, int j) {
    int countNeighbors = neighbors(i, j);

    if (world[i][j][topWorld] == 1) {
      if (countNeighbors == 1 || countNeighbors == 0) {
        return 0;
      } 
      else if (countNeighbors == 2 || countNeighbors == 3) {
        return 1;
      } 
      else if (countNeighbors >= 4) {
        return 0;
      }
    } 
    else {
      if (countNeighbors == 3) {
        return 1;
      } 
      else {
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

  void setModules(PShape[] modules) {
    this.modules = modules;
  }
}

