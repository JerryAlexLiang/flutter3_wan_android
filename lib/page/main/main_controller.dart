import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/page/home2/home2_page.dart';
import 'package:flutter3_wan_android/page/mine/mine_view.dart';
import 'package:flutter3_wan_android/page/navigation/navigation_view.dart';
import 'package:flutter3_wan_android/page/project/project_view.dart';
import 'package:flutter3_wan_android/page/system/system_view.dart';
import 'package:flutter3_wan_android/res/strings.dart';
import 'package:flutter3_wan_android/util/keep_alive_wrapper.dart';
import 'package:flutter3_wan_android/util/logger_util.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  /// 底部BottomNavigationBarItem

  /// 响应式成员变量，底部导航栏默认位置指引0
  final _currentPage = 0.obs;

  get currentPage => _currentPage.value;

  set currentPage(index) => _currentPage.value = index;

  /// PageView页面控制器
  late PageController pageController;

  /// 底部导航栏Tab点击切换PageView
  void switchBottomTabBar(int index) {
    // 这里将索引切换设置在onPageChanged方法中即可
    // currentPage = index;
    // 点击底部BottomNavigationBarItem切换PageView页面
    pageController.jumpToPage(index);
  }

  /// PageView切换更新当前index
  void onPageChanged(int index) {
    currentPage = index;
  }

  /// PageView子组件
  late List<Widget> tabPageBodies;

  /// 生命周期
  /// 在Widget内存中分配后立即调用
  /// 可以用它来微控制器初始化initialize一些东西
  @override
  void onInit() {
    super.onInit();
    LoggerUtil.d('onInit()', tag: 'IndexController');
    // PageView页面控制器
    pageController = PageController(initialPage: currentPage);

    // // 初始化底部导航Items
    // initBottomBarItems();

    // PageView Body
    initPageViewBodies();
  }

  // PageView Body
  void initPageViewBodies() {
    tabPageBodies = <Widget>[
      // KeepAliveWrapper(
      //   // keepAlive默认为true
      //   // keepAlive为 true 后会缓存所有的列表项，列表项将不会销毁。
      //   // keepAlive为 false 时，列表项滑出预加载区域后将会别销毁。
      //   // 使用时一定要注意是否必要，因为对所有列表项都缓存的会导致更多的内存消耗
      //   keepAlive: true,
      //   child: HomePage(),
      // ),
      KeepAliveWrapper(
        // keepAlive默认为true
        // keepAlive为 true 后会缓存所有的列表项，列表项将不会销毁。
        // keepAlive为 false 时，列表项滑出预加载区域后将会别销毁。
        // 使用时一定要注意是否必要，因为对所有列表项都缓存的会导致更多的内存消耗
        keepAlive: true,
        child: Home2Page(),
      ),
      KeepAliveWrapper(
        child: NavigationPage(),
      ),
      KeepAliveWrapper(
        child: ProjectPage(),
      ),
      KeepAliveWrapper(
        child: SystemPage(),
      ),
      KeepAliveWrapper(
        child: MinePage(),
      ),
    ];
  }

  // 初始化底部导航Items
  List<BottomNavigationBarItem> initBottomBarItems() {
    var bottomTabs = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: const Icon(
          Icons.home_outlined,
          size: 20,
        ),
        activeIcon: const Icon(
          Icons.home,
          size: 25,
        ),
        label: StringsConstant.homePage.tr,
      ),
      BottomNavigationBarItem(
        icon: const Icon(
          Icons.navigation_outlined,
          size: 20,
        ),
        activeIcon: const Icon(
          Icons.navigation,
          size: 25,
        ),
        // label: '导航',
        label: StringsConstant.navigationPage.tr,
      ),
      BottomNavigationBarItem(
        icon: const Icon(
          Icons.apps_outlined,
          size: 20,
        ),
        activeIcon: const Icon(
          Icons.apps,
          size: 25,
        ),
        // label: '项目',
        label: StringsConstant.projectPage.tr,
      ),
      BottomNavigationBarItem(
        icon: const Icon(
          Icons.person_outline,
          size: 20,
        ),
        activeIcon: const Icon(
          Icons.person,
          size: 25,
        ),
        // label: '我的',
        label: StringsConstant.accountTreePage.tr,
      ),
      BottomNavigationBarItem(
        icon: const Icon(
          Icons.person_outline,
          size: 20,
        ),
        activeIcon: const Icon(
          Icons.person,
          size: 25,
        ),
        // label: '我的',
        label: StringsConstant.minePage.tr,
      ),
    ];
    return bottomTabs;
  }

  ///在 onInit() 之后调用 1 帧。这是进入的理想场所
  ///导航事件，例如 snackbar、对话框或新route，或async 异步请求。
  @override
  void onReady() {
    super.onReady();
    // async 拉取数据
    LoggerUtil.d('onReady()', tag: 'IndexController');
  }

  ///在 [onDelete] 方法之前调用。 [onClose] 可能用于
  ///处理控制器使用的资源。就像 closing events 一样，
  ///或在控制器销毁之前的流。
  ///或者处置可能造成一些内存泄漏的对象，
  ///像 TextEditingControllers、AnimationControllers。
  ///将一些数据保存在磁盘上也可能很有用。
  @override
  void onClose() {
    super.onClose();
    // 1 stop & close 关闭对象
    // 2 save 持久化数据
    LoggerUtil.d('onClose()', tag: 'IndexController');
  }

  ///dispose 释放内存
  @override
  void dispose() {
    // dispose释放对象
    pageController.dispose();
    super.dispose();
    LoggerUtil.d('dispose()', tag: 'IndexController');
  }
}
