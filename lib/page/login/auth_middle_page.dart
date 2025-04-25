import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/page/login/app_user_login_state_controller.dart';
import 'package:flutter3_wan_android/page/login/login_register/login_register_page.dart';
import 'package:oktoast/oktoast.dart';

/// 创建日期: 2025/04/24 13:39
/// 作者: Jerry
/// 描述: 登录中转页面

class AuthMiddlePage extends StatelessWidget {
  const AuthMiddlePage({
    Key? key,
    required this.child,
  }) : super(key: key);

  /// 已登录状态最重要跳转的页面
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // 如果已经登录，则直接跳转到目标页面，否则跳转到登录注册页面

    if (!loginState) {
      showToast('请先登录', position: ToastPosition.bottom);
    }

    return loginState ? child : LoginRegisterPage();
  }
}
