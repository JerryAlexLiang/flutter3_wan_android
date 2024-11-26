import 'package:dio/dio.dart';

class HandleDioError {
  static ResultException handleError(DioError dioError) {
    int code = 9999;
    String message = "未知错误";
    switch (dioError.type) {
      // case DioErrorType.connectionTimeout:
      case DioExceptionType.connectionTimeout:
        code = 9000;
        message = "网络连接超时，请检查网络设置";
        break;
      case DioExceptionType.receiveTimeout:
        code = 90001;
        message = "服务器异常，请稍后重试";
        break;
      case DioExceptionType.sendTimeout:
        code = 90002;
        message = "网络连接超时，请检查网络设置";
        break;
      case DioExceptionType.badResponse:
        code = 90003;
        message = "服务器异常，请稍后重试";
        break;
      case DioExceptionType.cancel:
        code = 90004;
        message = "请求已被取消，请重新请求";
        break;
      case DioExceptionType.unknown:
        code = 90005;
        message = "网络异常，请检查你的网络";
        break;
      case DioExceptionType.badCertificate:
        // TODO: Handle this case.
      case DioExceptionType.connectionError:
        // TODO: Handle this case.
    }
    return ResultException(code, message);
  }
}

class ResultException {
  final int? code;
  final String message;

  ResultException(this.code, this.message);
}
