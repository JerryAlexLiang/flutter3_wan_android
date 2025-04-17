import 'package:get/get.dart';

import 'home2_controller.dart';

class Home2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Home2Controller());
  }
}
