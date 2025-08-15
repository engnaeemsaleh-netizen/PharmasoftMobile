
import 'package:flutter/material.dart';
import '../core/app_state.dart';
import '../core/locale_strings.dart';
import '../routes.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final app = context.read<AppState>();
    await LocaleStrings.load(app.langCode);
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_pharmacy, size: 72),
            const SizedBox(height: 16),
            Text(LocaleStrings.t('welcome', params: {'pharmacy': app.pharmacyName}),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
