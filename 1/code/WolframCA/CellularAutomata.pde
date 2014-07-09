
class Wolfram_CA {

  //Atributos del automata
  int sizeWorld;
  int [][] world;
  int topWorld;

  float time;
  float limitTime;

  //Variables de evolucion
  int nRule;   // Regla en numero
  String rule; // Regla en binario (texto)

  //Variables para salida gráfica
  float widthCell;
  float heightCell;

  int liveColor = color(0); // Negro para vivo - 1
  int deadColor = color(255); // Blanco para muerto - 0
  
  // Constructor
  Wolfram_CA(int[] initialWorld, float widthCell, float heightCell, float limitTime) {    
    this.sizeWorld = initialWorld.length;
    this.world = new int[sizeWorld][2];
    this.topWorld = 0;

    this.time = 0;
    this.limitTime = limitTime;

    for (int i = 0; i < this.sizeWorld; i++) {
      this.world[i][this.topWorld] = initialWorld[i];
    }

    this.nRule = 90;
    this.rule = buildRule(nRule);

    this.widthCell = widthCell;
    this.heightCell = heightCell;
  }

  void render() {
    for (int i = 0; i < sizeWorld; i++) {
      if (world[i][topWorld] == 1) {
        fill(liveColor);
      }
      else {
        fill(deadColor);
      }

      rect(i * widthCell, time * heightCell, widthCell, heightCell);
    }
  }

  void evolve() {
    int nextTop = (topWorld + 1) % 2;

    for (int i = 0; i < sizeWorld; i++) {
      world[i][nextTop] = evolveCell(neighborhoodValue(i));
    }

    topWorld = nextTop;
    if ((time + 1) >= limitTime) {
      time = 0;
    } 
    else {
      time += 1;
    }
  }

  int evolveCell(int neighborhoodValue) {
    int position = rule.length() - 1 - neighborhoodValue;
    
    if (rule.charAt(position) == '1') {
      return 1;
    } 
    else {
      return 0;
    }
  }

  int neighborhoodValue(int i) {
    String neighborhoodStr = "";

    if (i == 0) {
      // Izquierda
      neighborhoodStr += "0";

      // Centro
      neighborhoodStr += ("" + world[i][topWorld]);

      // Derecha
      neighborhoodStr += ("" + world[i + 1][topWorld]);
    }
    else if (i == sizeWorld - 1) {
      // Izquierda
      neighborhoodStr += ("" + world[i - 1][topWorld]);

      // Centro
      neighborhoodStr += ("" + world[i][topWorld]);

      // Derecha
      neighborhoodStr += "0";
    } 
    else {
      // Izquierda
      neighborhoodStr += ("" + world[i - 1][topWorld]);

      // Centro
      neighborhoodStr += ("" + world[i][topWorld]);

      // Derecha
      neighborhoodStr += ("" + world[i + 1][topWorld]);
    }

    return Integer.parseInt(neighborhoodStr, 2);
  }

  // Construye la regla de entero a cadena de texto
  String buildRule(int n) {
    String binaryNumber = Integer.toBinaryString(n);
    int missingZeros = 8 - binaryNumber.length();
    for (int i = 0; i < missingZeros; i++) {
      binaryNumber = "0" + binaryNumber;
    }
    return binaryNumber;
  }
  
  void setRule(int newRule) {
    nRule = newRule;
    rule = buildRule(nRule);
  }
  
  
}

