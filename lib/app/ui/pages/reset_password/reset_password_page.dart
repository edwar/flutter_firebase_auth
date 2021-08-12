import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/custom_input_field.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/dialogs/prograss_dialog.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/rounded_button.dart';
import 'package:flutter_firebase_auth/app/utils/email_validator.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

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
    final appBar = AppBar();
    final padding = context.mediaQueryPadding;
    final height = context.height -
        padding.top -
        padding.bottom -
        appBar.preferredSize.height;

    return ProviderListener<ResetPasswordController>(
      provider: resetPasswordProvider,
      builder: (_, controller) => Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            SizedBox(
              height: height,
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Align(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 360,
                      ),
                      child: Column(
                        mainAxisAlignment: context.isTablet
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              AspectRatio(
                                aspectRatio: 16 / 9,
                                child: SvgPicture.asset(
                                  'assets/images/${isDark ? "dark" : "light"}/forgot_password.svg',
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Center(
                                child: Text(
                                  'Reset password',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              CustomInputField(
                                label: 'Email',
                                onChanged: controller.onEmailChange,
                                inputType: TextInputType.emailAddress,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'Enter your email to recive a link to change your password',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: RoundedButton(
                                  onPressed: () => _submit(context),
                                  text: 'SEND',
                                ),
                              ),
                              const SizedBox(height: 30),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _submit(BuildContext context) async {
    final controller = resetPasswordProvider.read;

    if (isValidEmail(controller.email)) {
      ProgreassDialogs.show(context);

      Navigator.pop(context);
    } else {
      Dialogs.alert(context, content: 'Invalid email');
    }
  }
}
