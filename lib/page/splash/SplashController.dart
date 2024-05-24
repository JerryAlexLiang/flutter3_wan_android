import 'dart:async';

import 'package:flutter3_wan_android/config/config.dart';
import 'package:flutter3_wan_android/routes/app_routes.dart';
import 'package:get/get.dart';

/// 开屏广告倒计时

class SplashController extends GetxController {
  Timer? _timer;

  // 倒计时(单位：秒) 10s
  var timeCount = Config.launchTime.obs;

  @override
  void onInit() {
    super.onInit();
    startLaunchTime();
  }

  // 开启倒计时
  // Future<void> startLaunchTime() async {
  void startLaunchTime() {
    Timer(const Duration(milliseconds: 0), () {
      //periodic 周期: 1秒
      _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
        timeCount--;
        if (timeCount <= 0) {
          Timer(const Duration(milliseconds: 500), () {
            // 取消倒计时,并跳转到主页面
            jumpToMain();
          });
        }
      });
    });
  }

  void jumpToMain() {
    if (_timer != null) {
      _timer?.cancel();
      // 关闭当前页面并跳转到主页面
      Get.offAndToNamed(AppRoutes.main);
    }
  }
}
