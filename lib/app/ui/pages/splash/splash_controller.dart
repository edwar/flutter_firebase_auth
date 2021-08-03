import 'package:flutter_firebase_auth/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_firebase_auth/app/ui/global_controller/session_controller.dart';
import 'package:flutter_firebase_auth/app/ui/routes/routes.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class SplashController extends SimpleNotifier {
  final SessionControler _sessionControler;
  final AuthenticationRepository _authRepository = Get.i.find();

  String? _routeName;
  String? get routeName => _routeName;

  SplashController(this._sessionControler) {
    _init();
  }

  _init() async {
    final user = await _authRepository.user;
    if (user != null) {
      _routeName = Routes.HOME;
      _sessionControler.setUser(user);
    } else {
      _routeName = Routes.LOGIN;
    }
    notify();
  }
}
