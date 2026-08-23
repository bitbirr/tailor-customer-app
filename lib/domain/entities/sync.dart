enum SyncOperationType { upsert, delete }

enum SyncEntityType { customer, measurementSet }

class OutboxEntry {
  const OutboxEntry({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.operation,
    required this.payloadJson,
    required this.idempotencyKey,
    this.attempts = 0,
    required this.nextAttemptAtMs,
    required this.createdAtMs,
    this.lastError,
  });

  final String id;
  final SyncEntityType entityType;
  final String entityId;
  final SyncOperationType operation;
  final String payloadJson;
  final String idempotencyKey;
  final int attempts;
  final int nextAttemptAtMs;
  final int createdAtMs;
  final String? lastError;
}

class SyncState {
  const SyncState({
    this.pullCursor,
    this.lastSuccessAtMs,
    this.lastError,
    this.pendingCount = 0,
  });

  final String? pullCursor;
  final int? lastSuccessAtMs;
  final String? lastError;
  final int pendingCount;

  bool get hasPending => pendingCount > 0;
}
