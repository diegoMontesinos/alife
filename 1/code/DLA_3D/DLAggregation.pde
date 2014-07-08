import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.processing.*;

class DLAggregation3D {

  // Atributos del automata
  int[][] world;
  int cellsX;
  int cellsY;

  // Valores
  final int EMPTY_VALUE = 0;
  final int STUCK_VALUE = 1;
  final int MOV_VALUE = 2;

  // Variables para la evolucion
  int nMovs;    //Número de partículas en movimiento por evolución
  int[] xMovs;  //Posicion en X de las particulas en movimiento
  int[] yMovs;  //Posicion en Y de las particuals en movimiento

  boolean showMovs;

  //Variables para la salida gráfica
  float widthDLA = 500;
  float heightDLA = 500;

  float widthCell;
  float heightCell;
  float dephtCell;
  float y = 0;
  float yIncrement = 1;

  // ToxicLibs
  ToxiclibsSupport gfx;
  toxi.geom.mesh.TriangleMesh mesh;

  DLAggregation3D(int cellsX, int cellsY, boolean showMovs, float widthCell, float heightCell, float dephtCell, ToxiclibsSupport gfx) {
    this.cellsX = cellsX;
    this.cellsY = cellsY;

    this.showMovs = showMovs;

    this.widthCell = widthCell;
    this.heightCell = heightCell;
    this.dephtCell = dephtCell;

    // Init the ToxicLibs support
    this.gfx = gfx;
    this.mesh = new toxi.geom.mesh.TriangleMesh();
  }

  void init(int nStucked, int nMovs, boolean randomPosition) {
    world = new int[cellsX][cellsY];
    this.nMovs = nMovs;

    if (randomPosition) {
      for (int i = 0; i < nStucked; i++) {
        world[(int) random(cellsX)][(int) random(cellsY)] = STUCK_VALUE;
      }
    } 
    else {
      world[cellsX / 2][cellsY / 2] = STUCK_VALUE;
    }

    xMovs = new int[nMovs];
    yMovs = new int[nMovs];

    for (int i = 0; i < nMovs; i++) {
      xMovs[i] = -1;
      yMovs[i] = -1;
    }
  }

  void evolve() {
    for (int i = 0; i < nMovs; i++) {
      if (xMovs[i] == -1 && yMovs[i] == -1) {
        int[] newParticle = getNewMovableParticle();
        xMovs[i] = newParticle[0];
        yMovs[i] = newParticle[1];
      }
    }

    boolean allStucked = false;
    while (!allStucked) {
      allStucked = true;

      for (int i = 0; i < nMovs; i++) {
        if (xMovs[i] == -1 && yMovs[i] == -1) {
          continue;
        }

        if (isNearStucked(xMovs[i], yMovs[i])) {
          world[xMovs[i]][yMovs[i]] = 1;

          xMovs[i] = -1;
          yMovs[i] = -1;

          allStucked = allStucked && true;
        }
        else {
          world[xMovs[i]][yMovs[i]] = 0;
          int[] newPos = move(xMovs[i], yMovs[i]);

          xMovs[i] = newPos[0];
          yMovs[i] = newPos[1];

          world[xMovs[i]][yMovs[i]] = 2;
          allStucked = false;
        }
      }

      allStucked = allStucked || showMovs;
    }
  }

  int[] getNewMovableParticle() {
    int sideX = (int) random(2);
    int sideY = (int) random(2);

    int posX = (int) random(cellsX);
    int posY = (int) random(cellsY);

    if (sideX == 0 && sideY == 0) {
      posY = 0;
    } 
    else if (sideX == 0 && sideY == 1) {
      posX = cellsX - 1;
    } 
    else if (sideX == 1 && sideY == 0) {
      posY = cellsY - 1;
    } 
    else if (sideX == 1 && sideY == 1) {
      posX = 0;
    }

    int[] newParticle = {
      posX, posY
    };
    return newParticle;
  }

  int[] move(int posX, int posY) {
    int directionX = (int) random(-2, 2);
    int directionY = (int) random(-2, 2);

    directionX = (posX + directionX) < 0 || (posX + directionX) >= cellsX ? 0 : directionX;
    directionY = (posY + directionY) < 0 || (posY + directionY) >= cellsY ? 0 : directionY;

    world[posX][posY] = 0;
    world[posX + directionX][posY + directionY] = 2;

    int[] newPos = {
      posX + directionX, posY + directionY
    };
    return newPos;
  }

  boolean isNearStucked(int posX, int posY) {
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        if ((posX + i) < 0 || (posX + i) >= cellsX || (posY + j) < 0 || (posY + j) >= cellsY) {
          continue;
        }
        if (world[posX + i][posY + j] == 1) {
          return true;
        }
      }
    }
    return false;
  }

  void render() {
    noStroke();

    for (int i = 0; i < cellsX; i++) {
      for (int j = 0; j < cellsY; j++) {
        switch(world[i][j]) {
        case EMPTY_VALUE:
          fill(255);
          break;

        case MOV_VALUE:
          fill(0);
          break;

        case STUCK_VALUE:
          fill(0);
          AABB boundingBox = new AABB(new Vec3D((float) i * widthCell * 2.0, y * 2.0, (float) j * heightCell * 2.0), new Vec3D(widthCell, heightCell, dephtCell));
          mesh.addMesh(boundingBox.toMesh());

          break;
        }

        rect(i * widthCell, j * heightCell, widthCell, heightCell);
      }
    }

    y -= yIncrement;
  }

  void saveMesh(String name) {
    mesh.saveAsSTL(sketchPath(name));
  }
}

