import 'package:go_router/go_router.dart';

import '../features/customers/customers_page.dart';
import '../features/export/export_page.dart';
import '../features/settings/settings_page.dart';

GoRouter buildRouter() {
  return GoRouter(
    initialLocation: '/customers',
    routes: [
      GoRoute(
        path: '/customers',
        builder: (context, state) => const CustomersPage(),
      ),
      GoRoute(
        path: '/export',
        builder: (context, state) => const ExportPage(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
    ],
  );
}
