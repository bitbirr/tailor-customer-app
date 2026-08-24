import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';

/// Non-blocking sync status. Local work must remain usable while this shows.
class SyncStatusBanner extends ConsumerWidget {
  const SyncStatusBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(syncStateStoreProvider).current;
    final outbox = ref.watch(outboxWriterProvider);
    final pending = outbox.pending.length;
    if (pending == 0 && state.lastError == null) {
      return const SizedBox.shrink();
    }
    final label = state.lastError != null
        ? 'Sync issue — local records are still saved'
        : '$pending change(s) waiting to sync';
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(label),
      ),
    );
  }
}
