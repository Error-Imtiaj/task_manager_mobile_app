import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/UI/widgets/taskTile_widget.dart';

class CancelledTaskScreens extends StatefulWidget {
  const CancelledTaskScreens({super.key});

  @override
  State<CancelledTaskScreens> createState() => _CancelledTaskScreensState();
}

class _CancelledTaskScreensState extends State<CancelledTaskScreens> {
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
          chipText: "Cancelled",
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
