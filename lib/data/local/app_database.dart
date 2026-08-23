import 'tables.dart';

export 'tables.dart';

/// Target Drift database. After `flutter pub get` and
/// `dart run build_runner build --delete-conflicting-outputs`, replace this
/// placeholder with the generated `_$AppDatabase` subclass:
///
/// ```dart
/// @DriftDatabase(tables: [
///   Customers,
///   GarmentTypes,
///   MeasurementFields,
///   MeasurementSets,
///   MeasurementValues,
///   SyncOutbox,
///   SyncStateRows,
/// ])
/// class AppDatabase extends _$AppDatabase {
///   AppDatabase(super.e);
///   @override
///   int get schemaVersion => 1;
/// }
/// ```
///
/// Phase 2 wires NativeDatabase, migrations, and seeded garment templates.
/// This placeholder stays import-safe so the foundation app analyzes before codegen.
class AppDatabase {
  AppDatabase();

  static const schemaVersion = 1;

  static const tableNames = <String>[
    'customers',
    'garment_types',
    'measurement_fields',
    'measurement_sets',
    'measurement_values',
    'sync_outbox',
    'sync_state',
  ];
}

/// Keep table classes referenced so they are not mistaken for unused docs.
const driftTableCatalog = <Type>[
  Customers,
  GarmentTypes,
  MeasurementFields,
  MeasurementSets,
  MeasurementValues,
  SyncOutbox,
  SyncStateRows,
];
