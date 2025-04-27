import 'dart:convert';

import 'package:flutter3_wan_android/constant/constant.dart';
import 'package:flutter3_wan_android/model/user_info_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {
  /// 保存用户信息
  static saveUserInfo(UserInfoModel userInfoModel) {
    clearUserInfo();
    // 先将对象转为JSON字符串，再变为String字符串，再进行字符串存储
    var encode = json.encode(userInfoModel);
    Get.find<SharedPreferences>().setString(Constant.userInfoKey, encode);
  }

  /// 读取保存的用户数据
  static UserInfoModel? getUserInfo() {
    String? string =
        Get.find<SharedPreferences>().getString(Constant.userInfoKey);
    if (string != null) {
      // 和保存顺序相反，先将获取的本地存储的String字符串decode解析成dart中Map格式的JSON字符串，然后再转化为对象
      Map<String, dynamic> mapJson = json.decode(string);
      UserInfoModel userInfoModel = UserInfoModel.fromJson(mapJson);
      return userInfoModel;
    } else {
      return null;
    }
  }

  /// 清除本地持久化的用户数据
  static void clearUserInfo() {
    Get.find<SharedPreferences>().remove(Constant.userInfoKey);
  }
}
