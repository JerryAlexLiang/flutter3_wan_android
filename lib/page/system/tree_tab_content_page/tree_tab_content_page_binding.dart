import 'package:get/get.dart';

import 'tree_tab_content_page_controller.dart';

class TreeTabContentPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TreeTabContentPageController());
  }
}
