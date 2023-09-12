import 'package:json_annotation/json_annotation.dart';

part 'page_list.g.dart';

/// 一个注释，用于代码生成器，使其知道该类需要生成JSON序列化逻辑
@JsonSerializable(genericArgumentFactories: true)
class PageList<T> {
  List<T> datas;
  int? curPage;
  int? offset;
  bool? over;
  int? pageCount;
  int? size;
  int? total;

  PageList(this.datas, this.curPage, this.offset, this.over, this.pageCount,
      this.size, this.total);

  factory PageList.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) =>
      _$PageListFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$PageListToJson<T>(this, toJsonT);
}
