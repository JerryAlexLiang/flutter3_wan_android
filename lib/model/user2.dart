import 'package:json_annotation/json_annotation.dart';

part 'user2.g.dart';

@JsonSerializable()
class User2 {
  String name;
  String email;

  User2(this.name, this.email);

  /// 从映射创建新BaseResponse实例所需的工厂构造函数。将映射传递给生成的' _BaseResponseFromJson() '构造函数。
  /// 构造函数以源类命名，在本例中为BaseResponse。
  factory User2.fromJson(Map<String, dynamic> json) => _$User2FromJson(json);

  /// ' toJson '是类声明支持序列化为JSON的约定。该实现仅仅调用私有的、生成的助手方法' _BaseResponseToJson '。
  Map<String, dynamic> toJson() => _$User2ToJson(this);
}
