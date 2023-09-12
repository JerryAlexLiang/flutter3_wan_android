import 'package:json_annotation/json_annotation.dart';

part 'base_list_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseListResponse<T> {
  List<T> data;
  int code;
  String message;

  BaseListResponse(this.data, this.code, this.message);

  factory BaseListResponse.fromJson(
          Map<String, dynamic> json, T Function(dynamic json) fromJsonT) =>
      _$BaseListResponseFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BaseListResponseToJson<T>(this, toJsonT);
}
