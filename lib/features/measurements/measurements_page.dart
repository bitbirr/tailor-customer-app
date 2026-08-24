import 'package:flutter/material.dart';

/// Phase 3: garment picker, numeric mm entry, history, timestamps.
class MeasurementsPage extends StatelessWidget {
  const MeasurementsPage({super.key, required this.customerId});

  final String customerId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Measurements')),
      body: const Center(
        child: Text('Measurement entry ships in Phase 3 (offline vertical slice).'),
      ),
    );
  }
}
