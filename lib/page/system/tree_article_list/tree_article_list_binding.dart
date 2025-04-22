import 'package:get/get.dart';

import 'tree_article_list_controller.dart';

class TreeArticleListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TreeArticleListController());
  }
}
