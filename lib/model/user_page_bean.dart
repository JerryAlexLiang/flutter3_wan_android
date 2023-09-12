// To parse this JSON data, do
//
//     final userPageBean = userPageBeanFromJson(jsonString);

import 'dart:convert';

import 'package:flutter3_wan_android/model/user.dart';

UserPageBean userPageBeanFromJson(String str) =>
    UserPageBean.fromJson(json.decode(str));

String userPageBeanToJson(UserPageBean data) => json.encode(data.toJson());

class UserPageBean {
  int curPage;
  List<User> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  UserPageBean({
    required this.curPage,
    required this.datas,
    required this.offset,
    required this.over,
    required this.pageCount,
    required this.size,
    required this.total,
  });

  factory UserPageBean.fromJson(Map<String, dynamic> json) => UserPageBean(
        curPage: json["curPage"],
        datas: List<User>.from(json["datas"].map((x) => User.fromJson(x))),
        offset: json["offset"],
        over: json["over"],
        pageCount: json["pageCount"],
        size: json["size"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "curPage": curPage,
        "datas": List<dynamic>.from(datas.map((x) => x.toJson())),
        "offset": offset,
        "over": over,
        "pageCount": pageCount,
        "size": size,
        "total": total,
      };
}
