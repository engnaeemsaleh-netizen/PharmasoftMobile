
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'src/core/app_state.dart';
import 'src/core/locale_strings.dart';
import 'src/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PharmaSoftApp());
}

class PharmaSoftApp extends StatelessWidget {
  const PharmaSoftApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: Consumer<AppState>(
        builder: (context, app, _) {
          return MaterialApp(
            title: 'PharmaSoft Pro',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorSchemeSeed: Colors.teal,
              brightness: app.isDark ? Brightness.dark : Brightness.light,
              textTheme: GoogleFonts.cairoTextTheme(),
              useMaterial3: true,
            ),
            initialRoute: Routes.splash,
            routes: Routes.map,
            locale: Locale(app.langCode),
          );
        },
      ),
    );
  }
}
