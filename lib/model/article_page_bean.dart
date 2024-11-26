import 'package:flutter3_wan_android/model/article_item_bean.dart';

/// 创建日期: 2024/10/17 15:18
/// 描述: 文章页面Bean
/// 作者: Jerry

class ArticlePageBean {
  int? curPage;
  List<ArticleItemBean>? datas;
  int? offset;
  bool? over;
  int? pageCount;
  int? size;
  int? total;

  ArticlePageBean(
      {this.curPage,
      this.datas,
      this.offset,
      this.over,
      this.pageCount,
      this.size,
      this.total});

  ArticlePageBean.fromJson(Map<String, dynamic> json) {
    curPage = json['curPage'];
    if (json['datas'] != null) {
      datas = <ArticleItemBean>[];
      json['datas'].forEach((v) {
        datas!.add(ArticleItemBean.fromJson(v));
      });
    }
    offset = json['offset'];
    over = json['over'];
    pageCount = json['pageCount'];
    size = json['size'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['curPage'] = curPage;
    if (datas != null) {
      data['datas'] = datas!.map((v) => v.toJson()).toList();
    }
    data['offset'] = offset;
    data['over'] = over;
    data['pageCount'] = pageCount;
    data['size'] = size;
    data['total'] = total;
    return data;
  }
}
