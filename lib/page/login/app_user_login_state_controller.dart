import 'package:flutter3_wan_android/base/base_getx_controller.dart';
import 'package:flutter3_wan_android/model/total_user_info_model.dart';
import 'package:flutter3_wan_android/model/user_info_model.dart';
import 'package:get/get.dart';

/// 创建日期: 2025/04/24 13:42
/// 作者: Jerry0
/// 描述: 用户登录状态

class AppUserLoginStateController extends BaseGetXController {
  /// 登录状态
  final isLogin = false.obs;

  /// 个人用户信息
  final userInfo = UserInfoModel().obs;
  final coinInfo = CoinInfo().obs;

  /// 登录状态
  setLoginState(bool state) => isLogin.value = state;

  getLoginState() => isLogin.value;

}

final appStateController = Get.find<AppUserLoginStateController>();

bool get loginState => appStateController.getLoginState();

setLoginState(bool state) => appStateController.setLoginState(state);
