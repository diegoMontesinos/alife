import java.util.Random;

GeneticAlgorithm ga;
int grayTarget = 8;

void setup() {
  size(500, 500);
  noStroke();
  rectMode(CENTER);
  smooth();

  ga = new GeneticAlgorithm(8, 0.01, grayTarget);
}

void draw() {
  ga.evolve();
  DNA best = ga.bestSample();
  
  background(grayTarget);
  fill(best.fenotype());
  rect(250, 250, 100, 100);
  
  println("====================");
  println("generacion: " + frameCount);
  println("mejor fitness: " + best.fitness);
}


