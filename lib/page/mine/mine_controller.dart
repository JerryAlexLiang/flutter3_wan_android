import 'package:flutter3_wan_android/base/base_getx_with_page_refresh_controller.dart';
import 'package:flutter3_wan_android/widget/state/load_state.dart';
import 'package:get/get.dart';

/// state只专注数据，需要使用数据，直接通过state获取
/// logic只专注于触发事件交互，操作或更新数据
/// view只专注UI显示
/// logic层 实例化状态类，以便操作所有的变量
class MineController extends BaseGetXWithPageRefreshController {

  @override
  void onInit() {
    super.onInit();
    refreshLoadState = LoadState.success;
  }

  @override
  void onFirstInRequestData() {
  }

  @override
  void onLoadMoreRequestData() {
  }

  @override
  void onRefreshRequestData() {
  }
}
