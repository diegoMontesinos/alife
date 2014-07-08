//STEPS FOR GUN
//RIGHT_DOWN = 0
static final int[] STEPS_GUN_RDX = {
  1, 1, 2, 2, 11, 11, 11, 12, 12, 13, 13, 14, 14, 15, 16, 16, 17, 17, 17, 18, 21, 21, 21, 22, 22, 22, 23, 
  23, 25, 25, 25, 25, 35, 35, 36, 36
};
static final int[] STEPS_GUN_RDY = {
  5, 6, 5, 6, 5, 6, 7, 4, 8, 3, 9, 3, 9, 6, 4, 8, 5, 6, 7, 6, 3, 4, 5, 3, 4, 5, 2, 
  6, 1, 2, 6, 7, 3, 4, 3, 4
};

//RIGHT_UP = 1
static final int[] STEPS_GUN_RUX = {
  3, 4, 3, 4, 1, 2, 6, 7, 2, 6, 3, 4, 5, 3, 4, 5, 6, 5, 6, 7, 4, 8, 6, 3, 9, 3, 9, 
  4, 8, 5, 6, 7, 5, 6, 5, 6
};
static final int[] STEPS_GUN_RUY = {
  2, 2, 3, 3, 13, 13, 13, 13, 15, 15, 16, 16, 16, 17, 17, 17, 20, 21, 21, 21, 22, 22, 23, 24, 24, 25, 25, 
  26, 26, 27, 27, 27, 36, 36, 37, 37
};

//LEFT_UP = 2
static final int[] STEPS_GUN_LUX = {
  2, 2, 3, 3, 13, 13, 13, 13, 15, 15, 16, 16, 16, 17, 17, 17, 20, 21, 21, 21, 22, 22, 23, 24, 24, 25, 25, 
  26, 26, 27, 27, 27, 36, 36, 37, 37
};
static final int[] STEPS_GUN_LUY = {
  6, 7, 6, 7, 3, 4, 8, 9, 4, 8, 5, 6, 7, 5, 6, 7, 4, 3, 4, 5, 2, 6, 4, 1, 7, 1, 7, 
  2, 6, 3, 4, 5, 4, 5, 4, 5
};

//LEFT_DOWN = 3
static final int[] STEPS_GUN_LDX = {
  4, 5, 4, 5, 3, 4, 5, 2, 6, 1, 7, 1, 7, 4, 2, 6, 3, 4, 5, 4, 5, 6, 7, 5, 6, 7, 4, 
  8, 3, 4, 8, 9, 6, 7, 6, 7
};
static final int[] STEPS_GUN_LDY = {
  1, 1, 2, 2, 11, 11, 11, 12, 12, 13, 13, 14, 14, 15, 16, 16, 17, 17, 17, 18, 21, 21, 21, 22, 22, 22, 23, 
  23, 25, 25, 25, 25, 35, 35, 36, 36
};

//STEPS FOR GLIDER
//RIGHT_DOWN = 0
static final int[] STEPS_GLIDER_RDX = {
  2, 3, 1, 2, 3
};
static final int[] STEPS_GLIDER_RDY = {
  1, 2, 3, 3, 3
};

//RIGHT_UP = 1
static final int[] STEPS_GLIDER_RUX = {
  2, 3, 1, 3, 3
};
static final int[] STEPS_GLIDER_RUY = {
  1, 1, 2, 2, 3
};

//LEFT_UP = 2
static final int[] STEPS_GLIDER_LUX = {
  1, 2, 3, 1, 3
};
static final int[] STEPS_GLIDER_LUY = {
  1, 1, 1, 2, 3
};

//LEFT_DOWN = 3
static final int[] STEPS_GLIDER_LDX = {
  1, 1, 3, 1, 2
};
static final int[] STEPS_GLIDER_LDY = {
  1, 2, 2, 3, 3
};

void putGunGlider(int x, int y, int orientation, int[][] world) {
  int cellsX = world.length;
  int cellsY = world[0].length;

  int[] stepsX = new int[36];
  int[] stepsY = new int[36];

  switch(orientation) {
  case 0:
    stepsX = STEPS_GUN_RDX;
    stepsY = STEPS_GUN_RDY;
    break;

  case 1:
    stepsX = STEPS_GUN_RUX;
    stepsY = STEPS_GUN_RUY;
    break;

  case 2:
    stepsX = STEPS_GUN_LUX;
    stepsY = STEPS_GUN_LUY;
    break;

  case 3:
    stepsX = STEPS_GUN_LDX;
    stepsY = STEPS_GUN_LDY;
    break;
  }

  for (int i = 0; i < 36; i++) {
    world[(x + stepsX[i]) % cellsX][(y + stepsY[i]) % cellsY] = 1;
  }
}

void putGlider(int x, int y, int orientation, int[][] world) {
  int cellsX = world.length;
  int cellsY = world[0].length;

  int[] stepsX = new int[5];
  int[] stepsY = new int[5];

  switch(orientation) {
  case 0:
    stepsX = STEPS_GLIDER_RDX;
    stepsY = STEPS_GLIDER_RDY;
    break;

  case 1:
    stepsX = STEPS_GLIDER_RUX;
    stepsY = STEPS_GLIDER_RUY;
    break;

  case 2:
    stepsX = STEPS_GLIDER_LUX;
    stepsY = STEPS_GLIDER_LUY;
    break;

  case 3:
    stepsX = STEPS_GLIDER_LDX;
    stepsY = STEPS_GLIDER_LDY;
    break;
  }

  for (int i = 0; i < 5; i++) {
    world[(x + stepsX[i]) % cellsX][(y + stepsY[i]) % cellsY] = 1;
  }
}

