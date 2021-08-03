import 'package:flutter_meedu/flutter_meedu.dart';

class ResetPasswordController extends SimpleNotifier {
  String _email = '';

  String get email => _email;

  void onEmailChange(String text) {
    _email = text;
  }
}
