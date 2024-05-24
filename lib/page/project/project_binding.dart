import 'package:get/get.dart';

import 'project_logic.dart';

class ProjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProjectLogic());
  }
}
