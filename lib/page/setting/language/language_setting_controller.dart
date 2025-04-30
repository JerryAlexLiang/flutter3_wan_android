import 'package:flutter3_wan_android/model/language.dart';
import 'package:flutter3_wan_android/res/strings.dart';
import 'package:flutter3_wan_android/util/logger_util.dart';
import 'package:flutter3_wan_android/util/sp_util.dart';
import 'package:get/get.dart';

import '../../../util/locale_util.dart';

class LanguageSettingController extends GetxController {
  final languageList = RxList<Language>();

  final _currentLanguage = "".obs;

  get currentLanguage => _currentLanguage.value;

  set currentLanguage(value) => _currentLanguage.value = value;

  @override
  void onInit() {
    super.onInit();
    languageList.assignAll(supportLanguageList);

    LoggerUtil.d('languageList1 : ${languageList.toJson()}');

    // 获取存储语言格式
    var languageSp = SpUtil.getLanguage();
    if (languageSp == null) {
      // 第一次安装APP，默认跟随系统设置
      for (var value in languageList) {
        if (value.name == StringsConstant.systemMode) {
          value.isSelect = true;
          currentLanguage = StringsConstant.systemMode.tr;
          LoggerUtil.d('languageList1 select: ${value.name}');
        }
      }
    } else {
      // 定位当前选中的语言
      for (var value in languageList) {
        if (value.name == languageSp.name) {
          value.isSelect = true;
          currentLanguage = value.name;
          LoggerUtil.d('languageList2 select: ${value.name}');
        }
      }
    }
  }

  /// 切换语言
  onSelectLanguage(int currentIndex) {
    for (var element in languageList) {
      element.isSelect = false;
    }
    languageList[currentIndex].isSelect = true;
    // 本地存储-更新语言格式
    SpUtil.saveUpdateLanguage(languageList[currentIndex]);
    // 使用GetX更新语言格式
    LocaleUtil.updateLocale(languageList[currentIndex]);
    currentLanguage = languageList[currentIndex].name;
  }
}
