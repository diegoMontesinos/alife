
int cellsX = 175;
int cellsY = 175;
int sizeCell = 2;

int[][][] world;
int currWorld;

float pBurn = 0.007;
float pGrowth = 0.008;

boolean vonNeuman = true;

// 0 - VEGETACION
int cVegetation = color(11, 180, 9);
// 1 - EN LLAMAS
int cBurn = color(255, 28, 3);
// 2 - QUEMADO
int cBurned = color(0, 0, 0);

void setup() {
  size(cellsX * sizeCell, cellsY * sizeCell);

  initWorld();
}

void draw() { 
  drawWorld();
  updateWorld();
}

void initWorld() {
  currWorld = 0;

  world = new int[2][cellsX][cellsY];
  for (int i = 0; i < cellsX; i++) {
    for (int j = 0; j < cellsY; j++) {
      world[currWorld][i][j] = floor(random(3));
    }
  }
}

void drawWorld() {
  for (int i = 0; i < cellsX; i++) {
    for (int j = 0; j < cellsY; j++) {
      switch(world[currWorld][i][j]) {
      case 0:
        stroke(cVegetation);
        fill(cVegetation);
        break;

      case 1:
        stroke(cBurn);
        fill(cBurn);
        break;

      case 2:
        stroke(cBurned);
        fill(cBurned);
        break;
      }

      rect(i * sizeCell, j * sizeCell, sizeCell, sizeCell);
    }
  }
}

void updateWorld() {
  int nextWorld = (currWorld + 1) % 2;

  for (int i = 0; i < cellsX; i++) {
    for (int j = 0; j < cellsY; j++) {

      float coinToss;
      int fireNeighbors;

      switch(world[currWorld][i][j]) {
      case 0:
        fireNeighbors = fireNeighbors(i, j);
        if (fireNeighbors > 0) {
          world[nextWorld][i][j] = 1;
        } 
        else {
          coinToss = random(1.0);
          if (coinToss <= pBurn) {
            world[nextWorld][i][j] = 1;
          } 
          else {
            world[nextWorld][i][j] = 0;
          }
        }
        break;  

      case 1:
        world[nextWorld][i][j] = 2;
        break;

      case 2:
        coinToss = random(1.0);
        if (coinToss <= pGrowth) {
          world[nextWorld][i][j] = 0;
        } 
        else {
          world[nextWorld][i][j] = 2;
        }
        break;
      }
    }
  }

  currWorld = nextWorld;
}

int fireNeighbors(int x, int y) {
  int fire = 0;

  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      if (x + i < 0 || x + i >= cellsX || y + j < 0 || y + j >= cellsY || (i == 0 && j == 0)) {
        continue;
      } 
      else if (vonNeuman) {
        if (abs(i + j) != 1) {
          continue;
        }
      }

      if (world[currWorld][x + i][y + j] == 1) {
        fire++;
      }
    }
  }

  return fire;
}

void mouseClicked() {
  int i = floor(mouseX / (float) sizeCell);
  int j = floor(mouseY / (float) sizeCell);

  putBurn(i, j);
}

void mouseDragged() {
  int i = floor(mouseX / (float) sizeCell);
  int j = floor(mouseY / (float) sizeCell);

  putBurn(i, j);
}

void putBurn(int x, int y) {
  if (world[currWorld][x][y] == 0) {
    world[currWorld][x][y] = 1;
  }
}

