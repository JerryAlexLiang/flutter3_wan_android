import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/constant/constant.dart';
import 'package:flutter3_wan_android/model/article_item_bean.dart';
import 'package:flutter3_wan_android/res/gaps.dart';
import 'package:flutter3_wan_android/res/strings.dart';
import 'package:flutter3_wan_android/theme/app_theme.dart';
import 'package:flutter3_wan_android/util/decoration_style.dart';
import 'package:flutter3_wan_android/widget/cached_network_image_view.dart';
import 'package:flutter3_wan_android/widget/custom_point_widget.dart';
import 'package:flutter3_wan_android/widget/ripple_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

/// 创建日期: 2024/10/17 14:27
/// 描述: 文章列表Item
/// 作者: Jerry

class ArticleListItemWidget extends StatelessWidget {
  const ArticleListItemWidget({
    super.key,
    required this.dataList,
    required this.index,
  });

  ///  文章列表数据源
  final List<ArticleItemBean> dataList;

  /// ListView item index
  final int index;

  @override
  Widget build(BuildContext context) {
    return RippleView(
      onTap: () => {Fluttertoast.showToast(msg: "${dataList[index].title}")},
      child: Container(
        // 边距10
        // padding: const EdgeInsets.symmetric(
        //   vertical: 10,
        //   horizontal: 8,
        // ),
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        // 圆角
        decoration: DecorationStyle.imageDecorationCircle(
          borderBottom: true,
          borderColor: Colors.white,
        ),
        child: Column(
          children: [
            // 作者组件
            authorShareTime(context),
            Gaps.vGap5,
            titleDecWidget(context),
            Gaps.vGap10,
            // 分类、是否收藏
            chapterCollect(context),
            Gaps.vGap10,
            const Divider(
              height: 1,
            )
          ],
        ),
      ),
    );
  }

  Widget titleDecWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: leftContainer(context),
        ),
        Gaps.hGap15,
        rightContainer(),
      ],
    );
  }

  /// 作者、时间
  Widget authorShareTime(BuildContext context) {
    return Row(
      children: [
        // 新标签
        refreshTag(context),
        // tags
        chapterTag(context),
        // 作者
        author(context),
        const Spacer(),
        // 时间、分享时间
        niceDate(context),
      ],
    );
  }

  /// 新
  Widget refreshTag(BuildContext context) {
    return Visibility(
      visible: dataList[index].fresh ?? false,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 3,
          vertical: 2,
        ),
        decoration: DecorationStyle.imageDecorationCircle(
          color: Colors.red,
          borderRadius: 3,
        ),
        child: Text(
          StringsConstant.freshTag.tr,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
      ),
    );
  }

  /// tags
  Widget chapterTag(BuildContext context) {
    return Visibility(
      visible:
          (dataList[index].tags != null && dataList[index].tags!.isNotEmpty)
              ? true
              : false,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 3,
          vertical: 2,
        ),
        decoration: DecorationStyle.imageDecorationCircle(
          color: Colors.blueAccent,
          borderRadius: 3,
        ),
        child: Text(
          (dataList[index].tags != null && dataList[index].tags!.isNotEmpty)
              ? dataList[index].tags![0].name!
              : "",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
      ),
    );
  }

  /// 作者、分享者
  Widget author(BuildContext context) {
    String value = '';
    if (dataList[index].author != null) {
      if (dataList[index].author!.isNotEmpty) {
        value = dataList[index].author!;
      } else {
        if (dataList[index].shareUser != null) {
          if (dataList[index].shareUser!.isNotEmpty) {
            value = dataList[index].shareUser!;
          }
        }
      }
    }
    return Row(
      children: [
        const Icon(
          Icons.person_outline,
          size: 15,
          color: Colors.grey,
        ),
        Gaps.hGap5,
        Text(
          value,
          style: context.bodyMediumStyle?.copyWith(
            fontSize: 12,
            color: Colors.grey,
          ),
        )
      ],
    );
  }

  /// 时间、分享时间
  Widget niceDate(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.access_time,
          size: 15,
          color: Colors.grey,
        ),
        Gaps.hGap5,
        Text(
          dataList[index].niceDate ?? (dataList[index].niceShareDate ?? ""),
          style: context.bodyMediumStyle?.copyWith(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  leftContainer(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: titleDesc(context),
    );
  }

  /// 标题、描述
  titleDesc(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: dataList[index].title!.isNotEmpty ? true : false,
          // child: Html(
          //   data: HtmlUtils.html2HighLight(
          //     html: dataList[index].title!,
          //     // color: 'yellow',
          //   ),
          //   style: {
          //     'font': Style(
          //       fontSize: FontSize(15),
          //       fontWeight: FontWeight.w500,
          //     ),
          //   },
          // ),
          child: Text(
            dataList[index].title!,
            style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Visibility(
          visible: dataList[index].desc!.isNotEmpty ? true : false,
          child: Column(
            children: [
              Gaps.vGap8,
              Text(
                dataList[index].desc ?? "",
                style: context.bodyMediumStyle?.copyWith(
                  fontSize: 13,
                  color: Colors.grey,
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 图片
  /// CachedNetworkImage可以直接使用或通过ImageProvider使用。
  /// CachedNetworkImage作为CachedNetworkImageProvider对Web的支持最小。它目前不包括缓存
  Widget rightContainer() {
    return CachedNetworkImageView(
      visible: (dataList[index].envelopePic != null &&
              dataList[index].envelopePic!.isNotEmpty)
          ? true
          : false,
      borderRadius: 6,
      imageUrl: dataList[index].envelopePic ?? Constant.defaultImageUrlVertical,
      // 测试errorWidget效果
      // imageUrl: Constant.placeHolderImageUrl.replaceFirst(RegExp('size1'), '100x120'),
      width: 90,
      height: 130,
      fit: BoxFit.cover,
      // isCircle: true,
      borderColor: Colors.red.withOpacity(0.2),
      borderWidth: 1,
    );
  }

  /// 分类、是否收藏
  Widget chapterCollect(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 3,
            vertical: 2,
          ),
          decoration: DecorationStyle.imageDecorationCircle(
            color: Colors.greenAccent,
            borderRadius: 3,
          ),
          child: Text(
            dataList[index].superChapterName ?? "",
            style: context.bodyMediumStyle?.copyWith(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
        const CustomPointWidget(
          thickness: 3,
          color: Colors.red,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 3,
            vertical: 2,
          ),
          decoration: DecorationStyle.imageDecorationCircle(
            color: Colors.pinkAccent,
            borderRadius: 3,
          ),
          child: Text(
            dataList[index].chapterName!,
            style: context.bodyMediumStyle?.copyWith(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
        const Spacer(),
        collectWidget(),
      ],
    );
  }

  RippleView collectWidget() {
    return RippleView(
        onTap: () => {
          // onCollectClick(index),
          Fluttertoast.showToast(msg: "${dataList[index].author}")
        },
        radius: 50,
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Obx(() {
            return Icon(
              Icons.favorite,
              color: dataList[index].isCollect
                  ? Colors.red
                  : Colors.grey.withOpacity(0.5),
              // color: loginState
              //     ? (dataList[index].isCollect
              //         ? Colors.red
              //         : Colors.grey.withOpacity(0.5))
              //     : Colors.grey.withOpacity(0.5),
            );
          }),
        ),
      );
  }
}
