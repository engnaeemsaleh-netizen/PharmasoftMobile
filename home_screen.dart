
import 'package:flutter/material.dart';
import '../routes.dart';
import '../core/app_state.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tiles = [
      _tile(context, Icons.point_of_sale, 'Sales', Routes.sales),
      _tile(context, Icons.shopping_cart, 'Purchases', Routes.purchases),
      _tile(context, Icons.inventory, 'Inventory', Routes.inventory),
      _tile(context, Icons.payments, 'Expenses', Routes.expenses),
      _tile(context, Icons.bar_chart, 'Reports', Routes.reports),
      _tile(context, Icons.group, 'Employees', Routes.employees),
      _tile(context, Icons.people, 'Clients & Suppliers', Routes.clientsSuppliers),
      _tile(context, Icons.settings, 'Settings', Routes.settings),
    ];

    final app = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(app.pharmacyName),
        actions: [
          IconButton(
            onPressed: () => context.read<AppState>().toggleTheme(),
            icon: const Icon(Icons.brightness_6),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: tiles,
      ),
    );
  }

  Widget _tile(BuildContext context, IconData icon, String label, String route) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Card(
        elevation: 1,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 36),
              const SizedBox(height: 8),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}
