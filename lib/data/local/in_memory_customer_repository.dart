import 'dart:async';
import 'dart:convert';

import '../../core/clock.dart';
import '../../core/search.dart';
import '../../domain/entities/customer.dart';
import '../../domain/entities/sync.dart';
import '../../domain/repositories/customer_repository.dart';
import '../sync/outbox_writer.dart';

/// Foundation stand-in until Drift `AppDatabase` is generated in Phase 1–2.
/// Demonstrates the required contract: search, tombstones, outbox-on-write.
class InMemoryCustomerRepository implements CustomerRepository {
  InMemoryCustomerRepository({
    required OutboxWriter outbox,
    Clock clock = const SystemClock(),
    SearchNormalizer search = const SearchNormalizer(),
  })  : _outbox = outbox,
        _clock = clock,
        _search = search;

  final OutboxWriter _outbox;
  final Clock _clock;
  final SearchNormalizer _search;
  final Map<String, Customer> _rows = {};
  final _controller = StreamController<List<Customer>>.broadcast();

  @override
  Stream<List<Customer>> watchAll({String query = ''}) async* {
    yield _filtered(query);
    await for (final _ in _controller.stream) {
      yield _filtered(query);
    }
  }

  @override
  Future<Customer?> findById(String id) async {
    final row = _rows[id];
    if (row == null || row.isDeleted) return null;
    return row;
  }

  @override
  Future<Customer> upsert(Customer customer) async {
    final now = _clock.nowMs();
    final existing = _rows[customer.id];
    final saved = Customer(
      id: customer.id,
      displayName: customer.displayName,
      phone: customer.phone,
      email: customer.email,
      address: customer.address,
      photoPath: customer.photoPath,
      createdAtMs: existing?.createdAtMs ?? customer.createdAtMs,
      updatedAtMs: now,
      revision: (existing?.revision ?? 0) + 1,
    );
    _rows[saved.id] = saved;
    _outbox.enqueue(
      entityType: SyncEntityType.customer,
      entityId: saved.id,
      operation: SyncOperationType.upsert,
      payloadJson: jsonEncode({'id': saved.id, 'revision': saved.revision}),
      nowMs: now,
    );
    _controller.add(_live());
    return saved;
  }

  @override
  Future<void> delete(String id) async {
    final existing = _rows[id];
    if (existing == null) return;
    final now = _clock.nowMs();
    _rows[id] = existing.copyWith(
      deletedAtMs: now,
      updatedAtMs: now,
      revision: existing.revision + 1,
    );
    _outbox.enqueue(
      entityType: SyncEntityType.customer,
      entityId: id,
      operation: SyncOperationType.delete,
      payloadJson: jsonEncode({'id': id, 'revision': existing.revision + 1}),
      nowMs: now,
    );
    _controller.add(_live());
  }

  List<Customer> _live() =>
      _rows.values.where((c) => !c.isDeleted).toList(growable: false);

  List<Customer> _filtered(String query) {
    final live = _live();
    final q = query.trim();
    if (q.isEmpty) return live;
    final name = _search.normalizeName(q);
    final phone = _search.normalizePhone(q) ?? '';
    return live.where((c) {
      final nameHit = _search.normalizeName(c.displayName).contains(name);
      final phoneHit = phone.isNotEmpty &&
          (_search.normalizePhone(c.phone) ?? '').contains(phone);
      return nameHit || phoneHit;
    }).toList(growable: false);
  }
}
