#include <iostream>

void get_data(float *lesson_value, int *lessons_worked_month,
              float *inss_discount_percentage) {
  std::cout << "\nEnter the lesson value: ";
  std::cin >> *lesson_value;
  std::cout << "Enter the number of lessons worked in the month: ";
  std::cin >> *lessons_worked_month;
  std::cout << "Enter the INSS discount percentage: ";
  std::cin >> *inss_discount_percentage;
}

void validate_data(float lesson_value, int lessons_worked_month,
                   float inss_discount_percentage) {
  if (lesson_value <= 0) {
    std::cout << "\nInvalid lesson value!\n";
    exit(0);
  }

  if (lessons_worked_month <= 0) {
    std::cout << "\nInvalid number of lessons worked in the month!\n";
    exit(0);
  }

  if (inss_discount_percentage < 0 || inss_discount_percentage > 100) {
    std::cout << "\nInvalid INSS discount percentage!\n";
    exit(0);
  }
}

float calculate_gross_salary(float lesson_value, int lessons_worked_month) {
  return lesson_value * (float)lessons_worked_month;
}

float calculate_net_salary(float gross_salary, float inss_discount_percentage) {
  return gross_salary - (gross_salary * inss_discount_percentage / 100);
}

void display_salaries(float gross_salary, float net_salary) {
  std::cout << "\nGross salary: $ " << gross_salary << "\n";
  std::cout << "Net salary: $ " << net_salary << "\n";
}

int main() {
  float lesson_value, inss_discount_percentage, gross_salary, net_salary;
  int lessons_worked_month;

  get_data(&lesson_value, &lessons_worked_month, &inss_discount_percentage);
  validate_data(lesson_value, lessons_worked_month, inss_discount_percentage);

  gross_salary = calculate_gross_salary(lesson_value, lessons_worked_month);
  net_salary = calculate_net_salary(gross_salary, inss_discount_percentage);

  display_salaries(gross_salary, net_salary);

  return 0;
}
