class GarmentType {
  const GarmentType({
    required this.id,
    required this.key,
    required this.label,
    required this.sortOrder,
  });

  final String id;
  final String key;
  final String label;
  final int sortOrder;
}

class MeasurementField {
  const MeasurementField({
    required this.id,
    required this.garmentTypeId,
    required this.key,
    required this.label,
    required this.sortOrder,
  });

  final String id;
  final String garmentTypeId;
  final String key;
  final String label;
  final int sortOrder;
}

class MeasurementValue {
  const MeasurementValue({
    required this.fieldId,
    required this.valueMm,
  });

  final String fieldId;
  final int valueMm;
}

class MeasurementSet {
  const MeasurementSet({
    required this.id,
    required this.customerId,
    required this.garmentTypeId,
    required this.takenAtMs,
    this.notes,
    required this.values,
    required this.createdAtMs,
    required this.updatedAtMs,
    this.deletedAtMs,
    this.revision = 1,
  });

  final String id;
  final String customerId;
  final String garmentTypeId;
  final int takenAtMs;
  final String? notes;
  final List<MeasurementValue> values;
  final int createdAtMs;
  final int updatedAtMs;
  final int? deletedAtMs;
  final int revision;
}
