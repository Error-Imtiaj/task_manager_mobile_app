import 'package:get/get.dart';
import 'package:task_manager_mobile_app/UI/screens/login_screen.dart';
import 'package:task_manager_mobile_app/UI/screens/navigation_screen.dart';
import 'package:task_manager_mobile_app/UI/screens/onboarding_screen.dart';
import 'package:task_manager_mobile_app/auth/auth.dart';

class SplashScreenController extends GetxController {
  Future<void> moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    await Auth.getToken();
    await Auth.getOnboard();
    if (Auth.isLoggedIn()) {
      await Auth.getUserDataCache();
      Get.offNamed(NavigationScreen.text);
    } else {
      if (Auth.onboarding ?? true) {
        await Auth.setOnboard(false);
        Get.offNamed(OnboardingScreen.text);
      } else {
        Get.offNamed(LoginScreen.text);
      }
    }
  }
}
