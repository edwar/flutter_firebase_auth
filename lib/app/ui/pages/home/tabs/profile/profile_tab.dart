import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/app/ui/global_controller/session_controller.dart';
import 'package:flutter_firebase_auth/app/ui/global_controller/theme_controller.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/dialogs/prograss_dialog.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/dialogs/show_input_dialog.dart';
import 'package:flutter_firebase_auth/app/ui/pages/home/tabs/profile/widgets/label_button.dart';
import 'package:flutter_firebase_auth/app/ui/routes/routes.dart';
import 'package:flutter_firebase_auth/app/ui/utils/colors.dart';
import 'package:flutter_meedu/state.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:flutter_meedu/screen_utils.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({Key? key}) : super(key: key);

  void _updateDisplayName(BuildContext context) async {
    final sessionController = sessionProvider.read;
    final value = await showInputDialog(
      context,
      initialValue: sessionController.user!.displayName ?? '',
    );
    if (value != null) {
      ProgreassDialogs.show(context);
      final user = await sessionController.updateDisplayName(value);
      Navigator.pop(context);
      if (user == null) {
        Dialogs.alert(
          context,
          title: 'ERROR',
          content: 'Check your internet connection',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, watch) {
    final isDark = context.isDarkMode;
    final sessionControler = watch(sessionProvider);
    final user = sessionControler.user!;
    final displayName = user.displayName ?? '';
    final letter = displayName.isNotEmpty ? displayName[0] : '';
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 75,
                    child: user.photoURL == null
                        ? Text(
                            letter,
                            style: const TextStyle(fontSize: 85),
                          )
                        : null,
                    backgroundImage: user.photoURL != null
                        ? NetworkImage(user.photoURL!)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xff1c313a) : Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: isDark ? Colors.white : Colors.black12,
                        radius: 30,
                        child: IconButton(
                          icon: Icon(
                            Icons.camera_alt_outlined,
                            size: 23,
                            color: isDark ? Colors.black26 : Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                displayName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(child: Text(user.email ?? '')),
            const SizedBox(height: 50),
            // const Text('User data'),
            LabelButton(
              label: 'Display name',
              value: displayName,
              onPressed: () => _updateDisplayName(context),
            ),
            LabelButton(
              label: 'Email',
              value: user.email ?? '',
            ),
            LabelButton(
              label: 'Email verified',
              value: user.emailVerified ? 'YES' : 'NO',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Dark mode'),
                  CupertinoSwitch(
                    value: isDark,
                    activeColor: isDark ? primaryDarkColor : Colors.blue,
                    onChanged: (_) {
                      themeProvider.read.toggle();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        LabelButton(
          label: 'Sing Out',
          value: '',
          onPressed: () async {
            ProgreassDialogs.show(context);
            await sessionProvider.read.signOut();
            router.pushNamedAndRemoveUntil(Routes.LOGIN);
          },
        ),
      ],
    );
  }
}
