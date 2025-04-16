import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/res/gaps.dart';
import 'package:flutter3_wan_android/res/resources.dart';
import 'package:flutter3_wan_android/res/strings.dart';
import 'package:flutter3_wan_android/theme/app_color.dart';
import 'package:flutter3_wan_android/theme/app_theme.dart';
import 'package:flutter3_wan_android/widget/state/load_state.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

/// 创建日期: 2024/12/11 16:28
/// 作者: Jerry
/// 描述: 加载错误页面
class EmptyErrorStatePage extends StatelessWidget {
  const EmptyErrorStatePage({
    Key? key,
    required this.loadState,
    required this.onTap,
    required this.errMsg,
    this.showErrMsg = true,
  }) : super(key: key);

  /// 页面类型
  final LoadState loadState;
  final VoidCallback onTap;
  final String? errMsg;
  final bool? showErrMsg;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gaps.vGap150,
                Container(
                  child: Lottie.asset(
                    loadState == LoadState.empty
                        ? Resources.assetsLottieRefreshEmpty
                        : Resources.assetsLottieRefreshError,
                    width: 200,
                    fit: BoxFit.cover,
                    animate: true,
                  ),
                ),
                loadState == LoadState.empty ? Gaps.empty : Gaps.vGap26,
                Visibility(
                  visible: showErrMsg ?? false,
                  child: Text(
                    '$errMsg，${StringsConstant.clickRetry.tr}',
                    style: context.bodySmallStyle!.copyWith(
                      color: AppColors.colorB8C0D4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
