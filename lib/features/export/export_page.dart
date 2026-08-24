import 'package:flutter/material.dart';

/// Phase 6: CSV + PDF from local rows, PII warning, temp-file cleanup.
class ExportPage extends StatelessWidget {
  const ExportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Export')),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'Export is generated offline from local data. A PII warning is required '
          'before the OS share sheet. Implementation is Phase 6.',
        ),
      ),
    );
  }
}
