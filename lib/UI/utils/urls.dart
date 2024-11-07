class Urls {
  static const String _baseurl = 'http://35.73.30.144:2005/api/v1';

  static const String registrationUrl = '$_baseurl/Registration';
  static const String signInUrl = '$_baseurl/Login';
  static const String sendOtpToEmailUrl = '$_baseurl/RecoverVerifyEmail';
  static const String pinVerifyUrl = '$_baseurl/RecoverVerifyOtp';
  static const String setPassUrl = '$_baseurl/RecoverResetPassword';



  static const String createTaskUrl = '$_baseurl/createTask';


}
