
class Termite {
  
  // Posicion de la termita
  int x;
  int y;
  boolean hasWoodChip; // Esta cargando o no una maderita
  
  // Constructor
  Termite(int x, int y) {
    this.x = x;
    this.y = y;

    this.hasWoodChip = false;
  }

  void move(int limitX, int limitY, int[][] world) {
    int newX = 0;
    int newY = 0;

    while (true) {
      // Determinamos hacia a donde nos movemos previvinendo que no sea el centro
      int i = 0;
      int j = 0;
      while (i == 0 && j == 0) {
        i = floor(random(-1, 2));
        j = floor(random(-1, 2));
      }

      // Obtenemos la nueva posicion
      newX = (x + i) < 0 ? limitX - 1 : ((x + i) >= limitX ? 0 : x + i);
      newY = (y + j) < 0 ? limitY - 1 : ((y + j) >= limitY ? 0 : y + j);
      
      // Si a donde nos queremos mover esta vacio suspendemos el ciclo
      if(world[newX][newY] == 0) {
        break;
      }
    }
    
    this.x = newX;
    this.y = newY;
  }
}

