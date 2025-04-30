import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/page/login/app_user_login_state_controller.dart';
import 'package:flutter3_wan_android/page/mine/mine_controller.dart';
import 'package:flutter3_wan_android/res/gaps.dart';
import 'package:flutter3_wan_android/res/strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

/// 用户信息排名信息等
class UserInfoScore extends GetView<MineController> {
  const UserInfoScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      margin: EdgeInsets.symmetric(horizontal: 10.sp),
      decoration: BoxDecoration(
        color: Colors.transparent.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white, width: 0.2),
      ),
      child: Row(
        children: [
          userLevelContainer(),
          Gaps.hGap10,
          userRankContainer(),
          const Spacer(),
          IconButton(
            onPressed: () {
              Fluttertoast.showToast(msg: "消息");
            },
            icon: const Icon(
              Icons.message,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Container userRankContainer() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.lightBlueAccent,
          ),
          child: InkWell(
            onTap: () => Fluttertoast.showToast(msg: "排名"),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 5.h,
              ),
              child: Obx(() {
                return Text(
                  appStateController.isLogin.value
                      ? "${StringsConstant.rank.tr}：${appStateController
                      .coinInfo.value.rank ?? "-"}"
                      : "${StringsConstant.rank.tr}：-",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Container userLevelContainer() {
    return Container(
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.pinkAccent,
          ),
          child: InkWell(
            onTap: () => Fluttertoast.showToast(msg: "等级"),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 5.h,
              ),
              child: Obx(() {
                return Text(
                  appStateController.isLogin.value
                      ? "${StringsConstant.level.tr}：${appStateController
                      .coinInfo.value.level ?? "-"}"
                      : "${StringsConstant.level.tr}：-",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
