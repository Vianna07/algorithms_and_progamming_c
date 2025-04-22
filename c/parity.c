#include <stdio.h>

char *even_or_odd(int number) {
  if (number % 2 == 0) {
    return "even";
  }

  return "odd";
}

int main(void) {
  int number_a, number_b, number_c;

  printf("\n1 - Enter a number to add: ");
  scanf("%d", &number_a);
  printf("2 - Enter a number to add: ");
  scanf("%d", &number_b);

  number_c = number_a + number_b;

  printf("\nThe sum of the two numbers is: %d", number_c);
  printf("\nThe number is: %s", even_or_odd(number_c));

  return 0;
}
