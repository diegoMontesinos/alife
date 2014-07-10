
ConwayLife_CA paquito;

// Tiles
PShape[] modulesA;
PShape[] modulesB;
PShape[] modulesC;
PShape[] modulesD;
PShape[] modulesE;
PShape[] modulesF;
PShape[] modulesG;
PShape[] modulesH;

void setup() {
  size(500, 500);

  // load svg modules
  modulesA = new PShape[16];
  modulesB = new PShape[16];
  modulesD = new PShape[16]; 
  modulesC = new PShape[16]; 
  modulesE = new PShape[16];  
  modulesF = new PShape[16];  
  modulesG = new PShape[16];  
  modulesH = new PShape[16];  

  for (int i = 0; i < modulesA.length; i++) { 
    modulesA[i] = loadShape("A_" + nf(i, 2) + ".svg");
    modulesB[i] = loadShape("B_" + nf(i, 2) + ".svg");
    modulesC[i] = loadShape("C_" + nf(i, 2) + ".svg");
    modulesD[i] = loadShape("D_" + nf(i, 2) + ".svg");
    modulesE[i] = loadShape("E_" + nf(i, 2) + ".svg");
    modulesF[i] = loadShape("F_" + nf(i, 2) + ".svg");
    modulesG[i] = loadShape("J_" + nf(i, 2) + ".svg");
    modulesH[i] = loadShape("K_" + nf(i, 2) + ".svg");

    //disable Style
    modulesA[i].disableStyle();
    modulesB[i].disableStyle();
    modulesC[i].disableStyle();
    modulesD[i].disableStyle();
    modulesE[i].disableStyle();
    modulesF[i].disableStyle();
    modulesG[i].disableStyle();
    modulesH[i].disableStyle();
  } 

  // Creamos el estado inicial
  int[][] initialWorld = new int[50][50];
  for (int i = 0; i < initialWorld.length; i++) {
    for (int j = 0; j < initialWorld[i].length; j++) {
      // Aleotorio
      //initialWorld[i][j] = floor(random(2));

      // Limpio
      //initialWorld[i][j] = 0;
    }
  }
  
  putGunGlider(0, 0, 0, initialWorld);
  frameRate(30);

  //int[][] initialWorld, float widthCell, float heightCell, PShape[] modules
  paquito = new ConwayLife_CA(initialWorld, 10, 10, modulesA);
}

void draw() {
  background(255);
  paquito.evolve();
  paquito.render();
}

void keyReleased() {
  if (key == '1') paquito.setModules(modulesA);
  if (key == '2') paquito.setModules(modulesB);
  if (key == '3') paquito.setModules(modulesC);
  if (key == '4') paquito.setModules(modulesD);
  if (key == '5') paquito.setModules(modulesE);
  if (key == '6') paquito.setModules(modulesF);
  if (key == '7') paquito.setModules(modulesG);
  if (key == '8') paquito.setModules(modulesH);
}

