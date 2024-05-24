import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'project_logic.dart';

class ProjectPage extends StatelessWidget {
  ProjectPage({Key? key}) : super(key: key);

  final logic = Get.find<ProjectLogic>();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Project"),
    );
  }
}
