import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/base/common_state_page.dart';
import 'package:flutter3_wan_android/model/navigation_model.dart';
import 'package:flutter3_wan_android/page/navigation/component/NavigationChipWrap.dart';
import 'package:flutter3_wan_android/res/strings.dart';
import 'package:flutter3_wan_android/routes/app_routes.dart';
import 'package:flutter3_wan_android/theme/app_theme.dart';
import 'package:flutter3_wan_android/widget/custom_app_bar.dart';
import 'package:flutter3_wan_android/widget/state/load_error_page.dart';
import 'package:flutter3_wan_android/widget/state/load_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'navigation_logic.dart';

/// 创建日期: 2025/04/17 16:00
/// 作者: Jerry
/// 描述: 导航页面

class NavigationPage extends StatelessWidget {
  NavigationPage({Key? key}) : super(key: key);

  final navigationController = Get.find<NavigationLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isBack: false,
        showBottomLine: true,
        centerTitle: StringsConstant.navigationPage.tr,
        actionIcon: Icon(
          Icons.search,
          color: context.theme.appBarTheme.iconTheme?.color,
        ),
        onRightPressed: () => Get.toNamed(AppRoutes.searchPage),
      ),
      body: SafeArea(
        child: CommonStatePage(
          controller: navigationController,
          onPressed: () => navigationController.initNavigationData(),
          child: navigationView(),
        ),
      ),
    );
  }

  Widget navigationView() {
    return Row(
      children: [
        SizedBox(
          width: 100.w,
          child: leftNavigationGroupView(),
        ),
        Expanded(
          child: rightNavigationChildrenView(),
        ),
      ],
    );
  }

  Widget leftNavigationGroupView() {
    return Obx(() {
      var navigationGroupList = navigationController.navigationGroupList;
      var currentNavigation = navigationController.currentNavigation.value;

      var divider = const Divider(
        height: 0,
      );

      return ListView.separated(
        separatorBuilder: (context, index) => divider,
        itemCount: navigationController.navigationGroupList.length,
        itemBuilder: (context, index) {
          // 当前是否选中
          bool isSelectNavigation =
              navigationGroupList[index]?.cid == currentNavigation?.cid;

          /// 给InkWell内部的组件设置颜色，会导致给InkWell的点击水波纹效果消失，需要在外面套一层Ink或者MMaterial组件
          return Ink(
            color: isSelectNavigation
                ? context.appBarBackgroundColor
                // : Colors.grey.withOpacity(0.1),
                : Colors.grey.withValues(alpha: 0.1),
            child: InkWell(
              /// 点击导航item切换当前导航item值currentNavigation
              onTap: () => navigationController
                  .changeNavigation(navigationGroupList[index]),
              child: Container(
                height: 40.h,
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 当前导航选中时显示
                    Visibility(
                      visible: isSelectNavigation,
                      child: Container(
                        width: 2.w,
                        height: 45.h,
                        color: Colors.red,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          navigationGroupList[index]?.name ?? "",
                          style: TextStyle(
                            color: isSelectNavigation
                                ? context.bodyLargeColor
                                : context.bodyMediumColor,
                            fontSize: isSelectNavigation ? 14 : 12,
                            fontWeight: isSelectNavigation
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget rightNavigationChildrenView() {
    return Obx(() {
      NavigationModel? currentNavigation =
          navigationController.currentNavigation.value;
      if (currentNavigation == null) {
        return EmptyErrorStatePage(
          loadState: LoadState.empty,
          onTap: () => navigationController.initNavigationData(),
          errMsg: StringsConstant.noData.tr,
        );
      }

      return Container(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: ScreenUtil().screenWidth - 60.w,
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 8.h,
              ),
              // color: Colors.white.withOpacity(0.5),
              child: Text(
                currentNavigation.name ?? "导航",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.red,
                ),
              ),
            ),
            // 不滚动标题栏，只滚动标签流动布局
            /// Column直接套子组件会超出
            Expanded(
              child: (currentNavigation.articles != null &&
                      currentNavigation.articles!.isNotEmpty)
                  ? SingleChildScrollView(
                      // padding: EdgeInsets.all(5.w),
                      padding: EdgeInsets.only(
                        left: 3.w,
                        right: 1.w,
                        top: 3.h,
                        bottom: 3.h,
                      ),
                      child: articlesWrap(currentNavigation),
                    )
                  : EmptyErrorStatePage(
                      loadState: LoadState.empty,
                      onTap: () => navigationController.initNavigationData(),
                      errMsg: StringsConstant.noData.tr,
                    ),
            ),
          ],
        ),
      );
    });
  }

  /// 流布局列表
  Widget articlesWrap(NavigationModel model) {
    return NavigationChipWrap(
      chipList: model.articles,
      onTap: (value) => Fluttertoast.showToast(msg: "${value.title}"),
      // onTap: (value) => Get.toNamed(
      //   AppRoutes.articleDetailPage,
      //   arguments: {
      //     "data": value,
      //     "showCollect": true,
      //   },
      // ),
    );
  }
}
