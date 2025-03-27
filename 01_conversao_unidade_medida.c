#include <stdio.h>

int main() {
    float pes, polegadas, jardas, milhas;

    /*
    * Considere:
    * 1 pé = 12 polegadas
    * 1 jarda = 3 pés
    * 1 milha = 1760 jardas
    */

    printf("\nQual a medida em pes?: ");
    scanf("%f", &pes);
    
    if (pes < 0) {
    	printf("\nValor nao pode ser negativo!");	
    	return 0;
	}

    polegadas = pes * 12;
    jardas = pes * 3;
    milhas = jardas / 1760;

    printf("\n\nEm polegadas: %f", polegadas);
    printf("\n\nEm jardas: %f", jardas);
    printf("\n\nEm milhas: %f", milhas);

    return 0;
}

