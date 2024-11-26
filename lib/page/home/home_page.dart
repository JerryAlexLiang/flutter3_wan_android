import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/page/home/component/article_list_item_widget.dart';
import 'package:flutter3_wan_android/res/gaps.dart';
import 'package:flutter3_wan_android/widget/ripple_view.dart';
import 'package:flutter3_wan_android/widget/state/load_state.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

/// 创建日期: 2024/10/10 16:21
/// 描述: 首页
/// 作者: Jerry

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RippleView(
          onTap: ()=>{
            homeController.getHomeData()
          },
          child: const Text('Loading'),
        ),
      ),
      body: Obx(() {
        if (homeController.loadState == LoadState.simpleShimmerLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
              backgroundColor: Colors.grey,
            ),
          );
        } else if (homeController.loadState == LoadState.success) {
          return SafeArea(
            top: true,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Center(
                    child: ListView.builder(
                      itemCount: homeController.homeArticleList.length,
                      itemBuilder: (context, index) {
                        return ArticleListItemWidget(
                          dataList: homeController.homeArticleList,
                          index: index,
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        }
        return Gaps.empty;
      }),
    );
  }
}
