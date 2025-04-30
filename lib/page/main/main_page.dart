import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter3_wan_android/page/main/main_controller.dart';
import 'package:flutter3_wan_android/res/strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

// class MainPage extends StatelessWidget {
//   MainPage({super.key});
//
//   final controller = Get.find<MainController>();
// }

class MainPage extends GetView<MainController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime? lastDateTime;

    return Scaffold(
      bottomNavigationBar: _buildBottomNavigatorBar(),
      // body: WillPopScope(
      //   onWillPop: () {
      //     if (lastDateTime == null ||
      //         DateTime.now().difference(lastDateTime!) >
      //             const Duration(seconds: 1)) {
      //       lastDateTime = DateTime.now();
      //       Fluttertoast.showToast(msg: StringsConstant.exitAppToast.tr);
      //       return Future.value(false);
      //     }
      //     return Future.value(true);
      //   },
      //   child: _buildPageView(),
      // ),

      /// ios 是顶部导航返回按钮
      /// Android 是系统返回按钮
      body: PopScope(
        canPop: false, // 允许返回
        // onPopInvoked: (bool didPop) async {
        //   if (didPop) {
        //     return;
        //   }
        //   if (lastDateTime == null ||
        //       DateTime.now().difference(lastDateTime!) >
        //           const Duration(seconds: 1)) {
        //     lastDateTime = DateTime.now();
        //     Fluttertoast.showToast(msg: StringsConstant.exitAppToast.tr);
        //   } else {
        //     // 系统级别导航栈 退出程序
        //     SystemNavigator.pop();
        //   }
        // },
        onPopInvokedWithResult: (bool didPop, result) async {
          if (didPop) {
            return;
          }
          if (lastDateTime == null ||
              DateTime.now().difference(lastDateTime!) >
                  const Duration(seconds: 1)) {
            lastDateTime = DateTime.now();
            Fluttertoast.showToast(msg: StringsConstant.exitAppToast.tr);
          } else {
            // 系统级别导航栈 退出程序
            SystemNavigator.pop();
          }
        },
        child: _buildPageView(),
      ),
    );
  }

  /// 底部导航栏
  Widget _buildBottomNavigatorBar() {
    return Obx(() {
      return BottomNavigationBar(
        items: controller.initBottomBarItems(),
        currentIndex: controller.currentPage,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 16.sp,
        unselectedFontSize: 13.sp,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        onTap: (int index) => controller.switchBottomTabBar(index),
      );
    });
  }

  /// 内容页
  _buildPageView() {
    return PageView(
      // 禁止滑动
      physics: const NeverScrollableScrollPhysics(),
      controller: controller.pageController,
      onPageChanged: (int index) => controller.onPageChanged(index),
      children: controller.tabPageBodies,
    );
  }
}
