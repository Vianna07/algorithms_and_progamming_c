// use of GNU case range extension [-Wgnu-case-range]

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void get_data(float *weight, float *height) {
  printf("Enter your weight in kilograms: ");
  scanf("%f", weight);
  printf("Enter your height in centimeters: ");
  scanf("%f", height);
}

void validate_data(float weight, float height) {
  if (weight <= 0 || height <= 0) {
    printf("Invalid input. Weight and height must be positive numbers.\n");
    exit(1);
  }
}

double calculate_bmi(float weight, float height) {
  double height_in_meters = height / 100.0;

  return weight / (height_in_meters * height_in_meters);
}

void display_result(double bmi) {
  printf("\nYour BMI is: %.2lf\n", bmi);

  switch ((int)bmi) {
  case 0 ... 18:
    printf("Classification: Underweight\n");
    break;
  case 19 ... 24:
    printf("Classification: Normal weight\n");
    break;
  case 25 ... 29:
    printf("Classification: Overweight\n");
    break;
  default:
    printf("Classification: Obesity\n");
    break;
  }
}

int main(void) {
  float weight, height;
  double bmi;

  get_data(&weight, &height);
  validate_data(weight, height);

  bmi = calculate_bmi(weight, height);

  display_result(bmi);

  return 0;
}
