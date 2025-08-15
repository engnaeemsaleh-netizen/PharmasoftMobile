
import 'package:flutter/material.dart';

class PurchasesScreen extends StatelessWidget {
  const PurchasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Purchases')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_shopping_cart),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (_, i) => ListTile(
          leading: const Icon(Icons.local_shipping),
          title: Text('Supplier invoice #${i+1}'),
          subtitle: const Text('Tap to open'),
          onTap: () {},
        ),
      ),
    );
  }
}
