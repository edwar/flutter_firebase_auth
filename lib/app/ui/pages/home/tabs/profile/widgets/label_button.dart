import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/app/ui/global_controller/theme_controller.dart';
import 'package:flutter_meedu/state.dart';

class LabelButton extends ConsumerWidget {
  final String label, value;
  final VoidCallback? onPressed;
  const LabelButton({
    Key? key,
    required this.label,
    required this.value,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final isDark = watch(themeProvider).isDark;
    final iconColor = isDark ? Colors.white70 : Colors.black45;
    return MaterialButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              if (onPressed != null)
                Icon(
                  Icons.chevron_right_rounded,
                  size: 22,
                  color: iconColor,
                )
            ],
          ),
        ],
      ),
    );
  }
}
