import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/UI/widgets/taskTile_widget.dart';

class CompletedTaskScreens extends StatefulWidget {
  const CompletedTaskScreens({super.key});

  @override
  State<CompletedTaskScreens> createState() => _CompletedTaskScreensState();
}

class _CompletedTaskScreensState extends State<CompletedTaskScreens> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 15,
      itemBuilder: (context, index) {
        return const TasktileWidget(
          title: "Lorem Ipsum Title Text",
          description:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor e ere grgehg ukhueru ",
          date: "16/11/2003",
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 8,
        );
      },
    );
  }
}
