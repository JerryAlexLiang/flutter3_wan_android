import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_logic.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final logic = Get.find<HomeLogic>();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Home"),
    );
  }
}
