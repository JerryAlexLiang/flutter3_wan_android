import 'package:json_annotation/json_annotation.dart';

part 'user2.g.dart';

@JsonSerializable()
class User2 {
  String name;
  String email;

  User2(this.name, this.email);

  factory User2.fromJson(Map<String, dynamic> json) => _$User2FromJson(json);

  Map<String, dynamic> toJson() => _$User2ToJson(this);
}
