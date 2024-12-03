import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/page/home/component/article_list_item_widget.dart';
import 'package:flutter3_wan_android/page/home/component/home_banner.dart';
import 'package:flutter3_wan_android/res/gaps.dart';
import 'package:flutter3_wan_android/widget/ripple_view.dart';
import 'package:flutter3_wan_android/widget/state/load_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
          onTap: () => homeController.onFirstInHomeData(),
          child: const Text('Home'),
        ),
      ),
      body: Obx(() {
        if (homeController.loadState == LoadState.simpleShimmerLoading) {
          return loadingWidget();
        } else if (homeController.loadState == LoadState.fail) {
          return failPageWidget();
        } else if (homeController.loadState == LoadState.empty) {
          return emptyPageWidget();
        } else if (homeController.loadState == LoadState.success) {
          return SafeArea(
            top: true,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Center(
                    // child: _homeArticleList(),
                    child: SmartRefresher(
                      controller: homeController.refreshController,
                      enablePullDown: true,
                      enablePullUp: true,
                      onRefresh: homeController.onRefreshHomeData,
                      onLoading: () => homeController.onLoadMoreHomeData(),
                      child: _homeScrollerView(),
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

  Widget emptyPageWidget() {
    return RippleView(
      onTap: () => homeController.onFirstInHomeData(),
      child: const Center(
        child: Text('EmptyView'),
      ),
    );
  }

  RippleView failPageWidget() {
    return RippleView(
      onTap: () => homeController.onFirstInHomeData(),
      child: const Center(
        child: Text('FailView'),
      ),
    );
  }

  Center loadingWidget() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.red,
        backgroundColor: Colors.grey,
      ),
    );
  }

  Widget _homeScrollerView() {
    return CustomScrollView(
      // 滑动监听器
      controller: homeController.scrollController,
      slivers: [
        _homeBanner(),
        _homeArticleList(),
      ],
    );
  }

  Widget _homeArticleList() {
    // return ListView.builder(
    //   itemCount: controller.homeArticleList.length,
    //   itemBuilder: (context, index) {
    //     return ArticleListItemWidget(
    //       dataList: homeController.homeArticleList,
    //       index: index,
    //     );
    //   },
    // );

    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: ArticleListItemWidget(
            dataList: homeController.homeArticleList,
            index: index,
          ),
        );
      },
      childCount: homeController.homeArticleList.length,
    ));
  }

  Widget _homeBanner() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 120.h,
        child: const HomeBannerWidget(),
      ),
    );
  }
}
