import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/app/domain/responses/sign_up_response.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/dialogs/prograss_dialog.dart';
import 'package:flutter_firebase_auth/app/ui/routes/routes.dart';
import 'package:flutter_meedu/router.dart' as router;
import '../register_page.dart' show registerProvider;

Future<void> sendRegisterForm(BuildContext context) async {
  final controller = registerProvider.read;
  final isValidForm = controller.formKey.currentState!.validate();

  if (isValidForm) {
    ProgreassDialogs.show(context);
    final response = await controller.submit();
    router.pop();
    if (response.error != null) {
      late String content;
      switch (response.error) {
        case SignUpError.networkRequestFailed:
          content = 'network request failed';
          break;
        case SignUpError.emailAlreadyInUse:
          content = 'email already in use';
          break;
        case SignUpError.weakPassword:
          content = 'weak password';
          break;
        case SignUpError.unknow:
        default:
          content = 'unknow error';
          break;
      }
      Dialogs.alert(context, title: 'ERROR', content: content);
    } else {
      router.pushNamedAndRemoveUntil(Routes.HOME);
    }
  } else {
    Dialogs.alert(
      context,
      title: 'ERRROR',
      content: 'Invalid fields',
    );
  }
}
