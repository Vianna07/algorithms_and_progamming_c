#include <stdio.h>

char *par_ou_impar(int numero) {
  if (numero % 2 == 0) {
    return "par";
  }

  return "impar";
}

int main() {
  int numero_a, numero_b, numero_c;

  printf("\n1 - Digite um numero para somar: ");
  scanf("%d", &numero_a);
  printf("2 - Digite um numero para somar: ");
  scanf("%d", &numero_b);

  numero_c = numero_a + numero_b;

  printf("\nA soma dos dois numeros eh: %d", numero_c);
  printf("\nO numero eh: %s", par_ou_impar(numero_c));

  return 0;
}
