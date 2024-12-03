import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/constant/constant.dart';
import 'package:flutter3_wan_android/http/base_response.dart';
import 'package:flutter3_wan_android/http/dio_method.dart';
import 'package:flutter3_wan_android/http/dio_util.dart';
import 'package:flutter3_wan_android/http/request_api.dart';
import 'package:flutter3_wan_android/model/article_item_bean.dart';
import 'package:flutter3_wan_android/model/article_page_bean.dart';
import 'package:flutter3_wan_android/model/home_banner_model.dart';
import 'package:flutter3_wan_android/util/logger_util.dart';
import 'package:flutter3_wan_android/widget/state/load_state.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  /// 下拉刷新控制器
  late RefreshController _refreshController;

  RefreshController get refreshController => _refreshController;

  final _initialRefresh = false.obs;

  get initialRefresh => _initialRefresh.value;

  set initialRefresh(value) => _initialRefresh.value = value;

  /// 加载状态
  final _loadState = LoadState.simpleShimmerLoading.obs;

  get loadState => _loadState.value;

  set loadState(value) => _loadState.value = value;

  //滚动控制器
  late ScrollController scrollController;

  /// 当前页数
  int currentPage = 0;

  /// 首页文章列表
  final homeArticleList = RxList<ArticleItemBean>();

  /// 首页Banner列表
  final homeBannerList = RxList<HomeBannerModel>();

  @override
  void onInit() {
    super.onInit();
    // 滑动监听器
    scrollController = ScrollController();
    // 刷新监听器
    _refreshController = RefreshController(initialRefresh: initialRefresh);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    _refreshController.dispose();
  }

  @override
  void onReady() {
    super.onReady();
    // 第一次进入首页
    onFirstInHomeData();
  }

  Future<void> getHomeData({
    required String loadingType,
    required RefreshState refreshState,
  }) async {
    if (refreshState == RefreshState.refresh ||
        refreshState == RefreshState.first) {
      /// 下拉刷新
      // currentPage = 0;
      currentPage = 1581;
      // currentPage = 1590;

      // 获取首页Banner数据源
      getHomeBannerData();
    }
    if (refreshState == RefreshState.loadMore) {
      /// 上滑加载更多
      currentPage++;
    }
    LoggerUtil.d('============> getHomeData() $currentPage',
        tag: 'HomeController');

    // 获取首页文章列表
    getHomeArticleList(loadingType, refreshState);
  }

  /// 没有更多数据了
  void loadNoData() {
    loadState = LoadState.success;
    _refreshController.loadNoData();
  }

  Future<void> getHomeArticleList(
      String loadingType, RefreshState refreshState) async {
    loadState = LoadState.simpleShimmerLoading;

    // https://www.wanandroid.com/article/list/0/json
    String requestUrl =
        RequestApi.homeArticleList.replaceFirst(RegExp('page'), '$currentPage');

    //
    // // 使用泛型基类BasePageListResponse<T> + PageList<T>去解析返回分页List数组类型的JOSN数据
    // BaseResponse response =
    //     await DioUtil().request(requestUrl, method: DioMethod.get);

    // https://www.wanandroid.com/project/list/1/json?cid=294
    // var dio = Dio();
    // var request = await dio.request("https://www.wanandroid.com/article/list/0/json");
    // var request = await dio.request("https://www.wanandroid.com/project/list/1/json?cid=294");
    // var statusCode = request.statusCode;
    // if (statusCode == 200) {
    //   loadState = LoadState.success;
    //
    //   var articlePageBean = ArticleTestBean.fromJson(request.data);
    //
    //   List<ArticleItemBean> datas = articlePageBean.data.datas;
    //   datas[0].fresh = true;
    //   datas[1].fresh = true;
    //   datas[2].fresh = true;
    //   datas[3].fresh = true;
    //   datas[4].fresh = true;
    //   datas[5].fresh = true;
    //   if (datas.isNotEmpty) {
    //     homeArticleList.addAll(datas);
    //   }
    //
    //   LoggerUtil.d(tag: "DioRequest", "==============>1 $request");
    //
    //   LoggerUtil.d(
    //       tag: "DioRequest", "==============>2 ${jsonEncode(request.data)}");
    //
    //   LoggerUtil.d(
    //       tag: "DioRequest", "==============>3 ${jsonEncode(articlePageBean)}");
    // } else {
    //   loadState = LoadState.fail;
    // }

    /// 是否显示加载页面，及加载页面类型
    if (loadingType == Constant.showLoadingDialog) {
      EasyLoading.show(status: 'loading...');
    } else if (loadingType == Constant.simpleShimmerLoading) {
      loadState = LoadState.simpleShimmerLoading;
    } else if (loadingType == Constant.multipleShimmerLoading) {
      loadState = LoadState.multipleShimmerLoading;
    } else if (loadingType == Constant.lottieRocketLoading) {
      loadState = LoadState.lottieRocketLoading;
    } else if (loadingType == Constant.noLoading) {
      loadState = LoadState.success;
      // return;
    }

    try {
      // https://www.wanandroid.com/article/list/0/json/?page_size=3
      BaseResponse response = await DioUtil().request(requestUrl,
          params: {"page_size": 10}, method: DioMethod.get);

      var success = response.success;
      if (success != null) {
        if (success) {
          var data = response.data;
          var articlePageBean = ArticlePageBean.fromJson(data);
          List<ArticleItemBean>? datas = articlePageBean.datas;

          // 加载到底部最后一页判断
          var over = articlePageBean.over;
          if (over != null && over == true) {
            loadNoData();
          }

          if (datas != null && datas.isNotEmpty) {
            loadState = LoadState.success;

            /// 非第一次加载，返回数据为空，则不显示空页面
            refreshLoadingSuccess(refreshState);

            if (refreshState == RefreshState.first ||
                refreshState == RefreshState.refresh) {
              datas[0].fresh = true;
              datas[1].fresh = true;
              datas[2].fresh = true;
              datas[3].fresh = true;
              datas[4].fresh = true;
              datas[5].fresh = true;
              homeArticleList.assignAll(datas);
            }
            // else if (refreshState == RefreshState.refresh) {
            //   homeArticleList.assignAll(datas);
            // }
            else if (refreshState == RefreshState.loadMore) {
              homeArticleList.addAll(datas);
            }
          } else {
            if (loadingType != Constant.noLoading) {
              loadState = LoadState.empty;
            } else {
              loadNoData();
            }
          }

          LoggerUtil.d(tag: "DioRequest", "==============>1 $response");

          LoggerUtil.d(
              tag: "DioRequest", "==============>2 ${jsonEncode(data)}");

          LoggerUtil.d(
              tag: "DioRequest",
              "==============>3 ${jsonEncode(articlePageBean)}");
        } else {
          loadState = LoadState.fail;
          Fluttertoast.showToast(
              msg: '数据请求失败 ${response.code}  ${response.message}');
        }
      }
    } on DioException catch (e) {
      loadState = LoadState.fail;
      Fluttertoast.showToast(msg: '数据请求失败 ${e.error}  ${e.message}');
    }
  }

  /// 第一次进入首页
  void onFirstInHomeData() {
    LoggerUtil.d('============> onFirstInHomeData()', tag: 'HomeController');
    getHomeData(
      loadingType: Constant.simpleShimmerLoading,
      refreshState: RefreshState.first,
    );
  }

  /// 下拉刷新首页
  void onRefreshHomeData() {
    LoggerUtil.d('============> onRefreshHomeData()', tag: 'HomeController');
    getHomeData(
      loadingType: Constant.noLoading,
      refreshState: RefreshState.refresh,
    );
  }

  /// 上滑加载更多
  void onLoadMoreHomeData() {
    LoggerUtil.d('============> onLoadMoreHomeData()', tag: 'HomeController');
    getHomeData(
      loadingType: Constant.noLoading,
      refreshState: RefreshState.loadMore,
    );
  }

  /// RefreshController刷新、加载成功
  void refreshLoadingSuccess(RefreshState refreshState) {
    if (refreshState == RefreshState.refresh) {
      _refreshController.refreshCompleted(resetFooterState: true);
    } else if (refreshState == RefreshState.loadMore) {
      _refreshController.loadComplete();
    }
  }

  Future<void> getHomeBannerData() async {
    BaseResponse response =
        await DioUtil().request(RequestApi.homeBanner, method: DioMethod.get);
    //拿到res.data就可以进行Json解析了，这里一般用来构造实体类
    var success = response.success;
    if (success != null) {
      if (success) {
        refreshLoadingSuccess(RefreshState.refresh);

        ///列表转换的时候一定要加一下强转List<dynamic>，否则会报错
        List<HomeBannerModel> bannerList = (response.data as List<dynamic>)
            .map((e) => HomeBannerModel.fromJson(e))
            .toList();
        homeBannerList.assignAll(bannerList);
      }
    }
  }
}
