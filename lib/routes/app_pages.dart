import 'package:flutter3_wan_android/page/home/home_binding.dart';
import 'package:flutter3_wan_android/page/home/home_page.dart';
import 'package:flutter3_wan_android/page/main/main_binding.dart';
import 'package:flutter3_wan_android/page/main/main_page.dart';
import 'package:flutter3_wan_android/page/mine/mine_binding.dart';
import 'package:flutter3_wan_android/page/mine/mine_view.dart';
import 'package:flutter3_wan_android/page/navigation/navigation_binding.dart';
import 'package:flutter3_wan_android/page/navigation/navigation_view.dart';
import 'package:flutter3_wan_android/page/project/project_binding.dart';
import 'package:flutter3_wan_android/page/project/project_view.dart';
import 'package:flutter3_wan_android/page/system/system_binding.dart';
import 'package:flutter3_wan_android/page/system/system_view.dart';
import 'package:flutter3_wan_android/routes/app_routes.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../page/splash/SplashBinding.dart';
import '../page/splash/SplashPage.dart';

class AppPages {
  // static final unknownRoute = GetPage(
  //   name: AppRoutes.unknownRoutePage,
  //   page: () => const UnKnownRoutePage(),
  // );

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainPage(),
      binding: MainBinding(),
    ),

    GetPage(
      name: AppRoutes.homePage,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.navigationPage,
      page: () => NavigationPage(),
      binding: NavigationBinding(),
    ),
    GetPage(
      name: AppRoutes.projectPage,
      page: () => ProjectPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: AppRoutes.systemPage,
      page: () => SystemPage(),
      binding: SystemBinding(),
    ),
    GetPage(
      name: AppRoutes.minePage,
      page: () => MinePage(),
      binding: MineBinding(),
    ),


    // GetPage(
    //   name: AppRoutes.settingPage,
    //   page: () => SettingPage(),
    //   binding: SettingBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.themeModePage,
    //   page: () => ThemeSettingPage(),
    // ),
    // GetPage(
    //   name: AppRoutes.languageModePage,
    //   page: () => LanguagePage(),
    //   // binding: LanguageBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.searchPage,
    //   page: () => SearchPage(),
    //   binding: SearchBinding(),
    //   transition: Transition.fadeIn,
    // ),
    // GetPage(
    //   name: AppRoutes.articleDetailPage,
    //   page: () => const ArticleDetailPage(),
    // ),
    // GetPage(
    //   name: AppRoutes.webDetailCommonPage,
    //   page: () => const WebDetailCommonPage(),
    // ),
    // GetPage(
    //   name: AppRoutes.loginRegisterPage,
    //   page: () => LoginRegisterPage(),
    // ),
    // GetPage(
    //   name: AppRoutes.treeTabContainerPage,
    //   page: () => const SystemContentPage(),
    //   binding: SystemContentBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.collectListPage,
    //   page: () => CollectPage(),
    //   binding: CollectBinding(),
    // ),
  ];
}
