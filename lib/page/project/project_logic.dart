import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/base/base_getx_with_page_refresh_controller.dart';
import 'package:flutter3_wan_android/constant/constant.dart';
import 'package:flutter3_wan_android/http/dio_method.dart';
import 'package:flutter3_wan_android/http/dio_util.dart';
import 'package:flutter3_wan_android/http/request_api.dart';
import 'package:flutter3_wan_android/model/tree_model.dart';
import 'package:flutter3_wan_android/util/logger_util.dart';
import 'package:flutter3_wan_android/widget/state/load_state.dart';
import 'package:get/get.dart';

/// 创建日期: 2025/04/18 14:09
/// 作者: Jerry
/// 描述: 项目分类-Tab数组
/// GetSingleTickerProviderStateMixin像SingleTickerProviderMixin一样使用，但只用于Get控制器。简化了GetxController中的AnimationController创建。
class ProjectLogic extends BaseGetXWithPageRefreshController
    with GetSingleTickerProviderStateMixin {
  /// 项目分类
  // final projectTreeTabList = List<TreeModel>.empty(growable: true).obs;
  final projectTreeTabList = RxList<TreeModel>();

  /// TabBar索引
  // var projectTabIndex = 0;

  late TabController tabController;

  static String get tag => "ProjectLogic";

  @override
  void onInit() {
    LoggerUtil.d('onInit', tag: tag);
    initProjectTreeList();
    super.onInit();
  }

  @override
  void onReady() {
    LoggerUtil.d('onReady', tag: tag);
    super.onReady();
  }

  /// 初始化TabController
  // with GetSingleTickerProviderStateMixin
  void initTabController() {
    tabController = TabController(
      length: projectTreeTabList.length,
      initialIndex: 0,
      vsync: this,
    );
  }

  // 初始化列表数据
  Future<void> initProjectTreeList() async {
    httpManager(
      loadingType: Constant.lottieRocketLoading,
      future: DioUtil().request(RequestApi.projectTree, method: DioMethod.get),
      onSuccess: (response) {
        ///列表转换的时候一定要加一下强转List<dynamic>，否则会报错
        List<TreeModel> dataList = (response as List<dynamic>)
            .map((e) => TreeModel.fromJson(e))
            .toList();

        projectTreeTabList.assignAll(dataList);

        if (projectTreeTabList.isNotEmpty) {
          loadState = LoadState.success;
          // 初始化TabController
          initTabController();
        } else {
          loadState = LoadState.empty;
        }
      },
      onFail: (value) {
        loadState = LoadState.fail;
      },
      onError: (value) {
        loadState = LoadState.fail;
      },
    );
  }
}
