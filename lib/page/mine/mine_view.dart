import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter3_wan_android/base/refresh_paging_state_page.dart';
import 'package:flutter3_wan_android/page/login/login_register/login_register_controller.dart';
import 'package:flutter3_wan_android/routes/app_routes.dart';
import 'package:flutter3_wan_android/theme/app_theme.dart';
import 'package:flutter3_wan_android/util/toast_utils.dart';
import 'package:flutter3_wan_android/widget/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../res/strings.dart';
import '../login/app_user_login_state_controller.dart';
import 'component/function_card_text_widget.dart';
import 'component/user_info_image.dart';
import 'component/user_info_score.dart';
import 'mine_controller.dart';

/// state只专注数据，需要使用数据，直接通过state获取
/// logic只专注于触发事件交互，操作或更新数据
/// view只专注UI显示
class MinePage extends StatelessWidget {
  MinePage({Key? key}) : super(key: key);

  final controller = Get.find<MineController>();
  final loginController = Get.find<LoginRegisterController>();

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: const CustomAppBar(
    //     isBack: false,
    //     centerTitle: '我的',
    //   ),
    //   body: Center(
    //     child: TextButton(
    //       onPressed: () => {
    //         Get.to(
    //           AuthMiddlePage(
    //             child: Scaffold(
    //               backgroundColor: Colors.red,
    //               body: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   const Center(
    //                     child: Text("个人中心"),
    //                   ),
    //                   Gaps.vGap32,
    //                   Container(
    //                     margin: const EdgeInsets.symmetric(horizontal: 25),
    //                     child: MaterialButton(
    //                       height: 45,
    //                       color: Colors.blue,
    //                       textColor: Colors.white,
    //                       splashColor: Colors.red,
    //                       elevation: 0,
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(10),
    //                       ),
    //                       onPressed: () => {
    //                         loginController.gotoLogout(),
    //                       },
    //                       child: const Text(
    //                         "退出登录",
    //                         style: TextStyle(
    //                           color: Colors.white,
    //                           fontSize: 16,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           transition: Transition.fadeIn,
    //         ),
    //       },
    //       child: Obx(() {
    //         return loginState ? const Text('我的') : const Text('登录');
    //       }),
    //     ),
    //   ),
    // );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Obx(() {
        return Scaffold(
          body: Stack(
            children: [
              MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: RefreshPagingStatePage(
                  controller: controller,
                  onPressed: () {},
                  refreshController: controller.refreshController,
                  scrollController: controller.scrollController,
                  physics: loginState
                      ? const BouncingScrollPhysics()
                      : const ClampingScrollPhysics(),
                  // 已登录时可以下拉刷新，未登录时不能下拉刷新
                  enableRefreshPullDown: loginState ? true : false,
                  enableRefreshPullUp: false,
                  onRefresh: () => controller.getUserInfo(),
                  header: const MaterialClassicHeader(
                    color: Colors.red,
                  ),
                  child: topContainer(context),
                ),
              ),
              customAppBarTitle(context),
            ],
          ),
        );
      }),
    );
  }

  topContainer(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // 用户名头像区域
          userInfoContainer(),
          // 功能卡片区域
          functionCardContainer(context),
          Container(
            height: 100,
            color: Colors.pink,
            child: Center(
              child: MaterialButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.settingPage);
                },
                child: Row(
                  children: [
                    context.isDarkMode
                        ? Icon(
                            Icons.nightlight_round,
                            color: context.appIconColor,
                          )
                        : Icon(
                            Icons.wb_sunny_rounded,
                            color: context.appIconColor,
                          ),
                    Expanded(
                      child: Text(
                        // '更改主题',
                        StringsConstant.changeTheme.tr,
                        style: TextStyle(
                          // color: Theme.of(context).textTheme.bodyText1?.color,
                          color: context.bodyLargeColor,
                        ),
                      ),
                    ),
                    Container(
                      decoration: imageDecorationCircle(true),
                      padding: const EdgeInsets.all(1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          'images/ic_background.png',
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 500,
            color: Colors.yellow,
            child: const Center(
              child: Text("2"),
            ),
          ),
          Container(
            height: 500,
            color: Colors.blue,
            child: const Center(
              child: Text("3"),
            ),
          ),
        ],
      ),
    );
  }

  functionCardContainer(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.scaffoldBackgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: FunctionCardTextWidget(
              count: appStateController.userInfo.value.collectIds?.length,
              title: StringsConstant.collectCount.tr,
              // onTap: () =>
              //     Get.toNamed(AppRoutes.collectListPage),
              onTap: () => showToast("收藏页面", position: ToastPosition.bottom),
            ),
          ),
          Expanded(
            child: FunctionCardTextWidget(
              count: appStateController.coinInfo.value.coinCount,
              title: StringsConstant.coinCount.tr,
              onTap: () => showToast("积分", position: ToastPosition.bottom),
            ),
          ),
          Expanded(
            child: FunctionCardTextWidget(
              count: 0,
              title: StringsConstant.shareCount.tr,
              onTap: () => showToast("分享", position: ToastPosition.bottom),
            ),
          ),
          Expanded(
            child: FunctionCardTextWidget(
              count: 0,
              title: StringsConstant.browsingHistory.tr,
              onTap: () => showToast("历史", position: ToastPosition.bottom),
            ),
          ),
        ],
      ),
    );
  }

  Stack userInfoContainer() {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 30),
          height: 220,
          width: Get.width,
          child: Image.asset(
            'images/ic_background.png',
            fit: BoxFit.cover,
          ),
        ),
        //用户信息头像等
        Positioned(
          left: 20,
          bottom: 70,
          top: 70,
          child: UserInfoImage(onIconClick: () => loginController.gotoLogout()),
        ),
        //用户信息排名信息等
        const Positioned(
          bottom: 5,
          left: 0,
          right: 0,
          child: UserInfoScore(),
        ),
      ],
    );
  }

  imageDecorationCircle(bool isCircle) {
    return BoxDecoration(
      shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      color: Colors.transparent,
      border: Border.all(width: 3, color: Colors.pinkAccent),
      borderRadius: isCircle
          ? null
          : const BorderRadiusDirectional.all(
              Radius.circular(100),
            ),
      boxShadow: const [
        BoxShadow(
          color: Colors.white,
          offset: Offset(0, 0),
          //模糊
          blurRadius: 3.0,
          //传播散布
          spreadRadius: 3.0,
        ),
      ],
    );
  }

  Widget customAppBarTitle(BuildContext context) {
    return CustomAppBar(
      isBack: false,
      opacity: controller.percent ?? 0,
      centerTitle: StringsConstant.minePage,
      actionIcon: Icon(
        Icons.settings,
        color: context.appBarIconColor,
      ),
      onRightPressed: () => Get.toNamed(AppRoutes.settingPage),
    );
  }
}
