import 'package:get/get.dart';

import 'system_logic.dart';

class SystemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SystemLogic());
  }
}
