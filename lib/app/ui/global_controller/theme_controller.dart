import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/app/domain/repositories/preferences_repository.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class ThemeController extends SimpleNotifier {
  late ThemeMode _mode;

  ThemeController() {
    _mode = _preferences.isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  final PreferencesRepository _preferences = Get.i.find();

  ThemeMode get mode => _mode;
  bool get isDark => _mode == ThemeMode.dark;

  ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(
        brightness: Brightness.dark,
        backgroundColor: Color(0xff1c313a),
        elevation: 0,
      ),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal),
      scaffoldBackgroundColor: const Color(0xff1c313a),
      primaryColorDark: const Color(0xff718792),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Color(0xff718792),
      ),
    );
  }

  void toggle() {
    if (_mode == ThemeMode.light) {
      _mode = ThemeMode.dark;
      _preferences.darkMode(true);
    } else {
      _mode = ThemeMode.light;
      _preferences.darkMode(false);
    }
    notify();
  }
}

final themeProvider = SimpleProvider(
  (_) => ThemeController(),
  autoDispose: false,
);
