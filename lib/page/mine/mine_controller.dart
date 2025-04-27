import 'package:flutter3_wan_android/base/base_getx_with_page_refresh_controller.dart';
import 'package:flutter3_wan_android/constant/constant.dart';
import 'package:flutter3_wan_android/http/dio_method.dart';
import 'package:flutter3_wan_android/http/dio_util.dart';
import 'package:flutter3_wan_android/http/request_api.dart';
import 'package:flutter3_wan_android/model/total_user_info_model.dart';
import 'package:flutter3_wan_android/page/login/app_user_login_state_controller.dart';
import 'package:flutter3_wan_android/util/logger_util.dart';
import 'package:flutter3_wan_android/util/sp_util.dart';
import 'package:flutter3_wan_android/widget/state/load_state.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

    //滑动监听
    scrollController.addListener(() {
      var scrollerPercent = scrollController.offset / 140;
      if (scrollerPercent < 0) {
        scrollerPercent = 0;
      } else if (scrollerPercent > 1.0) {
        scrollerPercent = 1.0;
      }
      percent = scrollerPercent;
      LoggerUtil.d('=======> 滑动监听: $percent');
    });

    appStateController.updateUserInfo();

    /// 每次登录状态发生改变时更新数据
    ever(appStateController.isLogin, (callback) {
      if (appStateController.isLogin.value) {
        getUserInfo();
      }
    });
  }

  Future<void> getUserInfo() async {
    refreshLoadState = LoadState.success;

    httpManagerWithRefreshPaging(
      loadingType: Constant.noLoading,
      future: DioUtil().request(RequestApi.getUserInfo, method: DioMethod.get),
      onSuccess: (response) {
        refreshLoadState = LoadState.success;
        var model = TotalUserInfoModel.fromJson(response);
        if (model.userInfo != null) {
          appStateController.userInfo.value = model.userInfo!;
          appStateController.coinInfo.value = model.coinInfo!;

          // 本地化存储
          SpUtil.saveUserInfo(model.userInfo!);
        }
      },
      onFail: (value) {
        refreshLoadState = LoadState.success;
        EasyLoading.showInfo('${value.message}');
      },
      onError: (error) {
        refreshLoadState = LoadState.success;
        EasyLoading.showError(error.message);
      },
    );
  }

  @override
  void onFirstInRequestData() {}

  @override
  void onLoadMoreRequestData() {}

  @override
  void onRefreshRequestData() {}
}
