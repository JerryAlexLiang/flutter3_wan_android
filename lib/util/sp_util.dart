import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/constant/constant.dart';
import 'package:flutter3_wan_android/model/language.dart';
import 'package:flutter3_wan_android/model/user_info_model.dart';
import 'package:flutter3_wan_android/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'locale_util.dart';

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

  /// 存储设置的主题
  static saveAppThemeData(String themeKey) {
    Get.find<SharedPreferences>().setString(ThemeKey.appThemeKey, themeKey);
  }

  /// 获取存储的主题
  static String? getAppThemeData() {
    return Get.find<SharedPreferences>().getString(ThemeKey.appThemeKey);
  }

  /// 存储-更新语言格式
  static saveUpdateLanguage(Language language) {
    Get.find<SharedPreferences>()
        .setString(LocaleUtil.appLanguageKey, jsonEncode(language.toJson()));
  }

  /// 获取存储的语言格式
  static Language? getLanguage() {
    try {
      var languageJson =
          Get.find<SharedPreferences>().getString(LocaleUtil.appLanguageKey);
      if (languageJson == null) {
        //如果没有存储语言设置，则默认是跟随系统
        return null;
      } else {
        return Language.fromJson(jsonDecode(languageJson));
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
