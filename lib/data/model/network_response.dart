class NetworkModel {
  final int statusCode;
  final bool isSuccess;
  dynamic message;
  dynamic fullBody;
  String errorMessage;

  NetworkModel({
    required this.statusCode,
    required this.isSuccess,
    this.fullBody,
    this.message,
    this.errorMessage = 'Something went wrong',
  });
}
