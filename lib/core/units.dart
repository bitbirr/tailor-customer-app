/// Storage is always integer millimetres. Convert only at UI / export edges.
class MeasurementUnits {
  const MeasurementUnits();

  int cmToMm(num cm) => (cm * 10).round();

  int inchesToMm(num inches) => (inches * 25.4).round();

  double mmToCm(int mm) => mm / 10.0;

  double mmToInches(int mm) => mm / 25.4;
}
