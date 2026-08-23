import 'package:flutter_test/flutter_test.dart';
import 'package:tailor_customer_app/core/clock.dart';
import 'package:tailor_customer_app/data/local/in_memory_customer_repository.dart';
import 'package:tailor_customer_app/data/sync/outbox_writer.dart';
import 'package:tailor_customer_app/domain/entities/customer.dart';
import 'package:tailor_customer_app/domain/entities/sync.dart';

void main() {
  late OutboxWriter outbox;
  late InMemoryCustomerRepository repo;

  setUp(() {
    outbox = OutboxWriter();
    repo = InMemoryCustomerRepository(
      outbox: outbox,
      clock: const FixedClock(1_700_000_000_000),
    );
  });

  test('upsert writes an outbox row and is searchable offline', () async {
    await repo.upsert(
      const Customer(
        id: 'c1',
        displayName: 'Abebe Kebede',
        phone: '+251 911 000 000',
        createdAtMs: 1,
        updatedAtMs: 1,
      ),
    );

    expect(outbox.pending, hasLength(1));
    expect(outbox.pending.single.operation, SyncOperationType.upsert);

    final byName = await repo.watchAll(query: 'abebe').first;
    expect(byName.single.id, 'c1');

    final byPhone = await repo.watchAll(query: '911').first;
    expect(byPhone.single.displayName, 'Abebe Kebede');
  });

  test('delete tombstones locally and enqueues a delete outbox row', () async {
    await repo.upsert(
      const Customer(
        id: 'c1',
        displayName: 'Abebe',
        createdAtMs: 1,
        updatedAtMs: 1,
      ),
    );
    await repo.delete('c1');

    expect(await repo.findById('c1'), isNull);
    expect(outbox.pending.last.operation, SyncOperationType.delete);
    final remaining = await repo.watchAll().first;
    expect(remaining, isEmpty);
  });
}
