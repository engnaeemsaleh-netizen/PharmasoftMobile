
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/app_state.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _nameCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final app = context.read<AppState>();
    _nameCtrl.text = app.pharmacyName;
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _nameCtrl,
            decoration: const InputDecoration(labelText: 'Pharmacy name'),
            onSubmitted: (v) => app.setPharmacyName(v),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: app.langCode,
            items: const [
              DropdownMenuItem(value: 'ar', child: Text('Arabic')),
              DropdownMenuItem(value: 'en', child: Text('English')),
              DropdownMenuItem(value: 'fr', child: Text('Français')),
            ],
            onChanged: (v) => app.setLangCode(v ?? 'ar'),
            decoration: const InputDecoration(labelText: 'Language'),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Dark mode'),
            value: app.isDark,
            onChanged: (_) => app.toggleTheme(),
          ),
        ],
      ),
    );
  }
}
