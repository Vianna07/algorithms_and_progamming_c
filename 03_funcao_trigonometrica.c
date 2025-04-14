#include <corecrt_math_defines.h>
#include <math.h>
#include <stdbool.h>
#include <stdio.h>

void exibir_resultado(int opcao, double valor) {
  double graus = valor * M_PI / 180;
  double radianos = valor;

  printf("\nResultado: ");
  switch (opcao) {
  case 1:
    printf("Seno de %.2f radianos: %.2f", valor, sin(radianos));
    break;
  case 2:
    printf("Seno de %.2f graus: %.2f", valor, sin(graus));
    break;
  case 3:
    printf("Tangente de %.2f radianos: %.2f", valor, tan(radianos));
    break;
  case 4:
    printf("Tangente de %.2f graus: %.2f", valor, tan(graus));
    break;
  default:
    printf("Opcao invalida");
  }
}

int main() {
  double valor;
  int opcao;

  while (true) {
    printf("\n\n(1) Obter seno a partir de um valor em radianos");
    printf("\n(2) Obter seno a partir de um valor em graus");
    printf("\n(3) Obter tangente a partir de um valor em radianos");
    printf("\n(4) Obter tangente a partir de um valor em graus");
    printf("\n(5) Sair\n");

    printf("\nEscolha uma opcao: ");
    scanf("%d", &opcao);

    if (opcao == 5) {
      printf("\nSaindo...");
      break;
    }

    if (opcao < 1 || opcao > 5) {
      printf("\nOpcao invalida! Tente novamente\n");
      continue;
    }

    printf("Digite o valor: ");
    scanf("%lf", &valor);

    exibir_resultado(opcao, valor);
  }

  return 0;
}
