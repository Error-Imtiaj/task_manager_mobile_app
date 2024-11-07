class Urls {
  static const String _baseurl = 'http://35.73.30.144:2005/api/v1';

  static const String registrationUrl = '$_baseurl/Registration';
  static const String signInUrl = '$_baseurl/Login';
  static const String sendOtpToEmailUrl = '$_baseurl/RecoverVerifyEmail';
  static const String pinVerifyUrl = '$_baseurl/RecoverVerifyOtp';
  static const String setPassUrl = '$_baseurl/RecoverResetPassword';

  static const String createTaskUrl = '$_baseurl/createTask';
  static const String newTaskUrl = '$_baseurl/listTaskByStatus/New';
  static const String completedTaskUrl = '$_baseurl/listTaskByStatus/Completed';
  static const String canceledTaskUrl = '$_baseurl/listTaskByStatus/Canceled';
  static const String progressTaskUrl = '$_baseurl/listTaskByStatus/Progress';
  static const String deleteTaskUrl = '$_baseurl/deleteTask';
}
