import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/page/home2/home2_controller.dart';
import 'package:flutter3_wan_android/widget/cached_network_image_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety_flutter3/flutter_swiper_null_safety_flutter3.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

/// 创建日期: 2024/11/28 19:37
/// 作者: Jerry
/// 描述: 首页Banner

class NewHomeBannerWidget extends GetView<Home2Controller> {
  const NewHomeBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Swiper(
        loop: true,
        autoplay: true,
        //scale：两侧item的缩放比
        scale: 0.95,
        //viewportFraction：视图宽度，即显示的item的宽度屏占比
        viewportFraction: 0.85,
        //指示器
        pagination: const SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(
            bottom: 10,
            right: 30,
          ),
          // builder: SwiperPagination.dots,
          builder: SwiperPagination.fraction,
        ),
        itemCount: controller.state.homeBannerList.length,
        itemBuilder: (BuildContext context, int index) {
          return bannerItemView(index);
        },
        onTap: (index) {
          // Fluttertoast.showToast(msg: controller.homeBannerList[index].title);
          showToast(
            controller.state.homeBannerList[index].title,
            position: ToastPosition.bottom,
          );
        },
      );
    });
  }

  Widget bannerItemView(int index) {
    return CachedNetworkImageView(
      visible:
          controller.state.homeBannerList[index].imagePath.isNotEmpty ? true : false,
      borderRadius: 10,
      imageUrl: controller.state.homeBannerList[index].imagePath,
      fit: BoxFit.cover,
      width: Get.width,
      height: 120.h,
    );
  }
}
