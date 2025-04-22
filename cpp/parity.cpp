#include <iostream>

std::string even_or_odd(int number) {
  if (number % 2 == 0) {
    return "even";
  }

  return "odd";
}

int main() {
  int number_a, number_b, number_c;

  std::cout << "\n1 - Enter a number to add: ";
  std::cin >> number_a;
  std::cout << "2 - Enter another number to add: ";
  std::cin >> number_b;

  number_c = number_a + number_b;

  std::cout << "\nThe sum of the two numbers is: " << number_c;
  std::cout << "\nThe number is: " << even_or_odd(number_c) << std::endl;

  return 0;
}
