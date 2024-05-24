import 'package:get/get.dart';

import 'mine_state.dart';

/// state只专注数据，需要使用数据，直接通过state获取
/// logic只专注于触发事件交互，操作或更新数据
/// view只专注UI显示
/// logic层 实例化状态类，以便操作所有的变量
class MineLogic extends GetxController {
  final MineState state = MineState();
}
