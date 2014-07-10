
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

    PVector a = new PVector();
    PVector b = new PVector();
    PVector c = new PVector();
    PVector d = new PVector();
    PVector e = new PVector();

    KochLine son0 = null;
    sons[0] = son0;

    KochLine son1 = null;
    sons[1] = son1;

    KochLine son2 = null;
    sons[2] = son2;

    KochLine son3 = null;
    sons[3] = son3;

    return sons;
  }
}

