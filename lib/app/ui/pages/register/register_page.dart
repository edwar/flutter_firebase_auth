import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/app/ui/global_controller/session_controller.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/custom_input_field.dart';
import 'package:flutter_firebase_auth/app/ui/pages/register/utils/send_register_form.dart';
import 'package:flutter_firebase_auth/app/utils/email_validator.dart';
import 'package:flutter_firebase_auth/app/utils/name_validator.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_svg/svg.dart';

import 'controller/register_controller.dart';
import 'controller/register_state.dart';
import 'package:flutter_meedu/screen_utils.dart';

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
          appBar: AppBar(),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(15),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset(
                      'assets/images/${isDark ? "dark" : "light"}/register.svg',
                      width: 300,
                    ),
                    Column(
                      children: [
                        CustomInputField(
                          label: 'Name',
                          onChanged: controller.onNameChanged,
                          validator: (text) {
                            return isValidName(text!) ? null : 'Invalid name';
                          },
                        ),
                        const SizedBox(height: 15),
                        CustomInputField(
                          label: 'Last Name',
                          onChanged: controller.onLastnameChanged,
                          validator: (text) {
                            return isValidName(text!) ? null : 'Invalid name';
                          },
                        ),
                        const SizedBox(height: 15),
                        CustomInputField(
                          label: 'Email',
                          inputType: TextInputType.emailAddress,
                          onChanged: controller.onEmailChanged,
                          validator: (text) {
                            return isValidEmail(text!) ? null : 'Invalid email';
                          },
                        ),
                        const SizedBox(height: 15),
                        CustomInputField(
                          label: 'Password',
                          onChanged: controller.onPasswordChanged,
                          isPassword: true,
                          validator: (text) {
                            if (text!.trim().length >= 6) return null;
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
                              onChanged: controller.onVPasswordChanged,
                              isPassword: true,
                              validator: (text) {
                                if (controller.state.password != text) {
                                  return "Password don't match";
                                }
                                if (text!.trim().length >= 6) return null;
                                return 'Invalid password';
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          child: const Text('REGISTER'),
                          onPressed: () => sendRegisterForm(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
