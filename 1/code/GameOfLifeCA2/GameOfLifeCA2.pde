// Tiles
PShape[] modulesA;
PShape[] modulesB;
PShape[] modulesC;
PShape[] modulesD;
PShape[] modulesE;
PShape[] modulesF;
PShape[] modulesG;
PShape[] modulesH;

ConwayLife_CA ca;

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
}

void draw() {
}

void keyReleased() {
  if (key == '1') ca.setModules(modulesA);
  if (key == '2') ca.setModules(modulesB);
  if (key == '3') ca.setModules(modulesC);
  if (key == '4') ca.setModules(modulesD);
  if (key == '5') ca.setModules(modulesE);
  if (key == '6') ca.setModules(modulesF);
  if (key == '7') ca.setModules(modulesG);
  if (key == '8') ca.setModules(modulesH);
}

