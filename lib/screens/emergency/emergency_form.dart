import 'package:flutter/material.dart';

class EmergencyForm extends StatelessWidget {
  const EmergencyForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency"),
      ),
      body: const Center(
        child: Text("Emergency Page (Next Step 🔥)"),
      ),
    );
  }
}