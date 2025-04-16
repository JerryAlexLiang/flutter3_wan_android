import 'package:flutter3_wan_android/page/home/home_controller.dart';
import 'package:flutter3_wan_android/page/main/main_controller.dart';
import 'package:flutter3_wan_android/page/mine/mine_logic.dart';
import 'package:flutter3_wan_android/page/navigation/navigation_logic.dart';
import 'package:flutter3_wan_android/page/project/project_logic.dart';
import 'package:flutter3_wan_android/page/system/system_logic.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    // 首页导航页控制器
    Get.lazyPut(() => MainController());
    // HomePage
    Get.lazyPut(() => HomeController());
    // NavigationPage
    Get.lazyPut(() => NavigationLogic());
    // ProjectPage
    Get.lazyPut(() => ProjectLogic());
    // SystemPage
    Get.lazyPut(() => SystemLogic());
    // MinePage
    Get.lazyPut(() => MineLogic());
  }
}

//class IndexBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut(() => IndexController());
//     Get.lazyPut(() => MySearchController());
//     Get.lazyPut(() => HomeController());
//     Get.lazyPut(() => SystemTreeController());
//     Get.lazyPut(() => NavigationTreeController());
//     Get.lazyPut(() => ProjectController());
//     Get.lazyPut(() => MineController());
//
//     /// 文章详情控制器（收藏、点赞等）
//     Get.put(ArticleDetailController());
//
//     // /// 登录注册退出
//     // Get.lazyPut(() => LoginRegisterController());
//   }
// }
