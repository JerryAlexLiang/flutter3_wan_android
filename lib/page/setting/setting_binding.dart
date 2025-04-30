import 'package:flutter3_wan_android/page/setting/language/language_setting_controller.dart';
import 'package:get/get.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LanguageSettingController());
  }
}
