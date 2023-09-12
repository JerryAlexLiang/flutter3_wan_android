import 'package:flutter3_wan_android/http/page_list.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_page_list_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BasePageListResponse<T> {
  int code;
  String message;
  PageList<T> data;

  BasePageListResponse(this.code, this.message, this.data);

  /// 从映射创建新BaseResponse实例所需的工厂构造函数。将映射传递给生成的' _BaseResponseFromJson() '构造函数。
  /// 构造函数以源类命名，在本例中为BaseResponse。
  factory BasePageListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) =>
      _$BasePageListResponseFromJson<T>(json, fromJsonT);

  /// ' toJson '是类声明支持序列化为JSON的约定。该实现仅仅调用私有的、生成的助手方法' _BaseResponseToJson '。
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BasePageListResponseToJson<T>(this, toJsonT);
}
