import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/base/refresh_paging_state_page.dart';
import 'package:flutter3_wan_android/page/home2/component/new_article_list_item_widget.dart';
import 'package:get/get.dart';

import 'tree_article_list_controller.dart';

class TreeArticleListPage extends StatelessWidget {
  TreeArticleListPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int? id;

  @override
  Widget build(BuildContext context) {
    /// Don't use one refreshController to multiple SmartRefresher,It will cause some unexpected bugs mostly in TabBarView
    /// 解决办法
    final controller = Get.put(TreeArticleListController(), tag: id.toString());

    /// 赋值cid
    controller.setCid(id);

    /// 第一次进入
    controller.onFirstInRequestData();

    return Obx(() {
      return RefreshPagingStatePage(
        controller: controller,
        refreshController: controller.refreshController,
        onPressed: () => controller.onFirstInRequestData(),
        onRefresh: () => controller.onRefreshRequestData(),
        onLoadMore: () => controller.onLoadMoreRequestData(),
        lottieRocketRefreshHeader: false,
        child: ListView.builder(
          /// 当ListView需要ScrollController的时候，NestedScrollView就会和ListView的滚动失去关联，
          /// 此时我们只要把ScrollController换成NotificationListener
          // controller: controller.scrollController,
          itemCount: controller.treeArticleList.length,
          itemBuilder: (context, index) {
            return NewArticleListItemWidget(
              dataList: controller.treeArticleList,
              index: index,
            );
          },
        ),
      );
    });
  }
}
