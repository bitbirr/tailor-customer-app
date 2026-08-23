import '../../core/ids.dart';
import '../../domain/entities/sync.dart';

/// Records a mutation for later push. Drift impl must call this inside the
/// same SQLite transaction as the domain write.
class OutboxWriter {
  OutboxWriter({List<OutboxEntry>? store}) : _store = store ?? <OutboxEntry>[];

  final List<OutboxEntry> _store;

  List<OutboxEntry> get pending => List.unmodifiable(_store);

  OutboxEntry enqueue({
    required SyncEntityType entityType,
    required String entityId,
    required SyncOperationType operation,
    required String payloadJson,
    required int nowMs,
  }) {
    final entry = OutboxEntry(
      id: newClientId(),
      entityType: entityType,
      entityId: entityId,
      operation: operation,
      payloadJson: payloadJson,
      idempotencyKey: newClientId(),
      nextAttemptAtMs: nowMs,
      createdAtMs: nowMs,
    );
    _store.add(entry);
    return entry;
  }

  void acknowledge(String id) {
    _store.removeWhere((e) => e.id == id);
  }
}
