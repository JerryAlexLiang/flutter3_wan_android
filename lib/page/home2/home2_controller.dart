import 'package:flutter3_wan_android/base/base_getx_with_page_refresh_controller.dart';
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
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'home2_state.dart';

/// 创建日期: 2025/04/16 14:46
/// 作者: Jerry
/// 描述: Controller类，负责业务逻辑和数据请求
class Home2Controller extends BaseGetXWithPageRefreshController {
  final Home2State state = Home2State();

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
      currentPage = 0;
      // currentPage = 1581;
      // currentPage = 1590;

      // 获取首页Banner数据源
      getHomeBannerData();
    }
    if (refreshState == RefreshState.loadMore) {
      /// 上滑加载更多
      currentPage++;
    }
    LoggerUtil.d('============> getHomeData() currentPage : $currentPage',
        tag: 'HomeController');

    // 获取首页文章列表
    getHomeArticleList(loadingType, refreshState);
  }

  /// 获取首页文章列表  GET https://www.wanandroid.com/article/list/0/json
  /// 参数：页码，拼接在连接中，从0开始。
  Future<void> getHomeArticleList(
      String loadingType, RefreshState refreshState) async {
    loadState = LoadState.simpleShimmerLoading;

    // https://www.wanandroid.com/article/list/0/json
    String requestUrl =
        RequestApi.homeArticleList.replaceFirst(RegExp('page'), '$currentPage');

    /// 带分页加载下拉刷新的请求，适用于ListView等
    httpManagerWithRefreshPaging(
      loadingType: loadingType,
      refreshState: refreshState,
      future: DioUtil().request(requestUrl, method: DioMethod.get),
      onSuccess: (response) {
        var articlePageBean = ArticlePageBean.fromJson(response);
        List<ArticleItemBean>? dataList = articlePageBean.datas;

        // 加载到底部最后一页判断
        var over = articlePageBean.over;
        if (over != null && over == true) {
          loadNoData();
        }

        if (dataList != null && dataList.isNotEmpty) {
          refreshLoadState = LoadState.success;
          // 非第一次加载，返回数据为空，则不显示空页面
          refreshLoadingSuccess(refreshState);

          /// 循环遍历 装载 可观察变量 isCollect
          for (var element in dataList) {
            var collect = element.collect;
            element.isCollect = collect;
          }

          if (refreshState == RefreshState.first ||
              refreshState == RefreshState.refresh) {
            // 设置前六位为最新项目
            for (int i = 0; i < dataList.length && i < 6; i++) {
              dataList[i].fresh = true;
            }
            state.homeArticleList.assignAll(dataList);
          } else if (refreshState == RefreshState.loadMore) {
            state.homeArticleList.addAll(dataList);
          }
        } else {
          if (loadingType != Constant.noLoading) {
            refreshLoadState = LoadState.empty;
          } else {
            loadNoData();
          }
        }
      },
      onFail: (error) {
        refreshLoadState = LoadState.fail;
        Fluttertoast.showToast(msg: '数据请求失败 ${error.code}  ${error.message}');
      },
      onError: (error) {
        refreshLoadState = LoadState.fail;
        Fluttertoast.showToast(msg: '数据请求失败 ${error.code}  ${error.message}');
      },
    );
  }

  Future<void> getHomeBannerData() async {
    BaseResponse response =
        await DioUtil().request(RequestApi.homeBanner, method: DioMethod.get);
    //拿到res.data就可以进行Json解析了，这里一般用来构造实体类
    var success = response.success;
    if (success != null && success) {
      refreshLoadingSuccess(RefreshState.refresh);

      /// 列表转换的时候一定要加一下强转List<dynamic>，否则会报错
      /// 在Flutter中，当你从一个数据源（如API或数据库）获取数据并希望将其转换为一个特定类型的列表时，通常需要进行类型转换。
      /// 这是因为Dart是一种强类型语言，它要求在编译时知道每个变量的确切类型。
      /// 此处从一个API获取了一个JSON数组，并希望将其转换为一个List<HomeBannerModel>，其中HomeBannerModel是你定义的一个Dart类。
      /// JSON解析器（如dart:convert库中的jsonDecode函数）通常会将JSON数组解析为List<dynamic>，因为JSON本身是无类型的。
      /// 为了确保类型安全并避免运行时错误，你需要将这个List<dynamic>显式转换为List<HomeBannerModel>。
      /// 在这个例子中，jsonDecode将JSON字符串解析为List<dynamic>。然后，我们通过map函数将每个动态元素转换为HomeBannerModel实例，并将结果转换回列表。
      /// 这种类型转换确保了在使用myList时，Dart知道它是一个List<HomeBannerModel>，从而可以在编译时进行类型检查，减少运行时错误的可能性。
      /// 如果你不进行这种类型转换，Dart编译器将无法确定列表中元素的具体类型，这可能会导致类型安全问题和运行时错误。因此，在处理从外部来源获取的数据时，
      /// 进行适当的类型转换是一个良好的实践。

      LoggerUtil.d(
          'getHomeBannerData  success ====> code: ${response.code}  message: ${response.message} \n data: ${response.data}');

      List<HomeBannerModel> bannerList = (response.data as List<dynamic>)
          .map((e) => HomeBannerModel.fromJson(e))
          .toList();
      state.homeBannerList.assignAll(bannerList);
    }
  }

  /// 第一次进入首页
  void onFirstInHomeData() {
    LoggerUtil.d('============> onFirstInHomeData()', tag: 'HomeController');
    getHomeData(
      loadingType: Constant.simpleShimmerLoading,
      // loadingType: Constant.multipleShimmerLoading,
      // loadingType: Constant.lottieRocketLoading,
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
}
