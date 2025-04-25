import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/res/gaps.dart';
import 'package:flutter3_wan_android/res/strings.dart';
import 'package:flutter3_wan_android/theme/app_theme.dart';
import 'package:flutter3_wan_android/util/keyboard_util.dart';
import 'package:flutter3_wan_android/widget/custom_app_bar.dart'
    show CustomAppBar;
import 'package:flutter3_wan_android/widget/edit_widget.dart';
import 'package:flutter3_wan_android/widget/ripple_view.dart';
import 'package:get/get.dart';

import 'login_register_controller.dart';

/// 创建日期: 2025/04/25 13:07
/// 作者: Jerry
/// 描述: 注册登录

class LoginRegisterPage extends StatelessWidget {
  LoginRegisterPage({Key? key}) : super(key: key);

  final LoginRegisterController controller = Get.put(LoginRegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(controller.loginBg),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: [
              // Obx(() {
              //   return CustomAppBar(
              //     centerTitle: controller.buttonType == ButtonType.login
              //         ? StringsConstant.loginContent.tr
              //         : StringsConstant.registerContent.tr,
              //     isBack: true,
              //     backImageColor: Colors.white,
              //     titleStyle:
              //     context.bodyLargeStyle?.copyWith(color: Colors.white),
              //     backgroundColor: Colors.transparent,
              //   );
              // }),
              CustomAppBar(
                centerTitle: controller.buttonType == ButtonType.login
                    ? StringsConstant.loginContent.tr
                    : StringsConstant.registerContent.tr,
                isBack: true,
                backImageColor: Colors.white,
                titleStyle:
                    context.bodyLargeStyle?.copyWith(color: Colors.white),
                backgroundColor: Colors.transparent,
              ),
              Gaps.vGap15,
              const FlutterLogo(
                size: 100,
              ),
              Gaps.vGap32,
              // 用户名
              inputUserName(),
              // 密码
              inputPassword(),
              // 确认密码
              inputEnsurePassword(),
              Gaps.vGap15,
              // 登录按钮
              loginButton(),
              // 提示信息
              infoText(),
              Gaps.vGap32,
              // 登录注册切换按钮
              switchLoginRegisterTypeButton(context),
            ],
          ),
        );
      }),
    );
  }

  /// 用户名
  Widget inputUserName() {
    return EditWidget(
      textEditingController: controller.textEditingControllerUserName,
      iconWidget: const Icon(
        Icons.person_outline,
        color: Colors.white,
      ),
      hintText: StringsConstant.editUserNameHint.tr,
      keyboardType: TextInputType.text,
      onChanged: (value) => controller.userName = value,
    );
  }

  /// 密码
  Widget inputPassword() {
    return EditWidget(
      textEditingController: controller.textEditingControllerUserPassword,
      iconWidget: const Icon(
        Icons.lock_outline,
        color: Colors.white,
      ),
      hintText: StringsConstant.editPasswordHint.tr,
      showPasswordType: true,
      onChanged: (value) => controller.password = value,
    );
  }

  /// 确认密码
  Widget inputEnsurePassword() {
    return Obx(() {
      return Visibility(
        visible: controller.buttonType == ButtonType.register ? true : false,
        child: EditWidget(
          textEditingController:
              controller.textEditingControllerUserEnsurePassword,
          iconWidget: const Icon(
            Icons.lock_outline,
            color: Colors.white,
          ),
          hintText: StringsConstant.editEnsurePasswordHint.tr,
          showPasswordType: true,
          onChanged: (value) => controller.ensurePassword = value,
        ),
      );
    });
  }

  /// 登录按钮
  Widget loginButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: MaterialButton(
        height: 45,
        color: Colors.blue,
        textColor: Colors.white,
        splashColor: Colors.red,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () => {
          KeyboardUtils.hideKeyboard(Get.context!),
          controller.goToLoginRegister()
        },
        // child: Obx(() {
        //   return Text(
        //     controller.buttonTypeDesc,
        //     style: const TextStyle(
        //       color: Colors.white,
        //       fontSize: 16,
        //     ),
        //   );
        // }),
        child: Text(
          controller.buttonTypeDesc,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  /// 登录注册切换按钮
  Widget switchLoginRegisterTypeButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: RippleView(
        color: Colors.transparent,
        radius: 20,
        onTap: () => controller.switchLoginRegister(context),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          // child: Obx(() {
          //   return Text(
          //     controller.switchButtonTypeDesc,
          //     style: const TextStyle(
          //       color: Colors.white,
          //       fontSize: 15,
          //     ),
          //   );
          // }),
          child: Text(
            controller.switchButtonTypeDesc,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  /// 提示信息
  Widget infoText() {
    // return Obx(() {
    return Visibility(
      visible: controller.buttonType == ButtonType.register,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: RichText(
          text: TextSpan(children: [
            const WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Icon(
                Icons.info_outline,
                size: 15,
                color: Colors.white,
              ),
            ),
            const WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Gaps.hGap5,
            ),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Text(
                StringsConstant.loginRegisterInfo.tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
    // });
  }
}
