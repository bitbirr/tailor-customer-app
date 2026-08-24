import '../../domain/entities/sync.dart';

class SyncStateStore {
  SyncState _state = const SyncState();

  SyncState get current => _state;

  void setPendingCount(int count) {
    _state = SyncState(
      pullCursor: _state.pullCursor,
      lastSuccessAtMs: _state.lastSuccessAtMs,
      lastError: _state.lastError,
      pendingCount: count,
    );
  }

  void markSuccess({required String cursor, required int atMs}) {
    _state = SyncState(
      pullCursor: cursor,
      lastSuccessAtMs: atMs,
      pendingCount: _state.pendingCount,
    );
  }

  void markError(String redactedMessage) {
    _state = SyncState(
      pullCursor: _state.pullCursor,
      lastSuccessAtMs: _state.lastSuccessAtMs,
      lastError: redactedMessage,
      pendingCount: _state.pendingCount,
    );
  }
}
