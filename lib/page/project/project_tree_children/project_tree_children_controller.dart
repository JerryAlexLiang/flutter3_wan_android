import 'package:flutter3_wan_android/base/base_getx_with_page_refresh_controller.dart';
import 'package:flutter3_wan_android/constant/constant.dart';
import 'package:flutter3_wan_android/http/dio_method.dart';
import 'package:flutter3_wan_android/http/dio_util.dart';
import 'package:flutter3_wan_android/http/request_api.dart';
import 'package:flutter3_wan_android/model/ProjectListModel.dart';
import 'package:flutter3_wan_android/model/article_item_bean.dart';
import 'package:flutter3_wan_android/util/logger_util.dart';
import 'package:flutter3_wan_android/widget/state/load_state.dart';
import 'package:get/get.dart';
import 'package:sprintf/sprintf.dart';

/// 创建日期: 2025/04/21 14:32
/// 作者: Jerry
/// 描述: 项目分类下的子页面分页数据

class ProjectTreeChildrenController extends BaseGetXWithPageRefreshController {
  // cid 分类的id，项目分类接口
  final Rx<int?> cid = 0.obs;

  // 分类项目列表
  final projectTreeArticleList = RxList<ArticleItemBean>();

  void setCid(int? cid) {
    this.cid.value = cid;
  }

  @override
  void onInit() {
    super.onInit();
    loadState = LoadState.lottieRocketLoading;
    // 项目列表数据 页码：拼接在链接中，从1开始
    currentPage = 1;
  }

  /// 第一次进入
  @override
  void onFirstInRequestData() {
    getProjectChildrenList(
      loadingType: Constant.multipleShimmerLoading,
      refreshState: RefreshState.first,
      cid: cid.value,
    );
  }

  /// 上滑加载更多
  @override
  void onLoadMoreRequestData() {
    getProjectChildrenList(
      loadingType: Constant.noLoading,
      refreshState: RefreshState.loadMore,
      cid: cid.value,
    );
  }

  /// 下拉刷新
  @override
  void onRefreshRequestData() {
    getProjectChildrenList(
      loadingType: Constant.noLoading,
      refreshState: RefreshState.refresh,
      cid: cid.value,
    );
  }

  /// 项目分类下的文章
  Future<void> getProjectChildrenList({
    required String loadingType,
    required RefreshState refreshState,
    required int? cid,
  }) async {
    if (refreshState == RefreshState.refresh ||
        refreshState == RefreshState.first) {
      /// 下拉刷新  项目列表数据 页码：拼接在链接中，从1开始。
      currentPage = 1;
    }
    if (refreshState == RefreshState.loadMore) {
      /// 上滑加载更多
      currentPage++;
    }

    String requestUrl =
        sprintf(RequestApi.projectTreeChildrenList, [currentPage]);

    httpManagerWithRefreshPaging(
      loadingType: loadingType,
      refreshState: refreshState,
      future: DioUtil()
          .request(requestUrl, params: {"cid": cid}, method: DioMethod.get),
      onSuccess: (response) {
        ProjectListModel projectListModel = ProjectListModel.fromJson(response);
        List<ArticleItemBean>? dataList = projectListModel.datas;
        // 加载到底部判断
        var over = projectListModel.over;
        if (over != null && over) {
          loadNoData();
        }

        // 模拟空数据
        if (cid == 539) {
          dataList = null;
        }

        if (dataList != null && dataList.isNotEmpty) {
          loadState = LoadState.success;
          refreshLoadState = LoadState.success;

          /// 循环遍历 装载 可观察变量 isCollect
          for (var element in dataList) {
            var collect = element.collect;
            element.isCollect = collect;
          }

          if (refreshState == RefreshState.first ||
              refreshState == RefreshState.refresh) {
            projectTreeArticleList.assignAll(dataList);
          } else if (refreshState == RefreshState.loadMore) {
            projectTreeArticleList.addAll(dataList);
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
            tag: "ProjectTreeArticleListPageViewController");
      },
      onError: (value) {
        LoggerUtil.e(value.message,
            tag: "ProjectTreeArticleListPageViewController");
      },
    );
  }
}
