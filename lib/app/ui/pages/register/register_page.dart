import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/app/ui/global_controller/session_controller.dart';
import 'package:flutter_firebase_auth/app/ui/utils/colors.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_svg/svg.dart';

import 'controller/register_controller.dart';
import 'controller/register_state.dart';

import 'widgets/register_form.dart';

final registerProvider = StateProvider<RegisterController, RegisterState>(
  (_) => RegisterController(sessionProvider.read),
);

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return ProviderListener<RegisterController>(
      provider: registerProvider,
      builder: (_, controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: isDark ? primaryDarkColor : primaryLightColor,
          ),
          body: OrientationBuilder(
            builder: (_, Orientation orientation) {
              if (orientation == Orientation.portrait) {
                return RegisterForm();
              }
              return Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: double.infinity,
                      color: context.isDarkMode
                          ? primaryDarkColor
                          : primaryLightColor,
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: SvgPicture.asset(
                            'assets/images/${isDark ? "light" : "dark"}/register.svg',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: RegisterForm(),
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
