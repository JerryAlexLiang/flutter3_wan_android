import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'project_tree_children_controller.dart';

class ProjectTreeChildrenPage extends StatelessWidget {
  ProjectTreeChildrenPage({Key? key}) : super(key: key);

  final controller = Get.find<ProjectTreeChildrenController>();
  final state = Get.find<ProjectTreeChildrenController>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
