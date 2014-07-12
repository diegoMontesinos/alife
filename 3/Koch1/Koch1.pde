import java.util.LinkedList;

LinkedList<KochLine> lines; 

void setup() {
  size(500, 500);
  background(255);
  stroke(0);

  lines = new LinkedList<KochLine>();

  // Creamos nuestra primera linea
  KochLine primera = new KochLine(new PVector(0, 250), // Inicio
                                  new PVector(500, 250)  // Final
                                  );
  lines.add(primera);

  // Cuantos pasos
  for (int i = 0; i < 5; i++) {
    LinkedList<KochLine> nextGen = new LinkedList<KochLine>();

    for (KochLine koch : lines) {
      KochLine[] sons = koch.step();
      nextGen.add(sons[0]);
      nextGen.add(sons[1]);
      nextGen.add(sons[2]);
      nextGen.add(sons[3]);
    }

    // Reemplazar la generacion actual con la siguiente
    lines = nextGen;
  }
}

void draw() {
  for (KochLine koch : lines) {
    koch.render();
  }
}

