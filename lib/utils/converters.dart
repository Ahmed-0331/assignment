double poundsToKg(double lb) => lb * 0.45359237;

double cmToMeters(double cm) => cm / 100;

double feetInchToMeters(double feet, double inch) {
  final totalInches = feet * 12 + inch;
  return totalInches * 0.0254;
}
