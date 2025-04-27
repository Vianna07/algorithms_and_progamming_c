// use of GNU case range extension [-Wgnu-case-range]

#include <cmath>
#include <iomanip>
#include <iostream>
#include <stdexcept>

void get_data(float &weight, float &height) {
  std::cout << "Enter your weight in kilograms: ";
  std::cin >> weight;
  std::cout << "Enter your height in centimeters: ";
  std::cin >> height;
}

void validate_data(float weight, float height) {
  if (weight <= 0 || height <= 0) {
    throw std::invalid_argument(
        "\nInvalid input. Weight and height must be positive numbers.");
  }
}

double calculate_bmi(float weight, float height) {
  double height_in_meters = height / 100.0;

  return weight / (height_in_meters * height_in_meters);
}

void display_result(double bmi) {
  std::cout << "\nYour BMI is: " << std::fixed << std::setprecision(2) << bmi
            << "\n";

  switch (static_cast<int>(bmi)) {
  case 0 ... 18:
    std::cout << "Classification: Underweight\n";
    break;
  case 19 ... 24:
    std::cout << "Classification: Normal weight\n";
    break;
  case 25 ... 29:
    std::cout << "Classification: Overweight\n";
    break;
  default:
    std::cout << "Classification: Obesity\n";
    break;
  }
}

int main() {
  try {
    float weight, height;

    get_data(weight, height);
    validate_data(weight, height);

    double bmi = calculate_bmi(weight, height);

    display_result(bmi);
  } catch (const std::exception &error) {
    std::cerr << error.what() << "\n";
    return 1;
  }

  return 0;
}
