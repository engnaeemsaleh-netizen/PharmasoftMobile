
import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../repos/expense_repo.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final _repo = ExpenseRepo();
  List<Expense> _items = [];

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    final list = await _repo.all();
    setState(() => _items = list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expenses')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => const ExpenseFormScreen()));
          await _refresh();
        },
        child: const Icon(Icons.add_card),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (_, i) {
            final it = _items[i];
            return Dismissible(
              key: ValueKey('exp_${it.id}_${i}'),
              background: Container(color: Colors.red),
              onDismissed: (_) async {
                if (it.id != null) await _repo.delete(it.id!);
              },
              child: ListTile(
                leading: const Icon(Icons.receipt),
                title: Text(it.title),
                subtitle: Text(it.ts),
                trailing: Text(it.amount.toStringAsFixed(2)),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ExpenseFormScreen extends StatefulWidget {
  const ExpenseFormScreen({super.key});

  @override
  State<ExpenseFormScreen> createState() => _ExpenseFormScreenState();
}

class _ExpenseFormScreenState extends State<ExpenseFormScreen> {
  final _repo = ExpenseRepo();
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _amount = TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: _title, decoration: const InputDecoration(labelText: 'Title'), validator: _req),
              TextFormField(controller: _amount, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Amount'), validator: _num),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (!(_formKey.currentState?.validate() ?? false)) return;
                  final now = DateTime.now().toIso8601String();
                  final e = Expense(title: _title.text.trim(), amount: double.tryParse(_amount.text) ?? 0, ts: now);
                  await _repo.insert(e);
                  if (!mounted) return;
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _req(String? v) => (v == null || v.trim().isEmpty) ? 'Required' : null;
  String? _num(String? v) {
    if (v == null || v.trim().isEmpty) return 'Required';
    return double.tryParse(v) == null ? 'Invalid number' : null;
  }
}
