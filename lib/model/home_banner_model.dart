// To parse this JSON data, do
//
//     final homeBannerModel = homeBannerModelFromJson(jsonString);

import 'dart:convert';

/// 创建日期: 2024/12/02 16:04
/// 作者: Jerry
/// 描述: 首页Banner
HomeBannerModel homeBannerModelFromJson(String str) => HomeBannerModel.fromJson(json.decode(str));

String homeBannerModelToJson(HomeBannerModel data) => json.encode(data.toJson());

class HomeBannerModel {
  String desc;
  int id;
  String imagePath;
  int isVisible;
  int order;
  String title;
  int type;
  String url;

  HomeBannerModel({
    required this.desc,
    required this.id,
    required this.imagePath,
    required this.isVisible,
    required this.order,
    required this.title,
    required this.type,
    required this.url,
  });

  factory HomeBannerModel.fromJson(Map<String, dynamic> json) => HomeBannerModel(
    desc: json["desc"],
    id: json["id"],
    imagePath: json["imagePath"],
    isVisible: json["isVisible"],
    order: json["order"],
    title: json["title"],
    type: json["type"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "desc": desc,
    "id": id,
    "imagePath": imagePath,
    "isVisible": isVisible,
    "order": order,
    "title": title,
    "type": type,
    "url": url,
  };
}
