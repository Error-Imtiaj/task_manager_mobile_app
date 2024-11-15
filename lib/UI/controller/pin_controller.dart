import 'package:get/get.dart';
import 'package:task_manager_mobile_app/UI/utils/urls.dart';
import 'package:task_manager_mobile_app/data/model/network_response.dart';
import 'package:task_manager_mobile_app/data/services/network_caller.dart';

class PinControllerGet extends GetxController {
  bool resendAgain = false;
  String? message;
  bool successMail = false;
  bool pinVerificationSucces = false;
  bool inprogressPinVerify = false;

  Future<bool> sendVerificationMail(String email) async {
    // LOADING START
    resendAgain = true;
    update();
    try {
      NetworkModel sendMailResponse = await NetworkCaller.getRequest(
        url: '${Urls.sendOtpToEmailUrl}/${email}',
      );
      // LOADING END
      resendAgain = false;
      update();
      if (sendMailResponse.statusCode == 200) {
        message = sendMailResponse.message;
        resendAgain = false;
        successMail = true;
        update();
        return successMail;
      } else {
        message = sendMailResponse.errorMessage;
      }
    } catch (e) {
      // LOADING END
      resendAgain = false;
      update();
      message = e.toString();
    }
    return successMail;
  }

  Future<bool> pinVerification(String email, String pin) async {
    // LOADING START
    inprogressPinVerify = true;
    update();

    try {
      NetworkModel pinVerifycall = await NetworkCaller.getRequest(
        url: '${Urls.pinVerifyUrl}/${email}/${pin}',
      );
      // LOADING END
      inprogressPinVerify = false;
      update();
      if (pinVerifycall.statusCode == 200) {
        message = pinVerifycall.message;
        pinVerificationSucces = true;
        inprogressPinVerify = false;
        update();
        return pinVerificationSucces;
      } else {
        message = pinVerifycall.errorMessage;
      }
    } catch (e) {
      // LOADING END
      inprogressPinVerify = false;
      update();
      // SHOW THE ERROR
      message = e.toString();
    }
    return pinVerificationSucces;
  }
}
