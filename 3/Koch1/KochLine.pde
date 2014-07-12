
class KochLine {

  PVector start;
  PVector end;

  KochLine(PVector start, PVector end) {
    this.start = start;
    this.end = end;
  }

  void render() {
    stroke(0);

    line(start.x, start.y, end.x, end.y);
  }

  KochLine[] step() {
    KochLine[] sons = new KochLine[4];
    
    // a es un vector con las mismas coordenadas que el inicio
    PVector a = new PVector(start.x, start.y);
    
    // b es un vector que esta a la distancia 1/3 de inicio y fin
    PVector b = PVector.sub(end, start);
    b.mult(1.0 / 3.0);
    b.add(start);
    
    // 1. C incia siendo el vector de inicio
    PVector c = new PVector(start.x, start.y);
    // Tomamos un vector aux
    PVector aux = PVector.sub(end, start);
    aux.mult(1.0 / 3.0);
    
    c.add(aux);
    aux.rotate(-radians(60));
    c.add(aux);
    
    // d es un vector que esta a la distancia 2/3 del inicio y fin
    PVector d = PVector.sub(end, start);
    d.mult(2.0 / 3.0);
    d.add(start);
    
    // e es un vector con las mismas coordenadas que el final
    PVector e = new PVector(end.x, end.y);
    
    // Creamos a los hijos
    KochLine son0 = new KochLine(a, b);
    sons[0] = son0;

    KochLine son1 = new KochLine(b, c);
    sons[1] = son1;

    KochLine son2 = new KochLine(c, d);
    sons[2] = son2;

    KochLine son3 = new KochLine(d, e);
    sons[3] = son3;

    return sons;
  }
}

