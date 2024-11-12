import 'package:get/get.dart';
import 'package:task_manager_mobile_app/UI/utils/urls.dart';
import 'package:task_manager_mobile_app/data/model/network_response.dart';
import 'package:task_manager_mobile_app/data/services/network_caller.dart';

class SetPasswordController extends GetxController {
  bool? isLoading;
  String? messsage;
  Future<bool> setPassword(String? email, String? otp, String password) async {
    try {
      isLoading = true;
      update();
      Map<String, dynamic> body = {
        "email": email,
        "OTP": otp,
        "password": password,
      };
      NetworkModel setPasswordResponse = await NetworkCaller.postRequest(
        url: Urls.setPassUrl,
        body: body,
      );
      isLoading = false;
      update();
      if (setPasswordResponse.statusCode == 200) {
        messsage = setPasswordResponse.message;
        return true;
      } else {
        messsage = setPasswordResponse.errorMessage;
        return false;
      }
    } catch (e) {
      isLoading = false;
      update();
      messsage = e.toString();
      return false;
    }
  }
}
