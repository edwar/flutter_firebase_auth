import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/custom_input_field.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/rounded_button.dart';
import 'package:flutter_firebase_auth/app/ui/pages/reset_password/reset_password_page.dart';
import 'package:flutter_firebase_auth/app/ui/pages/reset_password/utils/send_reset_password_form.dart';
import 'package:flutter_meedu/screen_utils.dart';
import 'package:flutter_svg/svg.dart';

class ResetPasswordForm extends StatelessWidget {
  ResetPasswordForm({Key? key}) : super(key: key);

  final _controller = resetPasswordProvider.read;

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
                          if (!context.isTablet || context.isPortrait)
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
                            onChanged: _controller.onEmailChange,
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
                              onPressed: () => sendResetPasswordForm(context),
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
    );
  }
}
