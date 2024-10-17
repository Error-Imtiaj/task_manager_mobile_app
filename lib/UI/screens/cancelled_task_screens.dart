import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/UI/widgets/taskTile_Widget.dart';

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
        return TasktileWidget(
          title: "Lorem Ipsum Title Text",
          description:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor e ere grgehg ukhueru ",
          Date: "16/11/2003",
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 8,
        );
      },
    );
  }
}
