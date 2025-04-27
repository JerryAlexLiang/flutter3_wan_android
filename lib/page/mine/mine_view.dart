import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/page/login/app_user_login_state_controller.dart';
import 'package:flutter3_wan_android/page/login/auth_middle_page.dart';
import 'package:flutter3_wan_android/page/login/login_register/login_register_controller.dart';
import 'package:flutter3_wan_android/res/gaps.dart';
import 'package:flutter3_wan_android/widget/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
    return Scaffold(
      appBar: const CustomAppBar(
        isBack: false,
        centerTitle: '我的',
      ),
      body: Center(
        child: TextButton(
          onPressed: () => {
            Get.to(
              AuthMiddlePage(
                child: Scaffold(
                  backgroundColor: Colors.red,
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(
                        child: Text("个人中心"),
                      ),
                      Gaps.vGap32,
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: MaterialButton(
                          height: 45,
                          color: Colors.blue,
                          textColor: Colors.white,
                          splashColor: Colors.red,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () => {
                            loginController.gotoLogout(),
                          },
                          child: const Text(
                            "退出登录",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              transition: Transition.fadeIn,
            ),
          },
          child: Obx(() {
            return loginState ? const Text('我的') : const Text('登录');
          }),
        ),
      ),
    );
  }
}
