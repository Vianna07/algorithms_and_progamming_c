#include <stdio.h>

char *par_ou_impar(numero) {
    if (numero % 2 == 0) {
        return "par";
    }

    return "impar";
}

int main() {
    int numero_a, numero_b, numero_c;
	
    printf("\n1 - Digite um numero para somar: ");
    scanf("%i", &numero_a);
    printf("2 - Digite um numero para somar: ");
    scanf("%i", &numero_b);
    
    numero_c = numero_a + numero_b;
    
    printf("\nA soma dos dois numero eh: %i", numero_c);
    printf("\nO numero eh: %s", par_ou_impar(numero_c));
    
    return 0;
}
