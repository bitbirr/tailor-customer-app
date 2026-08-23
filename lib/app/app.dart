import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'router.dart';
import 'theme.dart';

class TailorCustomerApp extends StatelessWidget {
  TailorCustomerApp({super.key, GoRouter? router})
      : _router = router ?? buildRouter();

  final GoRouter _router;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: 'Tailor Customers',
        theme: buildAppTheme(),
        routerConfig: _router,
      ),
    );
  }
}
