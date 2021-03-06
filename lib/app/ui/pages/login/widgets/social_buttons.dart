import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/app/ui/icons/social_icons.dart';
import 'package:flutter_firebase_auth/app/ui/pages/login/utils/sign_in_with_facebook.dart';
import 'package:flutter_firebase_auth/app/ui/pages/login/utils/sign_in_with_google.dart';

import 'social_button.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialButton(
          onPressed: () => signInWithFacebook(context),
          iconData: SocialIcons.facebook,
          color: Colors.blueAccent,
        ),
        const SizedBox(
          width: 15,
        ),
        SocialButton(
          onPressed: () => signInWithGoogle(context),
          iconData: SocialIcons.google,
          color: Colors.redAccent,
        ),
        const SizedBox(
          width: 15,
        ),
        SocialButton(
          onPressed: () {},
          iconData: SocialIcons.apple,
          color: Colors.black,
        ),
      ],
    );
  }
}
