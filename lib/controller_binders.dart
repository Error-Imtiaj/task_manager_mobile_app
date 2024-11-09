import 'package:get/get.dart';
import 'package:task_manager_mobile_app/UI/controller/signup_controller.dart';

class ControllerBinders extends Bindings {
  @override
  void dependencies() {
    Get.put(SignupController());
  }
}
