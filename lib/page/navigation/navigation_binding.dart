import 'package:get/get.dart';

import 'navigation_logic.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationLogic());
  }
}
