
class GeneticAlgorithm {
  Random rand;         // Generador de numeros aleatorios

  int nPopulation;     // Numero de invididuos en la poblacion
  double pMutation;    // Probabilidad de mutacion
  DNA[] population;    // Poblacion actual

  int target;          // Color objetivo

  GeneticAlgorithm (int nPopulation, double pMutation, int targetGray) {
    this.rand = new Random();

    this.nPopulation = nPopulation;
    this.pMutation = pMutation;
    this.population = new DNA[this.nPopulation];
    this.target = targetGray;

    // 1. Inicializacion
    initPopulation();
  }

  void evolve() {
    // 2. Seleccion
    // 2.1 Se califica a toda la poblacion
    float totalFitness = 0.0;

    for (int i = 0; i < this.nPopulation; i++) {
      DNA sample = this.population[i];      
      float sampleFitness = fitness(sample);

      sample.fitness = sampleFitness;
      totalFitness += sampleFitness;
    }

    // 2.2 Se obtiene la probabilidad de seleccion de cada individuo
    for (int i = 0; i < this.nPopulation; i++) {
      DNA sample = this.population[i];
      sample.reproductionProb = (1.0 - (sample.fitness / totalFitness)) / (float) (this.nPopulation - 1);
    }
    
    // 2.3 Se obtiene la seleccion
    ArrayList<DNA> mating = mating();

    // 3. Cruza
    // 3.2 Los cruzamos y generamos una nueva poblacion
    DNA[] newPopulation = new DNA[this.nPopulation];
    for (int i = 0; i < this.nPopulation; i += 2) {
      int indexMother = floor(random(mating.size()));
      int indexFather = floor(random(mating.size()));

      DNA mother = mating.get(indexMother);
      DNA father = mating.get(indexFather);

      DNA[] sons = mother.crossover(father);
      newPopulation[i] = sons[0];
      newPopulation[(i + 1) % this.nPopulation] = sons[1];

      // 4. Mutacion
    }

    // 4. Mutacion
    for (int i = 0; i < this.nPopulation; i ++) {
      DNA newSample = newPopulation[i];
      double coin = this.rand.nextDouble();
      if (coin <= this.pMutation) {
        newSample.mutate();
      }
    }

    // 5. Sustitucion
    this.population = newPopulation;
  }

  ArrayList<DNA> mating() {
    // Ruleta
    ArrayList<DNA> mating = new ArrayList<DNA>();
    for (int i = 0; i < this.nPopulation; i++) {
      DNA sample = this.population[i];
      int n = (int) (sample.reproductionProb * 1000000); 

      for (int j = 0; j < n; j++) {
        mating.add(sample);
      }
    }

    return mating;
  }

  void initPopulation() {
    for (int i = 0; i < this.nPopulation; i++) {
      String newGenotype = "";
      for (int j = 0; j < 8; j++) {
        newGenotype += ("" + floor(random(2)));
      }

      this.population[i] = new DNA(newGenotype);
    }
  }

  float fitness(DNA sample) {
    int sampleFenotype = sample.fenotype();

    float samplef = (float) sampleFenotype;
    float targetf = (float) target;

    return abs(targetf - samplef);
  }

  DNA bestSample() {
    int indexBest = 0;
    double minFitness = this.population[0].fitness;

    for (int i = 1; i < this.nPopulation; i++) {
      this.population[i].fitness = fitness(this.population[i]);
      double currFitness = this.population[i].fitness;

      if (currFitness < minFitness) {
        indexBest = i;
        minFitness = currFitness;
      }
    }

    return this.population[indexBest];
  }
}

