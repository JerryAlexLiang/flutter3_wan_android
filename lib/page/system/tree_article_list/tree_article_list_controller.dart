import 'package:flutter3_wan_android/base/base_getx_with_page_refresh_controller.dart';
import 'package:flutter3_wan_android/constant/constant.dart';
import 'package:flutter3_wan_android/http/dio_method.dart';
import 'package:flutter3_wan_android/http/dio_util.dart';
import 'package:flutter3_wan_android/http/request_api.dart';
import 'package:flutter3_wan_android/model/article_item_bean.dart';
import 'package:flutter3_wan_android/model/article_page_bean.dart';
import 'package:flutter3_wan_android/util/logger_util.dart';
import 'package:flutter3_wan_android/widget/state/load_state.dart';
import 'package:get/get.dart';
import 'package:sprintf/sprintf.dart';

/// 创建日期: 2025/04/22 16:46
/// 作者: Jerry
/// 描述: 体系二级页面-文章列表

class TreeArticleListController extends BaseGetXWithPageRefreshController {
  final treeArticleList = RxList<ArticleItemBean>();

  final Rx<int?> cid = 0.obs;

  void setCid(int? id) {
    cid.value = id;
  }

  /// 第一次进入
  @override
  void onFirstInRequestData() {
    requestTreeChildrenArticleListData(
      loadingType: Constant.multipleShimmerLoading,
      refreshState: RefreshState.first,
      cid: cid.value,
    );
  }

  /// 上滑加载更多
  @override
  void onLoadMoreRequestData() {
    requestTreeChildrenArticleListData(
      loadingType: Constant.noLoading,
      refreshState: RefreshState.loadMore,
      cid: cid.value,
    );
  }

  /// 下拉刷新首页
  @override
  void onRefreshRequestData() {
    requestTreeChildrenArticleListData(
      loadingType: Constant.noLoading,
      refreshState: RefreshState.refresh,
      cid: cid.value,
    );
  }

  /// 体系下的文章列表数据
  Future<void> requestTreeChildrenArticleListData({
    required String loadingType,
    required RefreshState refreshState,
    required int? cid,
  }) async {
    if (refreshState == RefreshState.refresh ||
        refreshState == RefreshState.first) {
      /// 下拉刷新 页码：拼接在链接中，从0开始。
      currentPage = 0;
    }
    if (refreshState == RefreshState.loadMore) {
      /// 上滑加载更多
      currentPage++;
    }

    // https://www.wanandroid.com/article/list/0/json?cid=60
    String requestUrl =
        sprintf(RequestApi.treeChildrenArticleList, [currentPage]);

    httpManagerWithRefreshPaging(
      loadingType: loadingType,
      refreshState: refreshState,
      future: DioUtil()
          .request(requestUrl, params: {"cid": cid}, method: DioMethod.get),
      onSuccess: (response) {
        ArticlePageBean articlePageBean = ArticlePageBean.fromJson(response);
        List<ArticleItemBean>? dataList = articlePageBean.datas;

        // 加载到底部判断
        var over = articlePageBean.over;
        if (over != null) {
          if (over) {
            loadNoData();
          }
        }

        if (dataList != null && dataList.isNotEmpty) {
          refreshLoadState = LoadState.success;

          /// 循环遍历 装载 可观察变量 isCollect
          for (var element in dataList) {
            var collect = element.collect;
            element.isCollect = collect;
          }

          if (refreshState == RefreshState.first) {
            treeArticleList.assignAll(dataList);
          } else if (refreshState == RefreshState.refresh) {
            treeArticleList.assignAll(dataList);
          } else if (refreshState == RefreshState.loadMore) {
            treeArticleList.addAll(dataList);
          }
        } else {
          if (loadingType != Constant.noLoading) {
            refreshLoadState = LoadState.empty;
          } else {
            loadNoData();
          }
        }
      },
      onFail: (value) {
        LoggerUtil.e("${value.message}",
            tag: "TreeArticleListPageViewController");
      },
      onError: (error) {
        LoggerUtil.e(error.message, tag: "TreeArticleListPageViewController");
      },
    );
  }
}
