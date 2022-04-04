///**Handling exceptions separately.**

///For exceptions in app.
class AppException implements Exception {
  AppException({
    this.message = 'Something went wrong',
    this.response,
    this.statusCode,
  });

  final String? message;
  final dynamic response;
  final int? statusCode;
}

///For server side exceptions.
class ServerException extends AppException {
  ServerException({
    String message = 'Something went wrong',
  }) : super(message: message);
}

///For client side exceptions.
class ClientException extends AppException {
  ClientException({String? message, dynamic response, int? statusCode})
      : super(message: message, response: response, statusCode: statusCode);
}

///For http side exceptions.
class HttpException extends AppException {
  HttpException({String? message, int? statusCode})
      : super(message: message, statusCode: statusCode);
}
