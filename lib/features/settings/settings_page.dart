import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'Week-1 decisions live here later: display units (cm/in), identity, '
          'and sync endpoint. Tokens must not be stored in SQLite.',
        ),
      ),
    );
  }
}
