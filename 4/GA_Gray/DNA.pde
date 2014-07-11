
class DNA {

  String genotype;

  float fitness;
  float reproductionProb;

  DNA(String genotype) {
    this.genotype = genotype;
    this.fitness = Float.MAX_VALUE; // VALOR MAXIMO AL INICIO
  }

  void mutate() {
    int mutatePoint = floor(random(genotype.length()));

    String chromosome = "" + floor(random(2));
    genotype    = genotype.substring(0, mutatePoint) + chromosome + genotype.substring(mutatePoint + 1);
  }

  DNA[] crossover(DNA mate) {
    DNA[] sons = new DNA[2];
    int crossPoint = floor(random(genotype.length()));

    String genotype1 = genotype.substring(0, crossPoint) + mate.genotype.substring(crossPoint);
    String genotype2 = mate.genotype.substring(0, crossPoint) + genotype.substring(crossPoint);

    sons[0] = new DNA(genotype1);
    sons[1] = new DNA(genotype2);

    return sons;
  }

  int fenotype() {
    return Integer.parseInt(genotype, 2);
  }
}

