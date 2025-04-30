import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/res/strings.dart';
import 'package:flutter3_wan_android/theme/app_theme.dart';
import 'package:flutter3_wan_android/widget/custom_app_bar.dart';
import 'package:flutter3_wan_android/widget/custom_list_title.dart';
import 'package:get/get.dart';

import 'theme_setting_controller.dart';

class ThemeSettingPage extends StatelessWidget {
  ThemeSettingPage({Key? key}) : super(key: key);

  final ThemeSettingController controller = Get.find<ThemeSettingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: StringsConstant.settingTheme.tr,
        actionIcon: context.isDarkMode
            ? Icon(Icons.nightlight_round, color: context.iconColor)
            : Icon(Icons.wb_sunny_rounded, color: context.iconColor),
      ),
      //在 Flutter 官方的介绍中，ScrollPhysics 的作用是 确定可滚动控件的物理特性， 常见的有以下四大金刚：
      // 1、BouncingScrollPhysics ：允许滚动超出边界，但之后内容会反弹回来。但是在子view不足以填充满的时候设置这个属性是不会生效的，
      // 需要设置属性physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics())
      // 2、ClampingScrollPhysics ： 防止滚动超出边界，夹住 。
      // 3、AlwaysScrollableScrollPhysics ：始终响应用户的滚动。
      // 4、NeverScrollableScrollPhysics ：不响应用户的滚动。
      body: Obx(() {
        return Center(
          child: ListView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              //跟随系统模式
              CustomListTitle(
                isSelectType: true,
                // title: '跟随系统模式',
                title: StringsConstant.systemMode.tr,
                isShowLeftWidget: true,
                leftWidget: const Icon(Icons.lightbulb_rounded),
                rightWidget: const Icon(Icons.check),
                onTap: () => controller.setSystemThemeMode(),
                isSelect: controller.themeKeyValue == ThemeKey.systemTheme
                    ? true
                    : false,
              ),
              //白色主题
              CustomListTitle(
                isSelectType: true,
                // title: '日间模式',
                title: StringsConstant.lightTheme.tr,
                isShowLeftWidget: true,
                leftWidget: const Icon(Icons.wb_sunny_rounded),
                rightWidget: const Icon(Icons.check),
                onTap: () => controller.setLightThemeMode(),
                isSelect: controller.themeKeyValue == ThemeKey.lightTheme
                    ? true
                    : false,
              ),
              //夜间模式
              CustomListTitle(
                isSelectType: true,
                // title: '夜间模式',
                title: StringsConstant.darkTheme.tr,
                isShowLeftWidget: true,
                leftWidget: const Icon(Icons.nightlight_round),
                rightWidget: const Icon(Icons.check),
                onTap: () => controller.setDarkThemeMode(),
                isSelect: controller.themeKeyValue == ThemeKey.darkTheme
                    ? true
                    : false,
              ),
            ],
          ),
        );
      }),
    );
  }
}
