// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageList<T> _$PageListFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PageList<T>(
      (json['datas'] as List<dynamic>).map(fromJsonT).toList(),
      json['curPage'] as int?,
      json['offset'] as int?,
      json['over'] as bool?,
      json['pageCount'] as int?,
      json['size'] as int?,
      json['total'] as int?,
    );

Map<String, dynamic> _$PageListToJson<T>(
  PageList<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'datas': instance.datas.map(toJsonT).toList(),
      'curPage': instance.curPage,
      'offset': instance.offset,
      'over': instance.over,
      'pageCount': instance.pageCount,
      'size': instance.size,
      'total': instance.total,
    };
