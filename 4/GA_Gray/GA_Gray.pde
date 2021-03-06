import java.util.Random;

GeneticAlgorithm ga;
int grayTarget = 127;

void setup() {
  size(500, 500);
  noStroke();
  rectMode(CENTER);
  smooth();
  
  ga = new GeneticAlgorithm(50, 0.01, grayTarget);
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

void keyPressed() {
  if(keyCode == UP) {
    grayTarget++;
  } else {
    grayTarget--;
  }
  
  ga.setTarget(grayTarget);
}

