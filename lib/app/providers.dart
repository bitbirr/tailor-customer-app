import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/clock.dart';
import '../core/logging.dart';
import '../core/search.dart';
import '../data/local/in_memory_customer_repository.dart';
import '../data/sync/outbox_writer.dart';
import '../data/sync/sync_state_store.dart';
import '../domain/repositories/customer_repository.dart';

final clockProvider = Provider<Clock>((ref) => const SystemClock());

final loggerProvider = Provider<RedactingLogger>((ref) => const RedactingLogger());

final searchNormalizerProvider =
    Provider<SearchNormalizer>((ref) => const SearchNormalizer());

final outboxWriterProvider = Provider<OutboxWriter>((ref) => OutboxWriter());

final syncStateStoreProvider = Provider<SyncStateStore>((ref) => SyncStateStore());

final customerRepositoryProvider = Provider<CustomerRepository>((ref) {
  return InMemoryCustomerRepository(
    outbox: ref.watch(outboxWriterProvider),
    clock: ref.watch(clockProvider),
    search: ref.watch(searchNormalizerProvider),
  );
});
