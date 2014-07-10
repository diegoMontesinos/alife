
class DLAggregation {

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
  
  // Constructor
  DLAggregation(int cellsX, int cellsY, boolean showMovs, float widthCell, float heightCell) {
    // Ponemos la informacion que nos pasaron a nuestras variables
    this.cellsX = cellsX;
    this.cellsY = cellsY;

    this.showMovs = showMovs;

    this.widthCell = widthCell;
    this.heightCell = heightCell;
  }
  
  // Inicia el automara
  void init(int nStucked, int nMovs, boolean randomPosition) {
    // Inicializa el mundo
    world = new int[cellsX][cellsY];
    
    // Ponemos el numero de movibles en nuestra variable
    this.nMovs = nMovs;
    
    // Si el usuario dice que sea en posicion aleatoria
    if (randomPosition) {
      // Ciclo de 0 al numero de pegadas
      for (int i = 0; i < nStucked; i++) {
        world[floor(random(cellsX))][floor(random(cellsY))] = STUCK_VALUE;
      }
      
    } 
    // La quiere fija
    else {
      world[cellsX / 2][cellsY / 2] = STUCK_VALUE;
    }
    
    // Inicializamos la coordenadas de los movibles
    xMovs = new int[nMovs];
    yMovs = new int[nMovs];
    
    // Le damos valor negativo a todos
    for (int i = 0; i < nMovs; i++) {
      xMovs[i] = -1;
      yMovs[i] = -1;
    }
  }
  
  // Funcion para evolucionar el automata
  void evolve() {
    // Recorre todas las movibles
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
          world[xMovs[i]][yMovs[i]] = STUCK_VALUE;
          
          // Ya no estoy moviendome
          xMovs[i] = -1;
          yMovs[i] = -1;
          
          // Agregamos true a la variable de todas pegadas
          allStucked = allStucked && true;
        }
        
        else {
          
          world[xMovs[i]][yMovs[i]] = EMPTY_VALUE;
          int[] newPos = move(xMovs[i], yMovs[i]);

          xMovs[i] = newPos[0];
          yMovs[i] = newPos[1];

          world[xMovs[i]][yMovs[i]] = MOV_VALUE;
          
          // No todos estan pegados
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
    // Iteramos en la vecindad
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        if ((posX + i) < 0 || (posX + i) >= cellsX || (posY + j) < 0 || (posY + j) >= cellsY) {
          continue;
        }
        if (world[posX + i][posY + j] == STUCK_VALUE) {
          return true;
        }
      }
    }
    
    return false;
  }

  void render() {
    noStroke();
    
    // Iteramos sobre x
    for (int i = 0; i < cellsX; i++) {
      
      // Iteramos sobre y
      for (int j = 0; j < cellsY; j++) {
        
        switch(world[i][j]) {
        case EMPTY_VALUE:
          fill(255);
          rect(i * widthCell, j * heightCell, widthCell, heightCell);
          break;

        case MOV_VALUE:
          fill(0);
          ellipse(i * widthCell, j * heightCell, widthCell, heightCell);
          break;

        case STUCK_VALUE:
          fill(0);
          rect(i * widthCell, j * heightCell, widthCell, heightCell);
          break;
        }
        // Ancho = 2
        // Alto = 2
        // i  j    x   y
        // 5, 10 -> 10,  20
        
      }
    }
  }
}

