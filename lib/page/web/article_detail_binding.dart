import 'package:get/get.dart';

import 'article_detail_controller.dart';

class ArticleDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ArticleDetailController());
  }
}
