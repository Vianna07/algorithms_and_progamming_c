#define _USE_MATH_DEFINES

#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

void exibir_opcoes(void) {
  printf("\nEscolha uma opcao:\n");
  printf("1. Seno do angulo dado em radianos\n");
  printf("2. Seno do angulo dado em graus\n");
  printf("3. Tangente do angulo dado em radianos\n");
  printf("4. Tangente do angulo dado em graus\n");
  printf("5. Sair\n");
}

void sair(short opcao) {
  if (opcao == 5) {
    printf("Saindo...\n");
    exit(0);
  }
}

bool opcao_valida(short opcao) { return (opcao >= 1 && opcao <= 4); }

double graus_para_radianos(double graus) { return graus * M_PI / 180; }

void exibir_resultado(short opcao, double angulo) {
  double radianos = graus_para_radianos(angulo);

  switch (opcao) {
  case 1:
    printf("Seno de %.4f radianos =  %.2f", radianos, sin(radianos));
    break;
  case 2:
    printf("Seno de %.2f graus =  %.2f", angulo, sin(radianos));
    break;
  case 3:
    printf("Tangente de %.4f radianos =  %.2f", radianos, tan(radianos));
    break;
  case 4:
    printf("Tangente de %.2f graus =  %.2f", angulo, tan(radianos));
    break;
  }

  printf("\n");
}

int main(void) {
  double angulo;
  short opcao;

  while (true) {
    printf("\nDigite o valor de um angulo: ");
    scanf("%lf", &angulo);

    exibir_opcoes();

    printf("\nDigite a opcao desejada: ");
    scanf("%hd", &opcao);

    sair(opcao);

    if (!opcao_valida(opcao)) {
      printf("Opcao invalida. Tente novamente.\n");
      continue;
    }

    exibir_resultado(opcao, angulo);
  }
}
