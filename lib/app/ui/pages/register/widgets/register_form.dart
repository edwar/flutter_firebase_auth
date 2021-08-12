import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/custom_input_field.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/rounded_button.dart';
import 'package:flutter_firebase_auth/app/ui/pages/register/utils/send_register_form.dart';
import 'package:flutter_firebase_auth/app/utils/email_validator.dart';
import 'package:flutter_firebase_auth/app/utils/name_validator.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/screen_utils.dart';
import 'package:flutter_svg/svg.dart';

import '../register_page.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm({
    Key? key,
  }) : super(key: key);

  final _controller = registerProvider.read;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final appBar = AppBar();
    final padding = context.mediaQueryPadding;
    final height = context.height -
        padding.top -
        padding.bottom -
        appBar.preferredSize.height;
    return ListView(
      children: [
        SizedBox(
          height: height,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(15),
              child: Align(
                child: Form(
                  key: _controller.formKey,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 360,
                    ),
                    child: Column(
                      mainAxisAlignment: context.isTablet
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            if (!context.isTablet || context.isPortrait)
                              AspectRatio(
                                aspectRatio: 16 / 9,
                                child: SvgPicture.asset(
                                  'assets/images/${isDark ? "dark" : "light"}/register.svg',
                                ),
                              ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Center(
                              child: Text(
                                'Sign Up',
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
                              label: 'Name',
                              onChanged: _controller.onNameChanged,
                              validator: (text) {
                                return isValidName(text!)
                                    ? null
                                    : 'Invalid name';
                              },
                            ),
                            const SizedBox(height: 15),
                            CustomInputField(
                              label: 'Last Name',
                              onChanged: _controller.onLastnameChanged,
                              validator: (text) {
                                return isValidName(text!)
                                    ? null
                                    : 'Invalid name';
                              },
                            ),
                            const SizedBox(height: 15),
                            CustomInputField(
                              label: 'Email',
                              inputType: TextInputType.emailAddress,
                              onChanged: _controller.onEmailChanged,
                              validator: (text) {
                                return isValidEmail(text!)
                                    ? null
                                    : 'Invalid email';
                              },
                            ),
                            const SizedBox(height: 15),
                            CustomInputField(
                              label: 'Password',
                              onChanged: _controller.onPasswordChanged,
                              isPassword: true,
                              validator: (text) {
                                if (text!.trim().length >= 6) {
                                  return null;
                                }
                                return 'Invalid password';
                              },
                            ),
                            const SizedBox(height: 15),
                            Consumer(
                              builder: (_, watch, __) {
                                watch(
                                  registerProvider.select(
                                    (_) => _.password,
                                  ),
                                );
                                return CustomInputField(
                                  label: 'Verification password',
                                  onChanged: _controller.onVPasswordChanged,
                                  isPassword: true,
                                  validator: (text) {
                                    if (_controller.state.password != text) {
                                      return "Password don't match";
                                    }
                                    if (text!.trim().length >= 6) {
                                      return null;
                                    }
                                    return 'Invalid password';
                                  },
                                );
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            RoundedButton(
                              text: 'REGISTER',
                              onPressed: () => sendRegisterForm(context),
                            ),
                            if (!context.isTablet)
                              const SizedBox(
                                height: 30,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
