import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/app/ui/global_controller/session_controller.dart';
import 'package:flutter_firebase_auth/app/ui/pages/login/controller/login_controller.dart';
import 'package:flutter_firebase_auth/app/ui/utils/colors.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/meedu.dart';

import 'widgets/login_form.dart';

final loginProvider = SimpleProvider(
  (_) => LoginController(sessionProvider.read),
);

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<LoginController>(
      provider: loginProvider,
      builder: (_, controller) {
        return Scaffold(
          body: OrientationBuilder(
            builder: (_, Orientation orientation) {
              if (orientation == Orientation.portrait) {
                return LoginForm();
              }
              return Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: context.isDarkMode
                          ? primaryDarkColor
                          : primaryLightColor,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: LoginForm(),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
