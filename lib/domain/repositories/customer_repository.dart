import '../entities/customer.dart';

/// Local customer store. Implementations must remain usable with no network.
abstract class CustomerRepository {
  Stream<List<Customer>> watchAll({String query = ''});

  Future<Customer?> findById(String id);

  /// Persists the customer and an outbox row in one local transaction.
  Future<Customer> upsert(Customer customer);

  /// Soft-deletes and writes a tombstone outbox row in one local transaction.
  Future<void> delete(String id);
}
