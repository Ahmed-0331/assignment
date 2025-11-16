import 'package:flutter/material.dart';

double calculateBMIValue(double weightKg, double heightM) {
  return weightKg / (heightM * heightM);
}

class BMIResult {
  final String category;
  final Color color;

  BMIResult(this.category, this.color);
}

BMIResult getBMICategory(double bmi) {
  if (bmi < 18.5) {
    return BMIResult("Underweight", Colors.blue);
  } else if (bmi < 25) {
    return BMIResult("Normal", Colors.green);
  } else if (bmi < 30) {
    return BMIResult("Overweight", Colors.orange);
  } else {
    return BMIResult("Obese", Colors.red);
  }
}
