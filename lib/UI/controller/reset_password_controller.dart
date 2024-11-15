import 'package:get/get.dart';
import 'package:task_manager_mobile_app/UI/utils/urls.dart';
import 'package:task_manager_mobile_app/data/model/network_response.dart';
import 'package:task_manager_mobile_app/data/services/network_caller.dart';

class ResetPasswordController extends GetxController {
  bool isLoading = false;
  late dynamic message;

  Future<bool> sendVerificationMail(String email) async {
    bool sentMail = false;
    isLoading = true;

    update();
    try {
      NetworkModel sendMailResponse = await NetworkCaller.getRequest(
        url: '${Urls.sendOtpToEmailUrl}/${email.trim()}',
      );
      isLoading = false;
      update();
      if (sendMailResponse.statusCode == 200) {
        sentMail = true;
        message = sendMailResponse.message;
        return sentMail;
      } else {
        message = sendMailResponse.errorMessage;
        return sentMail;
      }
    } catch (e) {
      isLoading = false;
      message = e.toString;
      update();
      return sentMail;
    }
  }
}
