import 'package:flutter3_wan_android/model/user_info_model.dart';

/// 创建日期: 2025/04/24 13:43
/// 作者: Jerry
/// 描述: 个人信息接口返回数据

class TotalUserInfoModel {
  CoinInfo? coinInfo;
  UserInfoModel? userInfo;

  TotalUserInfoModel({this.coinInfo, this.userInfo});

  TotalUserInfoModel.fromJson(Map<String, dynamic> json) {
    coinInfo =
        json['coinInfo'] != null ? CoinInfo.fromJson(json['coinInfo']) : null;
    userInfo = json['userInfo'] != null
        ? UserInfoModel.fromJson(json['userInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (coinInfo != null) {
      data['coinInfo'] = coinInfo!.toJson();
    }
    if (userInfo != null) {
      data['userInfo'] = userInfo;
    }
    return data;
  }
}

class CoinInfo {
  int? coinCount;
  int? level;
  String? nickname;
  String? rank;
  int? userId;
  String? username;

  CoinInfo(
      {this.coinCount,
      this.level,
      this.nickname,
      this.rank,
      this.userId,
      this.username});

  CoinInfo.fromJson(Map<String, dynamic> json) {
    coinCount = json['coinCount'];
    level = json['level'];
    nickname = json['nickname'];
    rank = json['rank'];
    userId = json['userId'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['coinCount'] = coinCount;
    data['level'] = level;
    data['nickname'] = nickname;
    data['rank'] = rank;
    data['userId'] = userId;
    data['username'] = username;
    return data;
  }
}
