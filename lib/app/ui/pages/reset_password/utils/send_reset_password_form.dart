import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/dialogs/prograss_dialog.dart';
import 'package:flutter_firebase_auth/app/utils/email_validator.dart';

import '../reset_password_page.dart';

void sendResetPasswordForm(BuildContext context) async {
  final controller = resetPasswordProvider.read;

  if (isValidEmail(controller.email)) {
    ProgreassDialogs.show(context);

    Navigator.pop(context);
  } else {
    Dialogs.alert(context, content: 'Invalid email');
  }
}
