/// 根据服务器接口返回格式统一标准BaseResponse

// @JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  //消息（例如成功消息文字/错误消息文字）
  String? message;

  bool? success = false;

  //自定义code(可根据内部定义方式)
  int? code;

  //接口返回的数据
  T? data;

  BaseResponse({
    this.message,
    this.success,
    this.code,
    this.data,
  });
}

class BaseResponseCode {
  /// 成功
  static const int success = 0;

  /// 错误
  static const int error = 1;

  /// 更多
}

/// 异常处理
class ErrorEntity implements Exception {
  int? code;
  String? errorMessage;

  ErrorEntity({this.code, this.errorMessage});

  @override
  String toString() {
    if (errorMessage == null) return "Exception";
    return 'ErrorEntity{code: $code, errorMessage: $errorMessage}';
  }
}
