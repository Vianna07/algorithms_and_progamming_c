#include <stdio.h>
#include <stdlib.h>

void get_data(float *lesson_value, int *lessons_worked_month,
              float *inss_discount_percentage) {
  printf("\nEnter the lesson value: ");
  scanf("%f", lesson_value);
  printf("Enter the number of lessons worked in the month: ");
  scanf("%d", lessons_worked_month);
  printf("Enter the INSS discount percentage: ");
  scanf("%f", inss_discount_percentage);
}

void validate_data(float lesson_value, int lessons_worked_month,
                   float inss_discount_percentage) {
  if (lesson_value <= 0) {
    printf("\nInvalid lesson value!\n");
    exit(0);
  }
  if (lessons_worked_month <= 0) {
    printf("\nInvalid number of lessons worked in the month!\n");
    exit(0);
  }
  if (inss_discount_percentage < 0 || inss_discount_percentage > 100) {
    printf("\nInvalid INSS discount percentage!\n");
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
  printf("\nGross salary: $ %.2f\n", gross_salary);
  printf("Net salary: $ %.2f\n", net_salary);
}

int main(void) {
  float lesson_value, inss_discount_percentage, gross_salary, net_salary;
  int lessons_worked_month;

  get_data(&lesson_value, &lessons_worked_month, &inss_discount_percentage);
  validate_data(lesson_value, lessons_worked_month, inss_discount_percentage);

  gross_salary = calculate_gross_salary(lesson_value, lessons_worked_month);
  net_salary = calculate_net_salary(gross_salary, inss_discount_percentage);

  display_salaries(gross_salary, net_salary);

  return 0;
}
