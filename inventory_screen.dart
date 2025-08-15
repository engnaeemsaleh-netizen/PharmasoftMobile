
import 'package:flutter/material.dart';
import '../models/item.dart';
import '../repos/item_repo.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final _repo = ItemRepo();
  String _search = '';
  List<Item> _items = [];

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    final list = await _repo.all(query: _search);
    setState(() => _items = list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search by name/barcode/sku',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (v) {
                _search = v;
                _refresh();
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => const ItemFormScreen()));
          await _refresh();
        },
        child: const Icon(Icons.add_box),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (_, i) {
            final it = _items[i];
            return Dismissible(
              key: ValueKey('item_${it.id}_${i}'),
              background: Container(color: Colors.red),
              onDismissed: (_) async {
                if (it.id != null) {
                  await _repo.delete(it.id!);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item deleted')));
                }
              },
              child: ListTile(
                leading: const Icon(Icons.medication),
                title: Text(it.name),
                subtitle: Text('Qty: ${it.qty}  •  Sale: ${it.priceSale.toStringAsFixed(2)}'),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    await Navigator.push(context, MaterialPageRoute(builder: (_) => ItemFormScreen(item: it)));
                    await _refresh();
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ItemFormScreen extends StatefulWidget {
  final Item? item;
  const ItemFormScreen({super.key, this.item});

  @override
  State<ItemFormScreen> createState() => _ItemFormScreenState();
}

class _ItemFormScreenState extends State<ItemFormScreen> {
  final _repo = ItemRepo();
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _barcode = TextEditingController();
  final _sku = TextEditingController();
  final _unit = TextEditingController();
  final _priceSale = TextEditingController(text: '0');
  final _pricePurchase = TextEditingController(text: '0');
  final _qty = TextEditingController(text: '0');
  final _expDate = TextEditingController();

  @override
  void initState() {
    super.initState();
    final it = widget.item;
    if (it != null) {
      _name.text = it.name;
      _barcode.text = it.barcode ?? '';
      _sku.text = it.sku ?? '';
      _unit.text = it.unit ?? '';
      _priceSale.text = it.priceSale.toString();
      _pricePurchase.text = it.pricePurchase.toString();
      _qty.text = it.qty.toString();
      _expDate.text = it.expDate ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.item == null ? 'Add Item' : 'Edit Item')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(controller: _name, decoration: const InputDecoration(labelText: 'Name'), validator: _req),
              TextFormField(controller: _barcode, decoration: const InputDecoration(labelText: 'Barcode')),
              TextFormField(controller: _sku, decoration: const InputDecoration(labelText: 'SKU')),
              TextFormField(controller: _unit, decoration: const InputDecoration(labelText: 'Unit (e.g., box, tab)')),
              TextFormField(controller: _priceSale, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Sale Price'), validator: _num),
              TextFormField(controller: _pricePurchase, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Purchase Price'), validator: _num),
              TextFormField(controller: _qty, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Quantity'), validator: _num),
              TextFormField(controller: _expDate, decoration: const InputDecoration(labelText: 'Expiry (YYYY-MM-DD)')),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (!(_formKey.currentState?.validate() ?? false)) return;
                  final it = Item(
                    id: widget.item?.id,
                    name: _name.text.trim(),
                    barcode: _barcode.text.trim().isEmpty ? null : _barcode.text.trim(),
                    sku: _sku.text.trim().isEmpty ? null : _sku.text.trim(),
                    unit: _unit.text.trim().isEmpty ? null : _unit.text.trim(),
                    priceSale: double.tryParse(_priceSale.text) ?? 0,
                    pricePurchase: double.tryParse(_pricePurchase.text) ?? 0,
                    qty: double.tryParse(_qty.text) ?? 0,
                    expDate: _expDate.text.trim().isEmpty ? null : _expDate.text.trim(),
                  );
                  if (widget.item == null) {
                    await _repo.insert(it);
                  } else {
                    await _repo.update(it);
                  }
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
