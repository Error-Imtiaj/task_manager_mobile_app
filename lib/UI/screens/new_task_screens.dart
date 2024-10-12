import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager_mobile_app/UI/utils/colors.dart';
import 'package:task_manager_mobile_app/UI/widgets/card_widget.dart';
import 'package:task_manager_mobile_app/UI/widgets/taskTile_Widget.dart';

class NewTaskScreens extends StatefulWidget {
  const NewTaskScreens({super.key});

  @override
  State<NewTaskScreens> createState() => _NewTaskScreensState();
}

class _NewTaskScreensState extends State<NewTaskScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            // CARD DETAILS
            _heroSection(),
            // TASK ITEMS
            Expanded(
                child: ListView.separated(
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
            ))
          ],
        ),
      ),
    );
  }

  // TASK HERO ECTION
  Widget _heroSection() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CardWidget(
          count: '09',
          title: 'New Task',
        ),
        CardWidget(
          count: '09',
          title: 'Completed',
        ),
        CardWidget(
          count: '09',
          title: 'Cancelled',
        ),
        CardWidget(
          count: '09',
          title: 'Progress',
        ),
      ],
    );
  }
}