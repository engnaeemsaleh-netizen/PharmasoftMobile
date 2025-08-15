
import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(leading: Icon(Icons.bar_chart), title: Text('Daily Sales Report')),
          ListTile(leading: Icon(Icons.insert_chart_outlined), title: Text('Monthly Profit & Loss')),
          ListTile(leading: Icon(Icons.inventory_2), title: Text('Expiring Items Report')),
        ],
      ),
    );
  }
}
