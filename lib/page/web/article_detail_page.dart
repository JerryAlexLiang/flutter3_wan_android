import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/constant/constant.dart';
import 'package:flutter3_wan_android/model/article_item_bean.dart';
import 'package:flutter3_wan_android/theme/app_color.dart';
import 'package:flutter3_wan_android/widget/article_detail_web_app_bar.dart';
import 'package:flutter3_wan_android/widget/state/favorite_lottie_widget.dart';
import 'package:flutter3_wan_android/widget/state/loading_lottie_rocket_widget.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'article_detail_controller.dart';

/// 创建日期: 2025/04/23 14:29
/// 作者: Jerry
/// 描述: 文章WebView页面

class ArticleDetailPage extends StatelessWidget {
  ArticleDetailPage({Key? key}) : super(key: key);

  final ArticleDetailController controller =
  Get.find<ArticleDetailController>();

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;
    ArticleItemBean model = arguments[Constant.articleData];
    bool showCollect = arguments[Constant.showCollect];

    // return PopScope(
    //   onPopInvokedWithResult: (bool didPop, result) async {
    //     if (didPop) {
    //       return;
    //     }
    //     controller.onWillPop();
    //   },
    //   child: Scaffold(
    //     appBar: ArticleDetailWebAppBar(
    //       model: model,
    //       showCollect: showCollect,
    //     ),
    //     body: webViewContainer(context, model),
    //   ),
    // );

    return  WillPopScope(
      child: Scaffold(
        appBar: ArticleDetailWebAppBar(
          model: model,
          showCollect: showCollect,
        ),
        body: webViewContainer(context, model),
      ),
      onWillPop: () => controller.onWillPop(),
    );
  }

  webViewContainer(BuildContext context, ArticleItemBean model) {
    var url = '';
    if (model.link != null) {
      if (model.link!.isNotEmpty) {
        url = model.link!;
      } else {
        url = Constant.myGitHub;
      }
    } else {
      url = Constant.myGitHub;
    }
    controller.loadUrl(url);
    return Stack(
      children: [
        WebViewWidget(controller: controller.webViewController),
        Obx(() {
          // WebView加载页面进度
          return Visibility(
            visible: controller.webProgress < 1,
            child: LinearProgressIndicator(
              minHeight: 1,
              backgroundColor: AppColors.bgColor,
              color: AppColors.iconLightColor,
              value: controller.webProgress,
            ),
          );
        }),
        Positioned(
          top: Get.height / 5,
          left: 0,
          right: 0,
          child: Obx(() {
            return LoadingLottieRocketWidget(
              visible: controller.unCollectAnimation,
              animate: controller.unCollectAnimation,
              repeat: false,
              width: Get.width,
              height: Get.height / 3,
            );
          }),
        ),
        // Obx(() {
        //   /// 收藏动画
        //   return Positioned(
        //     top: Get.height / 5,
        //     left: 0,
        //     right: 0,
        //     child: FavoriteLottieWidget(
        //       visible: controller.collectAnimation,
        //       animate: controller.collectAnimation,
        //       repeat: false,
        //       width: Get.width,
        //       height: Get.height / 3,
        //     ),
        //   );
        // }),
      ],
    );
  }
}
