import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../core/ids.dart';
import '../../domain/entities/customer.dart';
import '../sync/sync_status_banner.dart';

class CustomersPage extends ConsumerStatefulWidget {
  const CustomersPage({super.key});

  @override
  ConsumerState<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends ConsumerState<CustomersPage> {
  final _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repo = ref.watch(customerRepositoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
        actions: [
          IconButton(
            tooltip: 'Export',
            onPressed: () => context.push('/export'),
            icon: const Icon(Icons.ios_share),
          ),
          IconButton(
            tooltip: 'Settings',
            onPressed: () => context.push('/settings'),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        children: [
          const SyncStatusBanner(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _search,
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                labelText: 'Search name or phone',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: repo.watchAll(query: _search.text),
              builder: (context, snapshot) {
                final items = snapshot.data ?? const <Customer>[];
                if (items.isEmpty) {
                  return const Center(
                    child: Text('No customers yet. Add one to replace the notebook.'),
                  );
                }
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final customer = items[index];
                    return ListTile(
                      title: Text(customer.displayName),
                      subtitle: Text(customer.phone ?? 'No phone'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final now = ref.read(clockProvider).nowMs();
          await repo.upsert(
            Customer(
              id: newClientId(),
              displayName: 'New customer',
              createdAtMs: now,
              updatedAtMs: now,
            ),
          );
          setState(() {});
        },
        icon: const Icon(Icons.person_add),
        label: const Text('Add customer'),
      ),
    );
  }
}
