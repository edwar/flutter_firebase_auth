import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_auth/app/ui/global_controller/session_controller.dart';
import 'package:flutter_firebase_auth/app/ui/pages/splash/splash_controller.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/router.dart' as router;

final splashProvider = SimpleProvider(
  (_) => SplashController(sessionProvider.read),
);

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<SplashController>(
      provider: splashProvider,
      onAfterFirstLayout: (_, __) {
        if (!context.isTablet) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
        }
      },
      onChange: (_, controller) {
        final routeName = controller.routeName;
        if (routeName != null) {
          Future.delayed(const Duration(milliseconds: 1200), () {
            router.pushReplacementNamed(routeName);
          });
        }
      },
      builder: (_, __) {
        return Scaffold(
          backgroundColor: const Color(0xFF1D232D),
          body: Center(
            child: Image.asset("assets/loading.gif"),
          ),
        );
      },
    );
  }
}
