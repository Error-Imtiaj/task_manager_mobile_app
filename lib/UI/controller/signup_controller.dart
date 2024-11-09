import 'package:get/get.dart';
import 'package:task_manager_mobile_app/UI/utils/urls.dart';
import 'package:task_manager_mobile_app/data/model/network_response.dart';
import 'package:task_manager_mobile_app/data/services/network_caller.dart';

class SignupController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signUp(
    String? email,
    String? firstName,
    String? lastName,
    String? mobile,
    String? password,
  ) async {
    _inProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password
    };
    NetworkModel response = await NetworkCaller.postRequest(
        url: Urls.registrationUrl, body: requestBody);
    _inProgress = false;
    update();
    if (response.isSuccess) {
      _isSuccess = true;
    }
    return _isSuccess;
  }
}
