import 'package:flutter3_wan_android/model/article_item_bean.dart';
import 'package:flutter3_wan_android/model/home_banner_model.dart';
import 'package:get/get.dart';

/// 创建日期: 2025/04/16 14:35
/// 作者: Jerry
/// 描述: State类，管理所有可观察状态
/// 单独定义状态类，包含所有可观察的状态变量（Rx变量），用于UI绑定。

class Home2State {
  // /// 下拉刷新控制器
  // late RefreshController refreshController;
  //
  // /// 是否初始刷新
  // final RxBool _initialRefresh = false.obs;
  //
  // get initialRefresh => _initialRefresh.value;
  //
  // set initialRefresh(value) => _initialRefresh.value = value;
  //
  // /// 加载状态
  // final Rx<LoadState> _loadState = LoadState.simpleShimmerLoading.obs;
  //
  // get loadState => _loadState.value;
  //
  // set loadState(value) => _loadState.value = value;
  //
  // //滚动控制器
  // late ScrollController scrollController;
  //
  // /// 当前页数
  // int currentPage = 0;

  /// 首页文章列表
  final RxList<ArticleItemBean> homeArticleList = RxList<ArticleItemBean>();

  /// 首页Banner列表
  final RxList<HomeBannerModel> homeBannerList = RxList<HomeBannerModel>();

  Home2State() {
    // // 刷新监听器
    // refreshController = RefreshController(initialRefresh: initialRefresh);
    // // 滑动监听器
    // scrollController = ScrollController();
  }

// void dispose() {
//   scrollController.dispose();
//   refreshController.dispose();
// }
}
