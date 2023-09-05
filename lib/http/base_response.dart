import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

/// Time: 2023/9/4/0004 on 16:49
/// User: Jerry
/// Description: 根据服务器接口返回格式统一标准BaseResponse
/// 1、一次性代码生成
/// 通过在项目根目录运行命令 flutter pub run build_runner build --delete-conflicting-outputs，
/// 你可以在任何需要的时候为你的模型生成 JSON 序列化数据代码。这会触发一次构建，遍历源文件，选择相关的文件，
/// 然后为它们生成必须的序列化数据代码。 虽然这样很方便，但是如果你不需要在每次修改了你的模型类后都要手动构建那将会很棒。
/// 2、持续生成代码
/// 监听器 让我们的源代码生成过程更加方便。它会监听我们项目中的文件变化，并且会在需要的时候自动构建必要的文件。
/// 你可以在项目根目录运行 flutter pub run build_runner watch 启动监听。
/// 启动监听并让它留在后台运行是安全的。

/// 一个注释，用于代码生成器，使其知道该类需要生成JSON序列化逻辑
@JsonSerializable(genericArgumentFactories: true)
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

  /// 从映射创建新BaseResponse实例所需的工厂构造函数。将映射传递给生成的' _BaseResponseFromJson() '构造函数。
  /// 构造函数以源类命名，在本例中为BaseResponse。
  // factory BaseResponse.fromJson(Map<String,dynamic> json) =>
  //     _$BaseResponseFromJson(json);

// factory BaseResponse.fromJson(Map<String, dynamic> json) =>
//     _$BaseResponseFromJson(json);

//factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);



//  /// ' toJson '是类声明支持序列化为JSON的约定。该实现仅仅调用私有的、生成的助手方法' _BaseResponseToJson '。
// Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
//Map<String, dynamic> toJson() => _$UserToJson(this);
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
