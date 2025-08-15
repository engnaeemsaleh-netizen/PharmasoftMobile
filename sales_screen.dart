
import 'package:flutter/material.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sales')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (_, i) => ListTile(
          leading: const Icon(Icons.receipt_long),
          title: Text('Invoice #${i+1}'),
          subtitle: const Text('Tap to open'),
          trailing: const Text('\$00.00'),
          onTap: () {},
        ),
      ),
    );
  }
}
