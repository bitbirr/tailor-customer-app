import 'package:flutter_test/flutter_test.dart';
import 'package:tailor_customer_app/core/units.dart';

void main() {
  const units = MeasurementUnits();

  test('stores centimetres as integer millimetres', () {
    expect(units.cmToMm(42.4), 424);
    expect(units.mmToCm(424), 42.4);
  });

  test('converts inches at the UI edge only', () {
    expect(units.inchesToMm(10), 254);
    expect(units.mmToInches(254), closeTo(10, 0.0001));
  });
}
