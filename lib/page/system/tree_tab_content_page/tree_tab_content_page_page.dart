import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/constant/constant.dart';
import 'package:flutter3_wan_android/model/tree_model.dart';
import 'package:flutter3_wan_android/theme/app_theme.dart';
import 'package:flutter3_wan_android/widget/custom_underline_tabIndicator.dart';
import 'package:flutter3_wan_android/widget/ripple_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'tree_tab_content_page_controller.dart';

/// 创建日期: 2025/04/22 14:13
/// 作者: Jerry
/// 描述: 体系PageView

class TreeTabContentPagePage extends StatelessWidget {
  TreeTabContentPagePage({Key? key}) : super(key: key);

  final TreeTabContentPageController controller =
      Get.put(TreeTabContentPageController());

  @override
  Widget build(BuildContext context) {
    final TreeModel treeModel = Get.arguments[Constant.treeModel];
    final int treeModelIndex = Get.arguments[Constant.treeModelIndex];

    return Scaffold(
      appBar: buildAppBar(treeModel, context),
      body: sliverPageView(),
    );
  }

  AppBar buildAppBar(TreeModel treeModel, BuildContext context) {
    return AppBar(
      // automaticallyImplyLeading: false,
      leading: buildRippleView(),
      // centerTitle: true,
      title: Text(
        treeModel.name ?? "",
        style: context.titleLargeStyle,
      ),
      actions: [
        buildActionsRippleView(context, treeModel),
      ],
      bottom: treeTab(context, treeModel),
    );
  }

  RippleView buildActionsRippleView(BuildContext context, TreeModel treeModel) {
    return RippleView(
      radius: 100,
      onTap: () {
        // 底部弹出菜单
        buildBottomSheet(context, treeModel);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.all(5),
        child: const Icon(Icons.menu),
      ),
    );
  }

  Future<dynamic> buildBottomSheet(BuildContext context, TreeModel treeModel) {
    return Get.bottomSheet(
      Container(
        width: ScreenUtil().screenWidth - 10.h,
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(10.w),
        child: Wrap(
          runSpacing: 1.w,
          spacing: 5.w,
          children: warpList(context, treeModel),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: context.scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    );
  }

  RippleView buildRippleView() {
    return RippleView(
      radius: 100,
      onTap: () => Get.back(),
      child: Container(
        padding: const EdgeInsets.all(5),
        child: const Icon(Icons.arrow_back_ios_new),
      ),
      // child: const Icon(Icons.arrow_back_ios),
    );
  }

  warpList(BuildContext context, TreeModel treeModel) {
    List<Widget>? wrapList = treeModel.children?.map((element) {
      return ChoiceChip(
        label: Text(
          element.name ?? "",
          style: context.bodyMediumStyle,
        ),
        selectedColor: Colors.lightBlueAccent.withValues(alpha: 0.5),
        selected: controller.tabController.index ==
            controller.treeModel.children?.indexOf(element),
        onSelected: (bool newValue) {
          controller.tabController.index =
              controller.treeModel.children!.indexOf(element);
          // 关闭弹窗
          if (Get.isBottomSheetOpen == true) {
            Get.back();
          }
        },
      );
    }).toList();
    return wrapList;
  }

  treeTab(BuildContext context, TreeModel treeModel) {
    List<Widget>? tabList = treeModel.children
        ?.map((element) => Tab(
              text: element.name,
            ))
        .toList();

    return TabBar(
      tabs: tabList!,
      controller: controller.tabController,
      tabAlignment: TabAlignment.start,
      isScrollable: true,
      indicatorColor: Colors.red,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 0,
      //自定义indicator指示器
      indicator: const CustomUnderlineTabIndicator(
        borderSide: BorderSide(
          width: 3,
          color: Colors.red,
        ),
        insets: EdgeInsets.only(
          left: 12,
          right: 12,
          top: 10,
          // bottom: 3,
        ),
      ),
      automaticIndicatorColorAdjustment: true,
      labelColor: Colors.blue,
      unselectedLabelColor: context.bodyMediumColor,
      labelStyle: const TextStyle(
        color: Colors.blue,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: TextStyle(
        color: context.bodyMediumColor,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Widget sliverPageView() {
    List<Widget>? list = controller.treeModel.children
        ?.map((e) => Center(
              child: Text(e.name ?? ""),
            ))
        .toList();

    return TabBarView(
      controller: controller.tabController,
      children: list!,
    );
  }
}
