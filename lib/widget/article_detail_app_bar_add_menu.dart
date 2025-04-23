import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/model/article_item_bean.dart';
import 'package:flutter3_wan_android/page/web/article_detail_controller.dart';
import 'package:flutter3_wan_android/res/r.dart';
import 'package:flutter3_wan_android/theme/app_color.dart';
import 'package:flutter3_wan_android/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

class ArticleDetailAppBarAddMenu extends StatefulWidget {
  const ArticleDetailAppBarAddMenu({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ArticleItemBean model;

  @override
  ArticleDetailAppBarAddMenuState createState() =>
      ArticleDetailAppBarAddMenuState();
}

class ArticleDetailAppBarAddMenuState extends State<ArticleDetailAppBarAddMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final detailController = Get.find<ArticleDetailController>();

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = context.scaffoldBackgroundColor;
    final Color? iconColor = context.appIconColor;

    final Widget body = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(right: 12),
          child: Image.asset(
            R.iconInvertedTriangle,
            width: 8,
            height: 4,
            color: backgroundColor,
          ),
        ),
        SizedBox(
          width: 120.0,
          height: 40.0,
          child: TextButton.icon(
            onPressed: () {
              // 刷新页面
              detailController.reloadWebView();
              Get.back();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('刷新页面'),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).textTheme.bodyMedium?.color,
              disabledForegroundColor: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.color
                  ?.withValues(alpha: 0.12),
              backgroundColor: backgroundColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
              ),
            ),
          ),
        ),
        Container(width: 120.0, height: 0.6, color: AppColors.colorB8C0D4),
        SizedBox(
          width: 120.0,
          height: 40.0,
          child: TextButton.icon(
            onPressed: () {
              // 收藏、取消收藏站内文章
              // detailController.requestCollectArticle(widget.model);
              showToast("收藏", position: ToastPosition.bottom);
              Get.back();
            },
            icon: Obx(() {
              return Icon(
                Icons.favorite,
                size: 24,
                color: widget.model.isCollect
                    ? Colors.red
                    : Colors.grey.withValues(alpha: 0.5),
              );
            }),
            label: const Text('收藏文章'),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).textTheme.bodyMedium?.color,
              disabledBackgroundColor: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.color
                  ?.withValues(alpha: 0.12),
              backgroundColor: backgroundColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 120.0,
          height: 40.0,
          child: TextButton.icon(
            onPressed: () {
              // 收藏、取消收藏网址
              // detailController.requestCollectLink();
              showToast("收藏", position: ToastPosition.bottom);
              Get.back();
            },
            icon: const Icon(Icons.collections),
            label: const Text('收藏网址'),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).textTheme.bodyMedium?.color,
              disabledBackgroundColor: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.color
                  ?.withValues(alpha: 0.12),
              backgroundColor: backgroundColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (_, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          alignment: Alignment.topRight,
          child: child,
        );
      },
      child: body,
    );
  }
}
