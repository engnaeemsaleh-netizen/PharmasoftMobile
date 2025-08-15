
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  String _pharmacyName = 'Your Pharmacy';
  String _langCode = 'ar';
  bool _isDark = false;

  String get pharmacyName => _pharmacyName;
  String get langCode => _langCode;
  bool get isDark => _isDark;

  AppState() {
    _load();
  }

  Future<void> _load() async {
    final sp = await SharedPreferences.getInstance();
    _pharmacyName = sp.getString('pharmacyName') ?? _pharmacyName;
    _langCode = sp.getString('langCode') ?? _langCode;
    _isDark = sp.getBool('isDark') ?? _isDark;
    notifyListeners();
  }

  Future<void> setPharmacyName(String name) async {
    _pharmacyName = name;
    final sp = await SharedPreferences.getInstance();
    await sp.setString('pharmacyName', name);
    notifyListeners();
  }

  Future<void> setLangCode(String code) async {
    _langCode = code;
    final sp = await SharedPreferences.getInstance();
    await sp.setString('langCode', code);
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDark = !_isDark;
    final sp = await SharedPreferences.getInstance();
    await sp.setBool('isDark', _isDark);
    notifyListeners();
  }
}
