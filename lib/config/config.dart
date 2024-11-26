import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter3_wan_android/http/dio_util.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class Config {
  // 是否启用代理
  static const proxyEnable = false;

  /// 代理服务IP
  static const proxyIp = '172.16.43.74';

  /// 代理服务端口
  static const proxyPort = 8866;

  static bool isDebug = true;

  /// 是否 release
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  /// 是否第一次打开
  static bool? isFirstOpen;

  /// App广告页显示时间（单位：秒）
  static const int launchTime = 10;

  ///在项目启动前做一些初始化操作
  static Future init() async {
    //运行开始
    WidgetsFlutterBinding.ensureInitialized();

    //因为EasyLoading是一个全局单例, 所以你可以在任意一个地方自定义它的样式:
    EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.threeBounce;

    // 初始化网络请求工具类
    Get.lazyPut(() => DioUtil());

    //初始化状态栏
    initStatusBar();
  }

  static void initStatusBar() {
    if (Platform.isAndroid) {
      //如果是Android设备，状态栏设置为透明沉浸
      SystemUiOverlayStyle style = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      );
      SystemChrome.setSystemUIOverlayStyle(style);
    }

    if (Platform.isIOS) {
      /// 显示状态栏
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: [SystemUiOverlay.top]);
    }
  }
}
