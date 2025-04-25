import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter3_wan_android/base/base_getx_controller.dart';
import 'package:flutter3_wan_android/constant/constant.dart';
import 'package:flutter3_wan_android/http/dio_method.dart';
import 'package:flutter3_wan_android/http/dio_util.dart';
import 'package:flutter3_wan_android/http/request_api.dart';
import 'package:flutter3_wan_android/model/user_info_model.dart';
import 'package:flutter3_wan_android/page/login/app_user_login_state_controller.dart';
import 'package:flutter3_wan_android/res/r.dart';
import 'package:flutter3_wan_android/res/strings.dart';
import 'package:flutter3_wan_android/util/keyboard_util.dart';
import 'package:flutter3_wan_android/util/logger_util.dart';
import 'package:flutter3_wan_android/util/toast_utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

/// 创建日期: 2025/04/25 12:47
/// 作者: Jerry
/// 描述: 注册登录

enum ButtonType { login, register }

class LoginRegisterController extends BaseGetXController {
  /// 登录注册类型
  final _buttonType = ButtonType.login.obs;

  get buttonType => _buttonType.value;

  set buttonType(value) => _buttonType.value = value;

  /// 登录注册按钮描述语
  final _switchButtonTypeDesc = StringsConstant.switchButtonRegisterDesc.tr.obs;

  get switchButtonTypeDesc => _switchButtonTypeDesc.value;

  set switchButtonTypeDesc(value) => _switchButtonTypeDesc.value = value;

  final _buttonTypeDesc = StringsConstant.loginContent.tr.obs;

  get buttonTypeDesc => _buttonTypeDesc.value;

  set buttonTypeDesc(value) => _buttonTypeDesc.value = value;

  final _loginBg = R.iconLoginBg.obs;

  get loginBg => _loginBg.value;

  set loginBg(value) => _loginBg.value = value;

  /// 用户名
  final _userName = "".obs;

  get userName => _userName.value;

  set userName(value) => _userName.value = value;

  /// 密码
  final _password = "".obs;

  get password => _password.value;

  set password(value) => _password.value = value;

  /// 确认密码
  final _ensurePassword = "".obs;

  get ensurePassword => _ensurePassword.value;

  set ensurePassword(value) => _ensurePassword.value = value;

  /// 输入框控制器
  late final TextEditingController textEditingControllerUserName;
  late final TextEditingController textEditingControllerUserPassword;
  late final TextEditingController textEditingControllerUserEnsurePassword;

  @override
  void onInit() {
    super.onInit();
    textEditingControllerUserName = TextEditingController();
    textEditingControllerUserPassword = TextEditingController();
    textEditingControllerUserEnsurePassword = TextEditingController();
  }

  /// 切换登录注册类型
  void switchLoginRegister(BuildContext context) {
    if (buttonType == ButtonType.login) {
      // 点击前是登陆类型，则切换为注册类型
      buttonType = ButtonType.register;
      // switchButtonTypeDesc = '已有账号，去登录';
      switchButtonTypeDesc = StringsConstant.switchButtonLoginDesc.tr;
      buttonTypeDesc = StringsConstant.registerContent.tr;
      // 切换注册背景图片
      loginBg = R.iconRegisterBg;
    } else {
      // 点击前是注册类型，则切换为登录类型
      buttonType = ButtonType.login;
      // switchButtonTypeDesc = '没有账号，去注册';
      switchButtonTypeDesc = StringsConstant.switchButtonRegisterDesc.tr;
      buttonTypeDesc = StringsConstant.loginContent.tr;
      // 切换注册背景图片
      loginBg = R.iconLoginBg;
    }
    // 清空输入框
    userName = "";
    password = "";
    ensurePassword = "";
    textEditingControllerUserName.clear();
    textEditingControllerUserPassword.clear();
    textEditingControllerUserEnsurePassword.clear();
    // 隐藏软键盘
    KeyboardUtils.hideKeyboard(context);
  }

  /// 验证输入参数
  void verificationParameters() {
    if (userName.toString().trim().isEmpty) {
      ToastUtils.showToastBottom(StringsConstant.userNameEmptyInfo.tr);
      return;
    }

    if (password.toString().trim().isEmpty) {
      ToastUtils.showToastBottom(StringsConstant.passwordEmptyInfo.tr);
      return;
    }

    if (buttonType == ButtonType.register) {
      if (ensurePassword.toString().trim().isEmpty) {
        ToastUtils.showToastBottom(StringsConstant.ensurePasswordEmptyInfo.tr);
        return;
      }

      if (userName.toString().trim().isNotEmpty &&
          password.toString().trim().isNotEmpty &&
          ensurePassword.toString().trim().isNotEmpty) {
        if (password.toString().trim() != ensurePassword.toString().trim()) {
          ToastUtils.showToastBottom(StringsConstant.ensurePasswordFail.tr);
          return;
        }
      }
    }
  }

  /// 登录
  void goToLoginRegister() {
    // 验证输入参数
    verificationParameters();

    /// 登录 POST https://www.wanandroid.com/user/login
    /// 注册 POST https://www.wanandroid.com/user/register
    /// 参数：username，password   登录后会在cookie中返回账号密码，只要在客户端做cookie持久化存储即可自动登录验证。
    /// 简单做法，存储账号密码（demo）

    // 登录参数
    var paramsLogin = {
      "username": userName.toString().trim(),
      "password": password.toString().trim(),
    };

    // 注册参数
    var paramsRegister = {
      "username": userName.toString().trim(),
      "password": password.toString().trim(),
      "repassword": ensurePassword.toString().trim(),
    };

    /// FormData参数
    dio.FormData formData = buttonType == ButtonType.login
        ? dio.FormData.fromMap(paramsLogin)
        : dio.FormData.fromMap(paramsRegister);

    String requestUrl = buttonType == ButtonType.login
        ? RequestApi.goToLogin
        : RequestApi.gotoRegister;

    httpManager(
      loadingType: Constant.showLoadingDialog,
      future:
          DioUtil().request(requestUrl, method: DioMethod.post, data: formData),
      onSuccess: (value) {
        UserInfoModel userInfoModel = UserInfoModel.fromJson(value);
        LoggerUtil.d('login success : ${userInfoModel.toJson()}');
        EasyLoading.showSuccess(StringsConstant.loginSuccess.tr);
        // // 保存用户数据
        // SpUtil.saveUserInfo(userInfoModel);
        // appStateController.updateUserInfo();
        // 保存登录状态true
        setLoginState(true);
        Get.back();
      },
      onFail: (response) {
        EasyLoading.showError(
            '${StringsConstant.loginFail.tr} \n ${response.message}');
      },
      onError: (error) {
        EasyLoading.showError(
            '${StringsConstant.loginFail.tr} \n ${error.message}');
      },
    );
  }
}
