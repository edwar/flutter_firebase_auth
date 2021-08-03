import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/app/domain/responses/sign_in_response.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/dialogs/prograss_dialog.dart';
import 'package:flutter_firebase_auth/app/ui/pages/login/login_page.dart';
import 'package:flutter_firebase_auth/app/ui/routes/routes.dart';
import 'package:flutter_meedu/router.dart' as router;

Future<void> sendLoginForm(BuildContext context) async {
  final controller = loginProvider.read;
  final isValidForm = controller.formKey.currentState!.validate();
  if (isValidForm) {
    ProgreassDialogs.show(context);
    final response = await controller.submit();
    router.pop();
    if (response.error != null) {
      late String errorMessage;
      switch (response.error) {
        case SignInError.networkRequestFailed:
          errorMessage = 'network request failed';
          break;
        case SignInError.userDisabled:
          errorMessage = 'user disabled';
          break;
        case SignInError.userNotFound:
          errorMessage = 'user not found';
          break;
        case SignInError.wrongPassword:
          errorMessage = 'wrong password';
          break;
        case SignInError.unknown:
        default:
          errorMessage = 'unknown error';
          break;
      }
      Dialogs.alert(
        context,
        title: 'ERROR',
        content: errorMessage,
      );
    } else {
      router.pushReplacementNamed(Routes.HOME);
    }
  }
}
