import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/base/base_getx_controller.dart';
import 'package:flutter3_wan_android/constant/constant.dart';
import 'package:flutter3_wan_android/model/tree_model.dart';
import 'package:get/get.dart';

/// 创建日期: 2025/04/22 14:05
/// 作者: Jerry
/// 描述: 知识体系下二级页面-PageView

class TreeTabContentPageController extends BaseGetXController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final TreeModel treeModel = Get.arguments[Constant.treeModel];
  final int treeModelIndex = Get.arguments[Constant.treeModelIndex];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      length: treeModel.children?.length ?? 0,
      vsync: this,
      initialIndex: treeModelIndex,
    );
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
