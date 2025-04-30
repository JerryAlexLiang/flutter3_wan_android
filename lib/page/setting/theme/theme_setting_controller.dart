import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/util/sp_util.dart';
import 'package:get/get.dart';

import '../../../res/strings.dart';
import '../../../theme/app_theme.dart';

class ThemeSettingController extends GetxController {
  /// 主题设置
  final _themeKeyObs = ThemeKey.systemTheme.obs;

  get themeKeyValue => _themeKeyObs.value;

  set themeKeyValue(string) => _themeKeyObs.value = string;

  /// 主题模式文案
  final _themeTrObs = ThemeKey.systemTheme.obs;

  get themeTrObs => _themeTrObs.value;

  set themeTrObs(value) => _themeTrObs.value = value;

  //日间模式
  void setLightThemeMode() {
    // 更改为日间模式
    Get.changeThemeMode(ThemeMode.light);
    // 本地保存主题
    themeKeyValue = ThemeKey.lightTheme;
    SpUtil.saveAppThemeData(themeKeyValue);
    // 语言转换
    themeTrObs = StringsConstant.lightTheme;
  }

  // 夜间模式
  void setDarkThemeMode() {
    // 更改为夜间模式
    Get.changeThemeMode(ThemeMode.dark);
    //本地保存主题
    themeKeyValue = ThemeKey.darkTheme;
    SpUtil.saveAppThemeData(themeKeyValue);
    //语言转换
    themeTrObs = StringsConstant.darkTheme;
  }

  // 跟随系统模式
  void setSystemThemeMode() {
    // 更改为随系统模式
    Get.changeThemeMode(ThemeMode.system);
    themeKeyValue = ThemeKey.systemTheme;
    SpUtil.saveAppThemeData(themeKeyValue);
    //语言转换
    themeTrObs = StringsConstant.systemMode;
  }
}
