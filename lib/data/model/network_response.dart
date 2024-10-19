class NetworkModel {
  final int statusCode;
  final bool isSuccess;
  dynamic? message;
  String errorMessage;

  NetworkModel({
    required this.statusCode,
    required this.isSuccess,
    this.message,
    this.errorMessage = 'Something went wrong',
  });
}
