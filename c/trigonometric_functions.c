#define _USE_MATH_DEFINES

#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

void display_options(void) {
  printf("\nChoose an option:\n");
  printf("1. Sine of the angle given in radians\n");
  printf("2. Sine of the angle given in degrees\n");
  printf("3. Tangent of the angle given in radians\n");
  printf("4. Tangent of the angle given in degrees\n");
  printf("5. Exit\n");
}

void exit_program(short option) {
  if (option == 5) {
    printf("Exiting...\n");
    exit(0);
  }
}

bool valid_option(short option) { return (option >= 1 && option <= 4); }

double degrees_to_radians(double degrees) { return degrees * M_PI / 180; }

void display_result(short option, double angle) {
  double radians = degrees_to_radians(angle);

  switch (option) {
  case 1:
    printf("Sine of %.4f radians =  %.2f", radians, sin(radians));
    break;
  case 2:
    printf("Sine of %.2f degrees =  %.2f", angle, sin(radians));
    break;
  case 3:
    printf("Tangent of %.4f radians =  %.2f", radians, tan(radians));
    break;
  case 4:
    printf("Tangent of %.2f degrees =  %.2f", angle, tan(radians));
    break;
  }

  printf("\n");
}

int main(void) {
  double angle;
  short option;

  while (true) {
    printf("\nEnter the value of an angle: ");
    scanf("%lf", &angle);

    display_options();

    printf("\nEnter the desired option: ");
    scanf("%hd", &option);

    exit_program(option);

    if (!valid_option(option)) {
      printf("Invalid option. Try again.\n");
      continue;
    }

    display_result(option, angle);
  }

  return 0;
}
