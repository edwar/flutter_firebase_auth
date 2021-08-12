import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/custom_input_field.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/rounded_button.dart';
import 'package:flutter_firebase_auth/app/ui/pages/login/login_page.dart';
import 'package:flutter_firebase_auth/app/ui/pages/login/utils/send_login_form.dart';
import 'package:flutter_firebase_auth/app/ui/pages/login/widgets/social_buttons.dart';
import 'package:flutter_firebase_auth/app/ui/routes/routes.dart';
import 'package:flutter_firebase_auth/app/utils/email_validator.dart';
import 'package:flutter_meedu/screen_utils.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_meedu/router.dart' as router;

class LoginForm extends StatelessWidget {
  LoginForm({
    Key? key,
  }) : super(key: key);

  final _controller = loginProvider.read;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final padding = context.mediaQueryPadding;
    final height = context.height - padding.top - padding.bottom;
    return ListView(
      children: [
        SizedBox(
          height: height,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _controller.formKey,
                child: Align(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 360,
                    ),
                    child: Column(
                      mainAxisAlignment: context.isTablet
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.spaceAround,
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: SvgPicture.asset(
                            'assets/images/${isDark ? "dark" : "light"}/login.svg',
                          ),
                        ),
                        if (context.isTablet) const SizedBox(height: 20),
                        Column(
                          children: [
                            CustomInputField(
                              label: 'Email',
                              onChanged: _controller.onEmailChange,
                              inputType: TextInputType.emailAddress,
                              validator: (text) {
                                if (isValidEmail(text!)) {
                                  return null;
                                }
                                return 'Invalid email';
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomInputField(
                              label: 'Password',
                              onChanged: _controller.onPasswordChange,
                              isPassword: true,
                              validator: (text) {
                                if (text!.trim().length >= 6) {
                                  return null;
                                }
                                return 'Password invalid';
                              },
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () =>
                                      router.pushNamed(Routes.RESET_PASSWORD),
                                  child: const Text('Forgot password?'),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                RoundedButton(
                                  text: 'Sign In',
                                  onPressed: () => sendLoginForm(context),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account?",
                                ),
                                TextButton(
                                  onPressed: () {
                                    router.pushNamed(Routes.REGISTER);
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            const Text('Or sign in with'),
                            const SizedBox(height: 10),
                            const SocialButtons(),
                            if (!context.isTablet) const SizedBox(height: 30),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
