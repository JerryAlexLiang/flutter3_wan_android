import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/page/login/app_user_login_state_controller.dart';
import 'package:flutter3_wan_android/page/login/login_register/login_register_controller.dart';
import 'package:flutter3_wan_android/page/setting/language/language_setting_controller.dart';
import 'package:flutter3_wan_android/page/setting/theme/theme_setting_controller.dart';
import 'package:flutter3_wan_android/res/strings.dart';
import 'package:flutter3_wan_android/routes/app_routes.dart';
import 'package:flutter3_wan_android/widget/custom_app_bar.dart';
import 'package:flutter3_wan_android/widget/custom_list_title.dart';
import 'package:get/get.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);

  final loginController = Get.find<LoginRegisterController>();
  final themeSettingController = Get.find<ThemeSettingController>();
  final languageController = Get.find<LanguageSettingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        // centerTitle: '设置',
        centerTitle: StringsConstant.setting.tr,
      ),
      body: Obx(() {
        return ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            CustomListTitle(
              // title: '主题',
              title: StringsConstant.theme.tr,
              isShowLeftWidget: true,
              leftWidget: context.isDarkMode
                  ? const Icon(Icons.nightlight_round)
                  : const Icon(Icons.wb_sunny_rounded),
              rightContent: themeSettingController.themeTrObs,
              rightImage: 'images/ic_arrow_right.png',
              onTap: () => Get.toNamed(AppRoutes.themeModePage),
            ),
            CustomListTitle(
              // title: '语言',
              title: StringsConstant.language.tr,
              isShowLeftWidget: true,
              leftWidget: const Icon(Icons.language),
              rightContent: languageController.currentLanguage,
              onTap: () => Get.toNamed(AppRoutes.languageModePage),
            ),
            Visibility(
              visible: loginState,
              child: CustomListTitle(
                title: '退出登录',
                isShowLeftWidget: true,
                leftWidget: const Icon(Icons.logout),
                onTap: () => loginController.gotoLogout(),
              ),
            ),
          ],
        );
      }),
    );
  }
}
