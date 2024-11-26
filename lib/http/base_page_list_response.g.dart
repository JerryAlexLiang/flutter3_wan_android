// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_page_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasePageListResponse<T> _$BasePageListResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BasePageListResponse<T>(
      (json['code'] as num).toInt(),
      json['message'] as String,
      PageList<T>.fromJson(
          json['data'] as Map<String, dynamic>, (value) => fromJsonT(value)),
    );

Map<String, dynamic> _$BasePageListResponseToJson<T>(
  BasePageListResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data.toJson(
        (value) => toJsonT(value),
      ),
    };
