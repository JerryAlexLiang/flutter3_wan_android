import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/base/refresh_paging_state_page.dart';
import 'package:flutter3_wan_android/page/home2/component/new_article_list_item_widget.dart';
import 'package:get/get.dart';

import 'project_tree_children_controller.dart';

class ProjectTreeChildrenPage extends StatelessWidget {
  const ProjectTreeChildrenPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int? id;

  @override
  Widget build(BuildContext context) {
    /// Don't use one refreshController to multiple SmartRefresher,It will cause some unexpected bugs mostly in TabBarView
    /// 解决办法
    final controller =
        Get.put(ProjectTreeChildrenController(), tag: id.toString());
    // 赋值cid
    controller.setCid(id);
    // 第一次进入
    controller.onFirstInRequestData();

    return Scaffold(
      body: Obx(() {
        return SafeArea(
          child: RefreshPagingStatePage(
            controller: controller,
            refreshController: controller.refreshController,
            onPressed: () => controller.onFirstInRequestData(),
            onRefresh: () => controller.onRefreshRequestData(),
            onLoadMore: () => controller.onLoadMoreRequestData(),
            child: ListView.builder(
              controller: controller.scrollController,
              itemCount: controller.projectTreeArticleList.length,
              itemBuilder: (context, index) {
                return NewArticleListItemWidget(
                  dataList: controller.projectTreeArticleList,
                  index: index,
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
