
import 'package:flutter/material.dart';

class EmployeesScreen extends StatelessWidget {
  const EmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Employees')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.person_add),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (_, i) => ListTile(
          leading: const Icon(Icons.person),
          title: Text('Employee ${(i+1)}'),
          subtitle: const Text('Role: Cashier'),
        ),
      ),
    );
  }
}
