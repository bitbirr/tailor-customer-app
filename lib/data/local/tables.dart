import 'package:drift/drift.dart';

/// Drift table definitions. `AppDatabase` is generated in Phase 1 via build_runner.
/// See docs/schema/local-sqlite.md.

@DataClassName('CustomerRow')
class Customers extends Table {
  TextColumn get id => text()();
  TextColumn get displayName => text()();
  TextColumn get nameSearch => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get phoneSearch => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get photoPath => text().nullable()();
  IntColumn get createdAtMs => integer()();
  IntColumn get updatedAtMs => integer()();
  IntColumn get deletedAtMs => integer().nullable()();
  IntColumn get revision => integer().withDefault(const Constant(1))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('GarmentTypeRow')
class GarmentTypes extends Table {
  TextColumn get id => text()();
  TextColumn get key => text().unique()();
  TextColumn get label => text()();
  IntColumn get sortOrder => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('MeasurementFieldRow')
class MeasurementFields extends Table {
  TextColumn get id => text()();
  TextColumn get garmentTypeId => text().references(GarmentTypes, #id)();
  TextColumn get key => text()();
  TextColumn get label => text()();
  IntColumn get sortOrder => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('MeasurementSetRow')
class MeasurementSets extends Table {
  TextColumn get id => text()();
  TextColumn get customerId => text().references(Customers, #id)();
  TextColumn get garmentTypeId => text().references(GarmentTypes, #id)();
  IntColumn get takenAtMs => integer()();
  TextColumn get notes => text().nullable()();
  IntColumn get createdAtMs => integer()();
  IntColumn get updatedAtMs => integer()();
  IntColumn get deletedAtMs => integer().nullable()();
  IntColumn get revision => integer().withDefault(const Constant(1))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('MeasurementValueRow')
class MeasurementValues extends Table {
  TextColumn get setId => text().references(MeasurementSets, #id)();
  TextColumn get fieldId => text().references(MeasurementFields, #id)();
  IntColumn get valueMm => integer()();

  @override
  Set<Column<Object>> get primaryKey => {setId, fieldId};
}

@DataClassName('OutboxRow')
class SyncOutbox extends Table {
  TextColumn get id => text()();
  TextColumn get entityType => text()();
  TextColumn get entityId => text()();
  TextColumn get operation => text()();
  TextColumn get payloadJson => text()();
  TextColumn get idempotencyKey => text().unique()();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  IntColumn get nextAttemptAtMs => integer()();
  IntColumn get createdAtMs => integer()();
  TextColumn get lastError => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('SyncStateRow')
class SyncStateRows extends Table {
  IntColumn get id => integer()();
  TextColumn get pullCursor => text().nullable()();
  IntColumn get lastSuccessAtMs => integer().nullable()();
  TextColumn get lastError => text().nullable()();
  IntColumn get pendingCount => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
