
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class LocaleStrings {
  static Map<String, dynamic> _cache = {};

  static Future<void> load(String langCode) async {
    final data = await rootBundle.loadString('assets/i18n/$langCode.json');
    _cache = jsonDecode(data) as Map<String, dynamic>;
  }

  static String t(String key, {Map<String, String>? params}) {
    var v = _cache[key]?.toString() ?? key;
    params?.forEach((k, val) {
      v = v.replaceAll('{$k}', val);
    });
    return v;
  }
}
