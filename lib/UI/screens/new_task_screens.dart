import 'package:flutter/material.dart';

import 'package:task_manager_mobile_app/UI/widgets/card_widget.dart';
import 'package:task_manager_mobile_app/UI/widgets/taskTile_widget.dart';

class NewTaskScreens extends StatefulWidget {
  const NewTaskScreens({super.key});

  @override
  State<NewTaskScreens> createState() => _NewTaskScreensState();
}

class _NewTaskScreensState extends State<NewTaskScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // CARD DETAILS
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: _heroSection(),
            ),
          ),

          // TASK ITEMS
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListView.separated(
              itemCount: 15,
              itemBuilder: (context, index) {
                return const TasktileWidget(
                  title: "Lorem Ipsum Title Text",
                  description:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor e ere grgehg ukhueru ",
                  date: "16/11/2003",
                  chipText: "New",
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 8,
                );
              },
            ),
          ))
        ],
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
