#include <cmath>
#include <iostream>

void display_options() {
  std::cout << "\nChoose an option:\n";
  std::cout << "1. Sine of the angle given in radians\n";
  std::cout << "2. Sine of the angle given in degrees\n";
  std::cout << "3. Tangent of the angle given in radians\n";
  std::cout << "4. Tangent of the angle given in degrees\n";
  std::cout << "5. Exit\n";
}

void exit_program(short option) {
  if (option == 5) {
    std::cout << "Exiting...\n";
    exit(0);
  }
}

bool valid_option(short option) { return (option >= 1 && option <= 4); }

double degrees_to_radians(double degrees) { return degrees * M_PI / 180.0; }

void display_result(short option, double angle) {
  double radians = degrees_to_radians(angle);

  switch (option) {
  case 1:
    std::cout << "Sine of " << radians << " radians = " << std::sin(radians)
              << "\n";
    break;
  case 2:
    std::cout << "Sine of " << angle << " degrees = " << std::sin(radians)
              << "\n";
    break;
  case 3:
    std::cout << "Tangent of " << radians << " radians = " << std::tan(radians)
              << "\n";
    break;
  case 4:
    std::cout << "Tangent of " << angle << " degrees = " << std::tan(radians)
              << "\n";
    break;
  default:
    std::cout << "Invalid option.\n";
  }
}

int main() {
  short option;
  double angle;

  while (true) {
    std::cout << "\nEnter the value of an angle: ";
    std::cin >> angle;

    display_options();

    std::cout << "\nEnter the desired option: ";
    std::cin >> option;

    exit_program(option);

    if (!valid_option(option)) {
      std::cout << "Invalid option. Try again.\n";
      continue;
    }

    display_result(option, angle);
  }

  return 0;
}
