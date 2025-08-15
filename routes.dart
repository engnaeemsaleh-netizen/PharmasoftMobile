
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/sales_screen.dart';
import 'screens/purchases_screen.dart';
import 'screens/inventory_screen.dart';
import 'screens/expenses_screen.dart';
import 'screens/reports_screen.dart';
import 'screens/employees_screen.dart';
import 'screens/clients_suppliers_screen.dart';
import 'screens/settings_screen.dart';

class Routes {
  static const splash = '/';
  static const login = '/login';
  static const home = '/home';
  static const sales = '/sales';
  static const purchases = '/purchases';
  static const inventory = '/inventory';
  static const expenses = '/expenses';
  static const reports = '/reports';
  static const employees = '/employees';
  static const clientsSuppliers = '/clients_suppliers';
  static const settings = '/settings';

  static Map<String, WidgetBuilder> get map => {
    splash: (_) => const SplashScreen(),
    login: (_) => const LoginScreen(),
    home: (_) => const HomeScreen(),
    sales: (_) => const SalesScreen(),
    purchases: (_) => const PurchasesScreen(),
    inventory: (_) => const InventoryScreen(),
    expenses: (_) => const ExpensesScreen(),
    reports: (_) => const ReportsScreen(),
    employees: (_) => const EmployeesScreen(),
    clientsSuppliers: (_) => const ClientsSuppliersScreen(),
    settings: (_) => const SettingsScreen(),
  };
}
