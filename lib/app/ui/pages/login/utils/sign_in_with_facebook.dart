import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/dialogs/prograss_dialog.dart';
import 'package:flutter_firebase_auth/app/ui/pages/login/login_page.dart';

import 'handle_login_form.dart';

void signInWithFacebook(BuildContext context) async {
  ProgreassDialogs.show(context);
  final controller = loginProvider.read;
  final response = await controller.signInWithFacebook();
  Navigator.pop(context);
  handleLoginResponse(context, response);
}
