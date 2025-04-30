import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/page/login/app_user_login_state_controller.dart';
import 'package:flutter3_wan_android/page/login/login_register/login_register_page.dart';
import 'package:flutter3_wan_android/page/mine/mine_controller.dart';
import 'package:flutter3_wan_android/res/gaps.dart';
import 'package:flutter3_wan_android/res/strings.dart';
import 'package:flutter3_wan_android/routes/app_routes.dart';
import 'package:flutter3_wan_android/util/decoration_style.dart';
import 'package:flutter3_wan_android/widget/ripple_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

/// 用户信息头像等
class UserInfoImage extends GetView<MineController> {
  const UserInfoImage({required this.onIconClick, Key? key}) : super(key: key);

  final VoidCallback? onIconClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Row(
        children: [
          userIconWidget(),
          Gaps.hGap15,
          nickNameWidget(),
          const Expanded(
            child: SizedBox(),
          ),
          settingContainer(),
        ],
      ),
    );
  }

  Material settingContainer() {
    return Material(
      color: Colors.transparent,
      child: Ink(
        child: InkWell(
          splashColor: Colors.transparent.withValues(alpha: 0.1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          onTap: () => Get.toNamed(AppRoutes.settingPage),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 30,
              ),
              color: Colors.transparent.withValues(alpha: 0.2),
              child: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  //
  nickNameWidget() {
    return Obx(() {
      return RippleView(
        color: Colors.transparent,
        onTap: () => loginState
            ? Get.defaultDialog(
                title: '提示',
                content: const Text('是否退出登录'),
                textCancel: StringsConstant.cancel.tr,
                textConfirm: StringsConstant.confirm.tr,
                onCancel: () {},
                onConfirm: onIconClick,
              )
            : Get.to(LoginRegisterPage(), transition: Transition.fadeIn),
        child: Text(
          loginState
              ? '${appStateController.userInfo.value.nickname}'
              : StringsConstant.loginContent.tr,
          style: TextStyle(
              color: Colors.white,
              fontSize: 23.sp,
              fontWeight: FontWeight.bold),
        ),
      );
    });
  }

  RippleView userIconWidget() {
    return RippleView(
      radius: 100,
      onTap: () => loginState
          ? Get.defaultDialog(
              title: '提示',
              content: const Text('是否退出登录'),
              textCancel: StringsConstant.cancel.tr,
              textConfirm: StringsConstant.confirm.tr,
              onCancel: () {},
              onConfirm: onIconClick,
            )
          : Get.to(LoginRegisterPage(), transition: Transition.fadeIn),
      child: Container(
        decoration: DecorationStyle.imageDecorationCircle(
          isCircle: true,
          // borderRadius: 10,
          borderWidth: 3,
          borderColor: Colors.pinkAccent,
          boxShadowBlurRadius: 3,
          boxShadowSpreadRadius: 3,
          boxShadowColor: Colors.white.withValues(alpha: 0.8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            loginState
                ? 'images/icon_background.png'
                : 'images/launch_image.png',
            fit: loginState ? BoxFit.cover : BoxFit.contain,
            width: 80,
            height: 80,
          ),
        ),
      ),
    );
  }
}
