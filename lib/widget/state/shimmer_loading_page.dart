import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/res/gaps.dart';
import 'package:flutter3_wan_android/res/strings.dart';
import 'package:flutter3_wan_android/theme/app_theme.dart';
import 'package:flutter3_wan_android/widget/state/list_skeleton_shimmer_loading.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

/// 创建日期: 2024/12/06 17:18
/// 作者: Jerry
/// 描述: pk_skeleton骨架屏
class ShimmerLoadingPage extends StatelessWidget {
  const ShimmerLoadingPage({
    Key? key,
    this.simpleLoading = true,
  }) : super(key: key);

  final bool simpleLoading;

  @override
  Widget build(BuildContext context) {
    Widget widget;

    simpleLoading
        ? widget = simpleShimmerLoading(context)
        : widget = listShimmerLoading(context);

    return SafeArea(
        child: Scaffold(
      body: widget,
    ));
  }

  Shimmer simpleShimmerLoading(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Opacity(
              opacity: 0.6,
              child: Image.asset(
                'images/launch_image.png',
                width: 70,
                fit: BoxFit.cover,
              ),
            ),
            Gaps.vGap10,
            Text(
              StringsConstant.loading.tr,
              style: context.titleMediumStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget listShimmerLoading(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: const ListSkeletonShimmerLoading(),
    );
  }
}
