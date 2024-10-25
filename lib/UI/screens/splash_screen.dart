import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager_mobile_app/UI/screens/login_screen.dart';
import 'package:task_manager_mobile_app/UI/screens/navigation_screen.dart';
import 'package:task_manager_mobile_app/UI/screens/new_task_screens.dart';
import 'package:task_manager_mobile_app/UI/screens/onboarding_screen.dart';
import 'package:task_manager_mobile_app/UI/utils/assetPath.dart';
import 'package:task_manager_mobile_app/UI/utils/colors.dart';
import 'package:task_manager_mobile_app/auth/auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    await Auth.getToken();
    await Auth.getOnboard();
    if (Auth.isLoggedIn()) {
      Auth.getUserDataCache();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const NavigationScreen()));
    } else {
      if (Auth.onboarding ?? true) {
        await Auth.setOnboard(false);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const OnboardingScreen()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    }
  }

  @override
  void initState() {
    _moveToNextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.backGroundColor,
      body: Center(
        child: SvgPicture.asset(
          Assetpath.splashSvg,
          height: 600,
          width: 400,
        ),
      ),
    );
  }
}
