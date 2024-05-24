import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'navigation_logic.dart';

class NavigationPage extends StatelessWidget {
  NavigationPage({Key? key}) : super(key: key);

  final logic = Get.find<NavigationLogic>();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Navigation"),
    );
  }
}
