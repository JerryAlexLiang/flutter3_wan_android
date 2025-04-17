import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/base/refresh_paging_state_page.dart';
import 'package:flutter3_wan_android/page/home2/component/new_article_list_item_widget.dart';
import 'package:flutter3_wan_android/page/home2/component/new_home_banner.dart';
import 'package:flutter3_wan_android/widget/ripple_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'home2_controller.dart';
import 'home2_state.dart';

class Home2Page extends StatelessWidget {
  Home2Page({Key? key}) : super(key: key);

  final Home2Controller home2Controller = Get.find<Home2Controller>();
  final Home2State state = Get.find<Home2Controller>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RippleView(
          onTap: () => home2Controller.onFirstInHomeData(),
          child: const Text('Home'),
        ),
      ),
      body: SafeArea(
        top: true,
        child: Stack(
          alignment: Alignment.center,
          children: [
            homeRefreshWidget(),
          ],
        ),
      ),
    );
  }

  Widget homeRefreshWidget() {
    return RefreshPagingStatePage<Home2Controller>(
      controller: home2Controller,
      onPressed: () => home2Controller.onFirstInHomeData(),
      onRefresh: () => home2Controller.onRefreshHomeData(),
      onLoadMore: () => home2Controller.onLoadMoreHomeData(),
      refreshController: home2Controller.refreshController,
      lottieRocketRefreshHeader: true,
      child: _homeScrollerView(),
    );
  }

  Widget _homeScrollerView() {
    return CustomScrollView(
      // 滑动监听器
      controller: home2Controller.scrollController,
      slivers: [
        _homeBanner(),
        _homeArticleSliverList(),
      ],
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
    );
  }

  Widget _homeBanner() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 120.h,
        child: const NewHomeBannerWidget(),
      ),
    );
  }

  Widget _homeArticleSliverList() {
    return Obx(() {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: NewArticleListItemWidget(
                dataList: state.homeArticleList,
                index: index,
              ),
            );
          },
          childCount: state.homeArticleList.length,
        ),
      );
    });
  }
}
