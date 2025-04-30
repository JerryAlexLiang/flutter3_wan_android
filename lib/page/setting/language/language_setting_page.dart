import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/res/strings.dart';
import 'package:flutter3_wan_android/widget/custom_app_bar.dart';
import 'package:flutter3_wan_android/widget/custom_list_title.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import 'language_setting_controller.dart';

class LanguageSettingPage extends StatelessWidget {
  LanguageSettingPage({Key? key}) : super(key: key);

  final LanguageSettingController controller =
      Get.find<LanguageSettingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: StringsConstant.language.tr,
      ),
      body: languageListView(),
    );
  }

  Widget languageListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: controller.languageList.length,
      itemBuilder: (context, index) {
        return CustomListTitle(
          title: controller.languageList[index].name!.tr,
          subTitle: controller.languageList[index].name,
          isSelectType: true,
          isSelect: controller.languageList[index].isSelect,
          rightWidget: const Icon(
            Icons.radio_button_checked,
            size: 20,
          ),
          onTap: () => {
            controller.onSelectLanguage(index),
            // Get.offAllNamed(AppRoutes.main),
          },
        );
      },
    );
  }
}
