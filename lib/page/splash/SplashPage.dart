import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/page/splash/SplashController.dart';
import 'package:flutter3_wan_android/res/strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// 开屏广告倒计时

class SplashPage extends StatelessWidget {
  //// Instantiate your class using Get.put() to make it available for all "child" routes there.
  //   final SplashController controller = Get.put(SplashController());

  final controller = Get.find<SplashController>();

  SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: Image.asset(
              'images/ic_welcome_thirdly.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 30.h,
            right: 20.w,
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20.r),
              child: InkWell(
                borderRadius: BorderRadius.circular(20.r),
                // 方法一定要加()
                onTap: () => controller.jumpToMain(),
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.w, 5.h, 10.w, 5.h),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 0, 0, 0.2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Obx(() => Center(
                        child: Text(
                          '${controller.timeCount} ${StringsConstant.jumpSplash.tr}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                          ),
                        ),
                      )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
