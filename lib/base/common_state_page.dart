import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/base/base_getx_controller.dart';
import 'package:flutter3_wan_android/res/gaps.dart';
import 'package:flutter3_wan_android/res/strings.dart';
import 'package:flutter3_wan_android/widget/state/load_error_page.dart';
import 'package:flutter3_wan_android/widget/state/load_state.dart';
import 'package:flutter3_wan_android/widget/state/loading_lottie_rocket_widget.dart';
import 'package:flutter3_wan_android/widget/state/shimmer_loading_page.dart';
import 'package:get/get.dart';

/// 创建日期: 2024/12/11 16:35
/// 作者: Jerry
/// 描述:通用页面组件
class CommonStatePage<T extends BaseGetXController> extends StatelessWidget {
  const CommonStatePage({
    Key? key,
    required this.controller,
    required this.onPressed,
    this.errorPage,
    this.emptyPage,
    required this.child,
  }) : super(key: key);

  // 业务GetXController
  final T controller;

  // 点击事件
  final VoidCallback onPressed;

  // 自定义设置错误页面
  final Widget? errorPage;

  // 自定义设置空页面
  final Widget? emptyPage;

  //组件
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.loadState == LoadState.simpleShimmerLoading) {
          return const ShimmerLoadingPage();
        } else if (controller.loadState == LoadState.multipleShimmerLoading) {
          return const ShimmerLoadingPage(
            simpleLoading: false,
          );
        } else if (controller.loadState == LoadState.lottieRocketLoading) {
          return const Column(
            children: [
              Gaps.vGap150,
              LoadingLottieRocketWidget(
                visible: true,
                animate: true,
                repeat: true,
              ),
            ],
          );
        } else if (controller.loadState == LoadState.fail) {
          return errorPage ??
              EmptyErrorStatePage(
                loadState: LoadState.fail,
                onTap: onPressed,
                errMsg: controller.httpErrorMsg,
              );
        } else if (controller.loadState == LoadState.empty) {
          return emptyPage ??
              EmptyErrorStatePage(
                loadState: LoadState.empty,
                onTap: onPressed,
                errMsg: StringsConstant.noData.tr,
              );
        } else if (controller.loadState == LoadState.success) {
          return child;
        }
        return Gaps.empty;
      }),
    );
  }
}
