
import 'package:flutter/material.dart';

class ClientsSuppliersScreen extends StatelessWidget {
  const ClientsSuppliersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clients & Suppliers')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.group_add),
      ),
      body: ListView(children: const [
        ListTile(leading: Icon(Icons.person), title: Text('Client A'), subtitle: Text('555-0000')),
        ListTile(leading: Icon(Icons.local_shipping), title: Text('Supplier X'), subtitle: Text('555-1111')),
      ]),
    );
  }
}
