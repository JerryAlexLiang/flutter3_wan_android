import 'package:flutter3_wan_android/base/base_getx_controller.dart';
import 'package:flutter3_wan_android/constant/constant.dart';
import 'package:flutter3_wan_android/http/dio_method.dart';
import 'package:flutter3_wan_android/http/dio_util.dart';
import 'package:flutter3_wan_android/http/request_api.dart';
import 'package:flutter3_wan_android/model/article_item_bean.dart';
import 'package:flutter3_wan_android/model/navigation_model.dart';
import 'package:flutter3_wan_android/util/logger_util.dart';
import 'package:get/get.dart';

class NavigationLogic extends BaseGetXController {
  /// 左侧导航栏
  final navigationGroupList = RxList<NavigationModel?>();

  /// 当前选中右侧区域
  final Rx<NavigationModel?> currentNavigation = NavigationModel().obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    // 初始化导航数据
    initNavigationData();
  }

  /// 点击切换导航
  void changeNavigation(NavigationModel? model) {
    currentNavigation.value = model;
  }

  /// 初始化导航数据
  Future<void> initNavigationData() async {
    httpManager(
      loadingType: Constant.lottieRocketLoading,
      future:
          DioUtil().request(RequestApi.navigationList, method: DioMethod.get),
      onSuccess: (response) {
        ///列表转换的时候一定要加一下强转List<dynamic>，否则会报错
        List<NavigationModel> list = (response as List<dynamic>)
            .map((e) => NavigationModel.fromJson(e))
            .toList();

        /// 循环遍历 装载 可观察变量 isCollect
        if (list.isNotEmpty) {
          for (var value in list) {
            List<ArticleItemBean>? articles = value.articles;

            if (articles != null && articles.isNotEmpty) {
              for (var article in articles) {
                bool? collect = article.collect;
                article.isCollect = collect;
              }
            }
          }
        }

        // 模拟清除最后一条列表数据
        list.last.articles = null;

        // 填好列表数据
        navigationGroupList.assignAll(list);

        if (navigationGroupList.isNotEmpty) {
          // 默认定位到第一个导航栏
          currentNavigation.value = navigationGroupList.first;
        }
      },
      onFail: (value) {
        LoggerUtil.e("onFail: ${value.message}",
            tag: "NavigationTreeController");
      },
      onError: (value) {
        LoggerUtil.e("onError: ${value.message}",
            tag: "NavigationTreeController");
      },
    );
  }
}
