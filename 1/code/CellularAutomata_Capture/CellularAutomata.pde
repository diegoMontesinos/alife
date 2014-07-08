interface CellularAutomata {
  void evolve();
  void setInitialGrid();
  void updateGrid();
  void drawGrid();
  int getRule(int i, int j, int topGrid);
  int neighbors(int i, int j);
}
