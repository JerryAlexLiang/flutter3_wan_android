import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/base/common_state_page.dart';
import 'package:flutter3_wan_android/res/strings.dart';
import 'package:flutter3_wan_android/routes/app_routes.dart';
import 'package:flutter3_wan_android/theme/app_theme.dart';
import 'package:flutter3_wan_android/widget/custom_underline_tabIndicator.dart';
import 'package:flutter3_wan_android/widget/ripple_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'project_logic.dart';

class ProjectPage extends StatelessWidget {
  ProjectPage({Key? key}) : super(key: key);

  final controller = Get.find<ProjectLogic>();

  @override
  Widget build(BuildContext context) {
    return CommonStatePage(
      controller: controller,
      onPressed: () => controller.initProjectTreeList(),
      child: Obx(() {
        /// 实战中，如果需要 TabBar 和 TabBarView 联动，通常会创建一个 DefaultTabController 作为它们共同的父级组件，
        /// 这样它们在执行时就会从组件树向上查找，都会使用我们指定的这个 DefaultTabController
        return DefaultTabController(
          length: controller.projectTreeTabList.length,
          initialIndex: 0,
          // child: Scaffold(
          //   appBar: AppBar(
          //     centerTitle: true,
          //     title: Text(
          //       StringsConstant.projectPage.tr,
          //       style: context.titleMediumStyle,
          //     ),
          //     bottom: treeTabBar(context),
          //   ),
          //   body: sliverPageView(),
          // ),
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                StringsConstant.projectPage.tr,
                style: context.titleMediumStyle,
              ),
              actions: [
                RippleView(
                  radius: 100,
                  onTap: () => Get.toNamed(AppRoutes.searchPage),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      Icons.search,
                      color: context.theme.appBarTheme.iconTheme?.color,
                    ),
                  ),
                ),
              ],
              bottom: treeTabContainer(context),
            ),
            // body: sliverPageView(context, controller),
            body: sliverPageView(),
          ),
        );
      }),
    );
  }

  treeTabContainer(BuildContext context) {
    if (controller.projectTreeTabList.isNotEmpty) {
      List<Widget> warpList = tabWrapList(context);

      return PreferredSize(
        preferredSize: const Size.fromHeight(36),
        child: Row(
          children: [
            Expanded(
              child: treeTabBar(context),
            ),
            tabMenuWidget(warpList, context),
          ],
        ),
      );
    }
  }

  RippleView tabMenuWidget(List<Widget> warpList, BuildContext context) {
    return RippleView(
      radius: 100,
      onTap: () {
        // 底部弹出菜单
        Get.bottomSheet(
          Container(
            padding: EdgeInsets.all(10.w),
            child: Wrap(
              runSpacing: 1.w,
              spacing: 5.w,
              children: warpList,
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
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        child: const Icon(Icons.menu),
      ),
    );
  }

  List<Widget> tabWrapList(BuildContext context) {
    List<Widget> warpList = controller.projectTreeTabList.map((element) {
      return Obx(() {
        return ChoiceChip(
          label: Text(
            element.name ?? "",
            style: context.bodyMediumStyle,
          ),
          selectedColor: Colors.lightBlueAccent.withValues(alpha: 0.5),
          selected: controller.tabController.index ==
              controller.projectTreeTabList.indexOf(element),
          onSelected: (bool newValue) {
            controller.tabController.index =
                controller.projectTreeTabList.indexOf(element);
            //关闭弹框
            if (Get.isBottomSheetOpen == true) {
              Get.back();
            }
          },
        );
      });
    }).toList();
    return warpList;
  }

  treeTabBar(BuildContext context) {
    if (controller.projectTreeTabList.isNotEmpty) {
      // 创建Tab组件列表
      List<Widget>? tabList = controller.projectTreeTabList
          .map((e) => Tab(
                text: e.name,
              ))
          .toList();

      // /// TabBar监听
      // controller.tabController.addListener(() {
      //   if (controller.tabController.index ==
      //       controller.tabController.animation!.value) {
      //     // controller.projectTabIndex = controller.tabController.index;
      //   }
      // });

      return TabBar(
        tabs: tabList,
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
  }

  Widget? sliverPageView() {
    if (controller.projectTreeTabList.isNotEmpty) {
      var list = controller.projectTreeTabList
          .map((e) => Center(
                child: Text(e.name ?? ""),
              ))
          .toList();

      return TabBarView(
        controller: controller.tabController,
        children: list,
      );
    }
    return null;
  }
}
