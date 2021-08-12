import 'package:flutter/widgets.dart' show GlobalKey, FormState;
import 'package:flutter_firebase_auth/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_firebase_auth/app/domain/responses/sign_in_response.dart';
import 'package:flutter_firebase_auth/app/ui/global_controller/session_controller.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class LoginController extends SimpleNotifier {
  final SessionControler _sessionControler;
  String _email = '', _password = '';
  final AuthenticationRepository _authenticationRepository = Get.i.find();

  final GlobalKey<FormState> formKey = GlobalKey();

  LoginController(this._sessionControler);

  void onEmailChange(String text) {
    _email = text;
  }

  void onPasswordChange(String text) {
    _password = text;
  }

  Future<SignInResponse> signInWithEmailAndPassword() async {
    final response = await _authenticationRepository.signInWithEmailAndPassword(
      _email,
      _password,
    );
    if (response.error == null) {
      _sessionControler.setUser(response.user!);
    }
    return response;
  }

  Future<SignInResponse> signInWithGoogle() async {
    final response = await _authenticationRepository.signInWithGoogle();
    if (response.error == null) {
      _sessionControler.setUser(response.user!);
    }
    return response;
  }
}
