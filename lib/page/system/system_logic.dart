import 'package:flutter3_wan_android/base/base_getx_with_page_refresh_controller.dart';
import 'package:flutter3_wan_android/constant/constant.dart';
import 'package:flutter3_wan_android/http/dio_method.dart';
import 'package:flutter3_wan_android/http/dio_util.dart';
import 'package:flutter3_wan_android/http/request_api.dart';
import 'package:flutter3_wan_android/model/tree_model.dart';
import 'package:flutter3_wan_android/widget/state/load_state.dart';
import 'package:get/get.dart';

/// 创建日期: 2025/04/22 10:55
/// 作者: Jerry
/// 描述: 体系相关逻辑

class SystemLogic extends BaseGetXWithPageRefreshController {
  // 体系数据列表
  final systemTreeList = RxList<TreeModel>();

  @override
  void onReady() {
    super.onReady();
    onFirstInRequestData();
  }

  /// 加载体系数据
  Future<void> requestSystemTreeData({
    required String loadingType,
    required RefreshState refreshState,
  }) async {
    loadState = LoadState.lottieRocketLoading;

    httpManagerWithRefreshPaging(
      loadingType: loadingType,
      refreshState: refreshState,
      future: DioUtil().request(RequestApi.treeList, method: DioMethod.get),
      onSuccess: (response) {
        refreshLoadState = LoadState.success;

        /// 列表转换的时候一定要加一下强转List<dynamic>，否则会报错
        List<TreeModel> dataList = (response as List<dynamic>)
            .map((e) => TreeModel.fromJson(e))
            .toList();
        systemTreeList.assignAll(dataList);
      },
      onFail: (value) {
        refreshLoadState = LoadState.fail;
      },
      onError: (value) {
        refreshLoadState = LoadState.fail;
      },
    );
  }

  @override
  void onFirstInRequestData() {
    requestSystemTreeData(
      loadingType: Constant.lottieRocketLoading,
      refreshState: RefreshState.first,
    );
  }

  @override
  void onLoadMoreRequestData() {}

  @override
  void onRefreshRequestData() {
    requestSystemTreeData(
      loadingType: Constant.noLoading,
      refreshState: RefreshState.refresh,
    );
  }
}
