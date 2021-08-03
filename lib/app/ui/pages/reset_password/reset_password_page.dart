import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/custom_input_field.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/dialogs/prograss_dialog.dart';
import 'package:flutter_firebase_auth/app/utils/email_validator.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

import 'package:flutter_meedu/meedu.dart';

import 'controller/reset_password_controller.dart';

final resetPasswordProvider = SimpleProvider(
  (_) => ResetPasswordController(),
);

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<ResetPasswordController>(
      provider: resetPasswordProvider,
      builder: (_, controller) => Scaffold(
        appBar: AppBar(
          title: const Text('Reset password'),
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomInputField(
                    label: 'Email',
                    onChanged: controller.onEmailChange,
                    inputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () => _submit(context),
                    child: const Text('Send'),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
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
