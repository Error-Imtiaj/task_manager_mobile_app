import 'package:get/get.dart';
import 'package:task_manager_mobile_app/UI/utils/urls.dart';
import 'package:task_manager_mobile_app/auth/auth.dart';
import 'package:task_manager_mobile_app/data/model/network_response.dart';
import 'package:task_manager_mobile_app/data/services/network_caller.dart';

class SigninController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String password) async {
    _inProgress = true;
    update();
    Map<String, dynamic> body = {"email": email, "password": password};
    final NetworkModel response =
        await NetworkCaller.postRequest(url: Urls.signInUrl, body: body);
    _inProgress = false;
    update();
    if (response.isSuccess) {
      final _fullbody = response.fullBody;
      final myMap = response.message;
      await Auth.setUserDataCache(myMap['email'], myMap['firstName']);
      await Auth.getUserDataCache();
      await Auth.saveToken(_fullbody['token']);
      _isSuccess = true;
    }
    else{
      _errorMessage = response.errorMessage;
    }
    return _isSuccess;
  }
}
