import 'package:get/get.dart';
import 'package:task_manager_mobile_app/UI/utils/urls.dart';
import 'package:task_manager_mobile_app/auth/auth.dart';
import 'package:task_manager_mobile_app/data/model/network_response.dart';
import 'package:task_manager_mobile_app/data/services/network_caller.dart';

class ProfileUpdateController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> updateProfile(
    String email,
    String firstName,
    String lastName,
    String mobile,
    String password,
  ) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> data = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
    };
    Map<String, String> head = {
      'Content-Type': 'application/json',
      'token': Auth.myToken.toString()
    };

    NetworkModel response = await NetworkCaller.postRequest(
        url: Urls.profileUpdateUrl, header: head);
    _inProgress = false;
    update();
    if (response.isSuccess) {
      isSuccess = true;
      await Auth.clearUserData();
      Auth.setUserDataCache(email, firstName);
      update();
    } else {
      _errorMessage = response.errorMessage;
    }
    return isSuccess;
  }
}
