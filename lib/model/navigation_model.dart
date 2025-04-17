import 'package:flutter3_wan_android/model/article_item_bean.dart';

/// 创建日期: 2025/04/17 15:30
/// 作者: Jerry
/// 描述: 导航侧边栏数据模型

class NavigationModel {
  List<ArticleItemBean>? articles;
  int? cid;
  String? name;

  NavigationModel({this.articles, this.cid, this.name});

  NavigationModel.fromJson(Map<String, dynamic> json) {
    if (json['articles'] != null) {
      articles = <ArticleItemBean>[];
      json['articles'].forEach((v) {
        articles!.add(ArticleItemBean.fromJson(v));
      });
    }
    cid = json['cid'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (articles != null) {
      data['articles'] = articles!.map((v) => v.toJson()).toList();
    }
    data['cid'] = cid;
    data['name'] = name;
    return data;
  }
}