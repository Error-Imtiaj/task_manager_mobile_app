import 'package:get/get.dart';
import 'package:task_manager_mobile_app/UI/controller/profile_update_controller.dart';
import 'package:task_manager_mobile_app/UI/controller/set_password_controller.dart';
import 'package:task_manager_mobile_app/UI/controller/signin_controller.dart';
import 'package:task_manager_mobile_app/UI/controller/signup_controller.dart';
import 'package:task_manager_mobile_app/UI/controller/splash_screen_controller.dart';

class ControllerBinders extends Bindings {
  @override
  void dependencies() {
    Get.put(SignupController());
    Get.put(SigninController());
    Get.put(ProfileUpdateController());
    Get.put(SplashScreenController());
    Get.put(SetPasswordController());
  }
}
