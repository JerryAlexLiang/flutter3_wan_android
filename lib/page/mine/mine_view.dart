import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/page/login/auth_middle_page.dart';
import 'package:flutter3_wan_android/widget/custom_app_bar.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import 'mine_controller.dart';

/// state只专注数据，需要使用数据，直接通过state获取
/// logic只专注于触发事件交互，操作或更新数据
/// view只专注UI显示
class MinePage extends StatelessWidget {
  MinePage({Key? key}) : super(key: key);

  final controller = Get.find<MineController>();

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
                child: Container(
                  color: Colors.red,
                  child: const Center(
                    child: Text("个人中心"),
                  ),
                ),
              ),
              transition: Transition.fadeIn,
            ),
          },
          child: const Text('我的'),
        ),
      ),
    );
  }
}
