#include <iostream>

int main() {
  float feet, inches, yards, miles;

  std::cout << "\nWhat is the measurement in feet?: ";
  std::cin >> feet;

  if (feet < 0) {
    std::cout << "\nValue cannot be negative!";
    return 0;
  }

  inches = feet * 12;
  yards = feet * 3;
  miles = yards / 1760;

  std::cout << "\n\nIn inches: " << inches;
  std::cout << "\nIn yards: " << yards;
  std::cout << "\nIn miles: " << miles << std::endl;

  return 0;
}
