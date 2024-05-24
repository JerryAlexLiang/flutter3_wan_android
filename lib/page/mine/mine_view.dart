import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'mine_logic.dart';

/// state只专注数据，需要使用数据，直接通过state获取
/// logic只专注于触发事件交互，操作或更新数据
/// view只专注UI显示
class MinePage extends StatelessWidget {
  MinePage({Key? key}) : super(key: key);

  final logic = Get.find<MineLogic>();
  final state = Get.find<MineLogic>().state;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Mine"),
    );
  }
}
