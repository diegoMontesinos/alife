
void setup() {
  println(factorial(15));
}

int factorial(int n) {
  // Nuestra base
  if(n == 0) {
    return 1;
  } else {
    // Regla inductiva
    return n * factorial(n - 1);
  }
}


