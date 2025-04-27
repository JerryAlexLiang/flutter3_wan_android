import 'package:flutter3_wan_android/page/home2/home2_controller.dart';
import 'package:flutter3_wan_android/page/login/login_register/login_register_controller.dart';
import 'package:flutter3_wan_android/page/main/main_controller.dart';
import 'package:flutter3_wan_android/page/mine/mine_controller.dart';
import 'package:flutter3_wan_android/page/navigation/navigation_logic.dart';
import 'package:flutter3_wan_android/page/project/project_logic.dart';
import 'package:flutter3_wan_android/page/system/system_logic.dart';
import 'package:flutter3_wan_android/page/web/article_detail_controller.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    // 首页导航页控制器
    Get.lazyPut(() => MainController());
    // HomePage
    // Get.lazyPut(() => HomeController());
    Get.lazyPut(() => Home2Controller());
    // NavigationPage
    Get.lazyPut(() => NavigationLogic());
    // ProjectPage
    Get.lazyPut(() => ProjectLogic());
    // SystemPage
    Get.lazyPut(() => SystemLogic());
    // MinePage
    Get.lazyPut(() => MineController());

    // 文章详情控制器（收藏、点赞等）多个地方使用，所以在进入MainPage时，就初始化
    Get.lazyPut(() => ArticleDetailController());
    // 登录逻辑控制器
    Get.lazyPut(() => LoginRegisterController());
  }
}
