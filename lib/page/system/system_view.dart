import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/base/refresh_paging_state_page.dart';
import 'package:flutter3_wan_android/model/tree_model.dart';
import 'package:flutter3_wan_android/page/system/component/tree_chip_wrap.dart';
import 'package:flutter3_wan_android/res/strings.dart';
import 'package:flutter3_wan_android/routes/app_routes.dart';
import 'package:flutter3_wan_android/theme/app_theme.dart';
import 'package:flutter3_wan_android/widget/custom_app_bar.dart';
import 'package:flutter3_wan_android/widget/ripple_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import 'system_logic.dart';

/// 创建日期: 2025/04/22 11:03
/// 作者: Jerry
/// 描述: 体系

class SystemPage extends StatelessWidget {
  SystemPage({Key? key}) : super(key: key);

  final controller = Get.find<SystemLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isBack: false,
        showBottomLine: true,
        centerTitle: StringsConstant.accountTreePage.tr,
        actionIcon: Icon(
          Icons.search,
          color: context.theme.appBarTheme.iconTheme?.color,
        ),
        onRightPressed: () => Get.toNamed(AppRoutes.searchPage),
      ),
      body: SafeArea(
        child: Obx(() {
          return RefreshPagingStatePage(
            controller: controller,
            refreshController: controller.refreshController,
            onPressed: () => controller.onFirstInRequestData(),
            enableRefreshPullUp: false,
            // 禁止上滑加载更多
            onRefresh: () => controller.onRefreshRequestData(),
            child: ListView.builder(
              itemCount: controller.systemTreeList.length,
              itemBuilder: (context, index) {
                /// 列表悬浮头
                return RippleView(
                  onTap: () => {
                    // Get.toNamed(
                    //   AppRoutes.treeTabContainerPage,
                    //   arguments: {
                    //     "treeModel": controller.systemTreeList[index],
                    //     "treeModelIndex": 0,
                    //   },
                    // )
                    showToast(controller.systemTreeList[index].name ?? "")
                  },
                  child: StickyHeader(
                    header: treeListItemHeader(
                      context,
                      controller.systemTreeList[index],
                    ),
                    content: treeListItemContent(
                      context,
                      controller.systemTreeList[index],
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }

  /// 头部组件
  Widget treeListItemHeader(BuildContext context, TreeModel treeModel) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: context.scaffoldBackgroundColor,
        border: const Border(
          bottom: BorderSide(width: 0.1, color: Colors.grey),
        ),
      ),
      child: Text(
        treeModel.name ?? "体系",
        style: context.bodyLargeStyle?.copyWith(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// 子组件
  Widget treeListItemContent(BuildContext context, TreeModel treeModel) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 10.h,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.2, color: Colors.grey),
        ),
      ),
      child: TreeChipWrap(
        chipList: treeModel.children,
        onTap: (Children value, int treeModelIndex) => {
          // Get.toNamed(
          //   AppRoutes.treeTabContainerPage,
          //   arguments: {
          //     "treeModel": treeModel,
          //     "treeModelIndex": treeModelIndex,
          //   },
          // )
          showToast(
            value.name ?? "",
            position: ToastPosition.bottom,
          )
        },
      ),
    );
  }
}
