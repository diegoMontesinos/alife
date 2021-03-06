import ddf.minim.*;
import ddf.minim.signals.*;

class Wolfram_CA {

  //Atributos del automata
  int sizeWorld;
  int [][] world;
  int topWorld;

  float time;
  float limitTime;

  //Variables de evolucion
  int nRule;
  String rule;

  //Variables para salida gráfica
  float widthCell;
  float heightCell;

  int liveColor = color(0);
  int deadColor = color(255);

  // Audio
  Minim minim;
  AudioOutput aout;
  SineWave[] oscillators;
  int freqBase = 440;
  int intervalo = 35;

  Wolfram_CA(int[] initialWorld, float widthCell, float heightCell, float limitTime) {    
    this.sizeWorld = initialWorld.length;
    this.world = new int[sizeWorld][2];
    this.topWorld = 0;

    this.time = 0;
    this.limitTime = limitTime;

    for (int i = 0; i < this.sizeWorld; i++) {
      this.world[i][this.topWorld] = initialWorld[i];
    }

    this.nRule = 110;
    this.rule = buildRule(nRule);

    this.widthCell = widthCell;
    this.heightCell = heightCell;

    //Inicializa variables del audio
    minim = new Minim(this);
    aout = minim.getLineOut(Minim.STEREO);
    oscillators = new SineWave[sizeWorld];
    for (int i = 0; i < oscillators.length; i++) {
      int freq = i * intervalo + freqBase;
      oscillators[i] = new SineWave(freq, 0.5, aout.sampleRate());
      oscillators[i].portamento(50);

      aout.addSignal(oscillators[i]);
    }
  }

  void render() {
    // Todos a frecuencia 0
    for (int i = 0; i < sizeWorld; i++) {
      oscillators[i].setFreq(0);
    }

    for (int i = 0; i < sizeWorld; i++) {
      if (world[i][topWorld] == 1) {
        fill(color(0));
        int freq = i * intervalo + freqBase;
        oscillators[i].setFreq(freq);
      }
      else {
        fill(color(255));
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

  void stop() {
    aout.close();
    minim.stop();
  }
}

