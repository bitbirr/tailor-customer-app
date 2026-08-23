import '../entities/measurement.dart';

abstract class MeasurementRepository {
  Stream<List<MeasurementSet>> watchForCustomer(String customerId);

  Future<MeasurementSet> upsert(MeasurementSet set);

  Future<void> delete(String id);

  Future<List<GarmentType>> garmentTypes();

  Future<List<MeasurementField>> fieldsFor(String garmentTypeId);
}
