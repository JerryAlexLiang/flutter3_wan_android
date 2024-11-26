/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

import 'package:flutter3_wan_android/model/article_item_bean.dart';

ArticleTestBean articleTestBeanFromJson(String str) => ArticleTestBean.fromJson(json.decode(str));

String articleTestBeanToJson(ArticleTestBean data) => json.encode(data.toJson());

class ArticleTestBean {
    ArticleTestBean({
        required this.data,
        required this.errorCode,
        required this.errorMsg,
    });

    ArticleTestBeanData data;
    int errorCode;
    String errorMsg;

    factory ArticleTestBean.fromJson(Map<dynamic, dynamic> json) => ArticleTestBean(
        data: ArticleTestBeanData.fromJson(json["data"]),
        errorCode: json["errorCode"],
        errorMsg: json["errorMsg"],
    );

    Map<dynamic, dynamic> toJson() => {
        "data": data.toJson(),
        "errorCode": errorCode,
        "errorMsg": errorMsg,
    };
}

class ArticleTestBeanData {
    ArticleTestBeanData({
        required this.over,
        required this.pageCount,
        required this.total,
        required this.curPage,
        required this.offset,
        required this.size,
        required this.datas,
    });

    bool over;
    int pageCount;
    int total;
    int curPage;
    int offset;
    int size;
    List<ArticleItemBean> datas;

    factory ArticleTestBeanData.fromJson(Map<dynamic, dynamic> json) => ArticleTestBeanData(
        over: json["over"],
        pageCount: json["pageCount"],
        total: json["total"],
        curPage: json["curPage"],
        offset: json["offset"],
        size: json["size"],
        datas: List<ArticleItemBean>.from(json["datas"].map((x) => ArticleItemBean.fromJson(x))),
    );

    Map<dynamic, dynamic> toJson() => {
        "over": over,
        "pageCount": pageCount,
        "total": total,
        "curPage": curPage,
        "offset": offset,
        "size": size,
        "datas": List<dynamic>.from(datas.map((x) => x.toJson())),
    };
}

