import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/app/ui/global_controller/theme_controller.dart';

extension DarkModeExtension on BuildContext {
  bool get isDarkMode {
    return themeProvider.read.isDark;
  }
}
