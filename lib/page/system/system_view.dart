import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'system_logic.dart';

class SystemPage extends StatelessWidget {
  SystemPage({Key? key}) : super(key: key);

  final logic = Get.find<SystemLogic>();
  final state = Get.find<SystemLogic>().state;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("System"),
    );
  }
}
