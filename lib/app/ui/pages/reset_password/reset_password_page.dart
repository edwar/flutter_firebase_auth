import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/app/ui/pages/reset_password/widgets/reset_password_form.dart';
import 'package:flutter_firebase_auth/app/ui/utils/colors.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/screen_utils.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_svg/svg.dart';

import 'controller/reset_password_controller.dart';

final resetPasswordProvider = SimpleProvider(
  (_) => ResetPasswordController(),
);

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return ProviderListener<ResetPasswordController>(
      provider: resetPasswordProvider,
      builder: (_, controller) => Scaffold(
        appBar: AppBar(),
        body: OrientationBuilder(
          builder: (_, Orientation orientation) {
            if (orientation == Orientation.portrait) {
              return ResetPasswordForm();
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
                          'assets/images/${isDark ? "light" : "dark"}/forgot_password.svg',
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ResetPasswordForm(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
