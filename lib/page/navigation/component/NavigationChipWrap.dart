import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/model/article_item_bean.dart';
import 'package:flutter3_wan_android/res/gaps.dart';
import 'package:flutter3_wan_android/theme/app_theme.dart';

/// 创建日期: 2025/04/17 15:49
/// 作者: Jerry
/// 描述: 航Chip Wrap 流式列表

class NavigationChipWrap extends StatelessWidget {
  const NavigationChipWrap({
    super.key,
    required this.chipList,
    required this.onTap,
  });

  //流布局数据列表
  final List<ArticleItemBean?>? chipList;

  // 点击事件
  final Function(ArticleItemBean articleItemBean) onTap;

  @override
  Widget build(BuildContext context) {
    if (chipList != null) {
      List<Widget> wrapList = chipList!
          .map((e) => _chipWidget(context, e!, chipList?.indexOf(e)))
          .toList();
      return Wrap(
        children: wrapList,
      );
    } else {
      return Gaps.empty;
    }
  }

  /// 使用DecoratedBox+InkWell看不到点击效果，需要使用Ink组件
  Widget _chipWidget(BuildContext context, ArticleItemBean model, int? index) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Ink(
        decoration: BoxDecoration(
          color: context.chipBackgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white, width: 0.1),
        ),
        child: InkWell(
          // splashColor: Colors.transparent.withOpacity(0.1),
          splashColor: Colors.transparent.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          onTap: () => onTap(model),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Text(
              model.title ?? "",
              style: context.bodyMediumStyle?.copyWith(fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}
