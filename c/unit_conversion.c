#include <stdio.h>

int main(void) {
  float feet, inches, yards, miles;

  printf("\nWhat is the measurement in feet?: ");
  scanf("%f", &feet);

  if (feet < 0) {
    printf("\nValue cannot be negative!");
    return 0;
  }

  inches = feet * 12;
  yards = feet * 3;
  miles = yards / 1760;

  printf("\n\nIn inches: %f", inches);
  printf("\nIn yards: %f", yards);
  printf("\nIn miles: %f", miles);

  return 0;
}
