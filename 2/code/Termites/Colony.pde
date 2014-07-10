
class Colony {

  // Mundo
  int cellsX;
  int cellsY;
  int[][] world;

  int nTermites;
  Termite[] termites;

  // Estados
  final int EMPTY = 0;
  final int WOODCHIP = 1;

  // Para render
  float widthCell;
  float heightCell;

  Colony(int nTermites, int[][] initialWorld, float widthCell, float heightCell) {
    this.cellsX = initialWorld.length;
    this.cellsY = initialWorld[0].length;
    this.world = new int[cellsX][cellsY];

    for (int i = 0; i < cellsX; i++) {
      for (int j = 0; j < cellsY; j++) {
        this.world[i][j] = initialWorld[i][j];
      }
    }

    this.nTermites = nTermites;
    this.termites = new Termite[nTermites];
    for (int i = 0; i < nTermites; i++) {
      int xTermite = floor(random(cellsX));
      int yTermite = floor(random(cellsY));
      while (world[xTermite][yTermite] == WOODCHIP) {
        xTermite = floor(random(cellsX));
        yTermite = floor(random(cellsY));
      }

      this.termites[i] = new Termite(xTermite, yTermite);
    }

    this.widthCell = widthCell;
    this.heightCell = heightCell;
  }

  void evolve() {
    for (int i = 0; i < nTermites; i++) {
      Termite termite = termites[i];

      // Movemos a la termita dentro de los limites
      // con frontera toroide
      termite.move(cellsX, cellsY, world);

      // Si esta cerca de un pedacito de madera
      int[] chip = isNearChip(termite);
      if (chip != null) {

        // y lleva cargando una la deja en su lugar
        if (termite.hasWoodChip) {
          termite.hasWoodChip = false;
          world[termite.x][termite.y] = 1;
        }
        // Si no la recoge
        else {
          termite.hasWoodChip = true;
          world[chip[0]][chip[1]] = 0;
        }
      }
    }
  }

  void render() {
    for (int i = 0; i < cellsX; i++) {
      for (int j = 0; j < cellsY; j++) {
        if (world[i][j] == 1) {
          fill(0);
          rect(i * widthCell, j * heightCell, widthCell, heightCell);
        }
      }
    }
  }

  int[] isNearChip(Termite termite) {
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {

        if (i == 0 && j == 0) {
          continue;
        }

        // Correjimos la fontera
        int x = (termite.x + i) < 0 ? cellsX - 1 : ((termite.x + i) >= cellsX ? 0 : termite.x + i);
        int y = (termite.y + j) < 0 ? cellsY - 1 : ((termite.y + j) >= cellsY ? 0 : termite.y + j);  

        if (world[x][y] == 1) {
          int[] chip = {
            x, y
          };

          return chip;
        }
      }
    }

    return null;
  }
}

