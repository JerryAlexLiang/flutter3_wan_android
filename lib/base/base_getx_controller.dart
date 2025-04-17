/// 创建日期: 2024/12/06 16:04
/// 作者: Jerry
/// 描述: 基于GetX的 BaseGetController

import 'package:flutter3_wan_android/constant/constant.dart';
import 'package:flutter3_wan_android/http/base_response.dart';
import 'package:flutter3_wan_android/http/handle_dio_error.dart';
import 'package:flutter3_wan_android/util/connectivity_utils.dart';
import 'package:flutter3_wan_android/util/logger_util.dart';
import 'package:flutter3_wan_android/widget/state/load_state.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class BaseGetXController extends GetxController {
  /// 加载状态
  final _loadState = LoadState.simpleShimmerLoading.obs;

  set loadState(value) => _loadState.value = value;

  get loadState => _loadState.value;

  /// 错误提示
  final _httpErrorMsg = ''.obs;

  set httpErrorMsg(value) => _httpErrorMsg.value = value;

  get httpErrorMsg => _httpErrorMsg.value;

  @override
  void onReady() async {
    super.onReady();
    // 检查当前状态
    var connectivityState = await ConnectivityUtils.checkConnectivity();
    LoggerUtil.d('BaseGetController ==> checkConnectivity $connectivityState');

    if (connectivityState != ConnectivityState.none) {
      onReadyInitData();
      LoggerUtil.d('BaseGetController ==> onReady() initData');
    } else {
      LoggerUtil.d('BaseGetController ==> onReady() errorNet');
      // 延迟1秒 显示加载loading
      await Future.delayed(const Duration(seconds: 1));
      Get.snackbar('提示', '网络异常，请检查你的网络!');
      loadState = LoadState.fail;
      httpErrorMsg = '网络异常，请检查你的网络';
    }
  }

  /// onReady() 时期请求数据
  void onReadyInitData() {}

  /// 网络请求封装
  /// loadingType：加载类型
  /// future：网络请求
  /// onStart：开始请求
  /// onSuccess：请求成功回调
  /// onFail：请求失败回调
  /// onError：请求错误回调
  void httpManager({
    required String loadingType,
    required Future<dynamic> future,
    Function()? onStart,
    required Function(dynamic value) onSuccess,
    required Function(BaseResponse value) onFail,
    required Function(ResultException value)? onError,
  }) async {
    /// 是否显示加载页面、加载页面类型
    if (loadingType == Constant.showLoadingDialog) {
      /// 页面上加载Loading
      EasyLoading.show(status: 'loading...');
    } else if (loadingType == Constant.simpleShimmerLoading) {
      /// 覆盖页面-简单Shimmer动画
      loadState = LoadState.simpleShimmerLoading;
    } else if (loadingType == Constant.multipleShimmerLoading) {
      /// 覆盖页面-列表Shimmer动画
      loadState = LoadState.multipleShimmerLoading;
    } else if (loadingType == Constant.lottieRocketLoading) {
      loadState = LoadState.lottieRocketLoading;
    } else if (loadingType == Constant.noLoading) {
      loadState = LoadState.success;
      // return;
    }

    if (onStart != null) {
      onStart();
    }

    // await Future.delayed(const Duration(seconds: 1000));

    future.then((value) {
      LoggerUtil.d('BaseGetController ==> start handleRequest');

      /// 网络请求成功
      BaseResponse response = value;
      //拿到res.data就可以进行Json解析了，这里一般用来构造实体类
      var success = response.success;
      if (success != null) {
        if (success) {
          dismissEasyLoading();

          /// 请求成功
          var data = response.data;
          if (data != null) {
            loadState = LoadState.success;

            /// 在onSuccess()中也要判断具体的业务数据是否为空
            onSuccess(data);
          } else {
            loadState = LoadState.empty;
            dismissEasyLoading();
            onSuccess(data);
          }
          LoggerUtil.d(
              'BaseGetController handleRequest success ====> code: ${response.code}  message: ${response.message} \n data: $data');
        } else {
          /// 请求失败
          loadState = LoadState.fail;
          dismissEasyLoading();
          // 外部方法在后，可在方法里根据业务更改状态
          onFail(response);
          LoggerUtil.e(
              'BaseGetController handleRequest fail 1 ====> code: ${response.code} message: ${response.message}');
        }
      } else {
        /// 请求失败
        loadState = LoadState.fail;
        dismissEasyLoading();
        onFail(response);
        LoggerUtil.e(
            'BaseGetController handleRequest fail 2 ====> code: ${response.code} message: ${response.message}');
      }
    }).onError<ResultException>((error, stackTrace) {
      /// 网络请求失败
      if (loadingType != Constant.noLoading) {
        // 加载状态设置为fail
        loadState = LoadState.fail;
        // LoadErrorMsg 文字内容
        httpErrorMsg = '${error.code}  ${error.message}';
      }
      dismissEasyLoading();
      if (onError != null) {
        onError(error);
      }
      LoggerUtil.e(
          'BaseGetController handleRequest onError ====> code: ${error.code} message: ${error.message}');
    });
  }

  void dismissEasyLoading() {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }
}
