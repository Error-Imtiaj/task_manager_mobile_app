import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/UI/screens/cancelled_task_screens.dart';
import 'package:task_manager_mobile_app/UI/screens/completed_task_screens.dart';
import 'package:task_manager_mobile_app/UI/screens/new_task_screens.dart';
import 'package:task_manager_mobile_app/UI/screens/progress_task_screens.dart';
import 'package:task_manager_mobile_app/UI/utils/colors.dart';
import 'package:task_manager_mobile_app/UI/widgets/navigation_distanations.dart';
import 'package:task_manager_mobile_app/UI/widgets/tm_Appbar.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const NewTaskScreens(),
    const CompletedTaskScreens(),
    const CancelledTaskScreens(),
    const ProgressTaskScreens(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TmAppbar(
        isprofile: false,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        backgroundColor: ColorsUtils.fieldPrimaryColor,
        indicatorColor: ColorsUtils.primaryColor,
        destinations: const [
          NavigationDistanations(
            icon: Icons.add_task,
            title: 'New',
          ),
          NavigationDistanations(
            icon: Icons.check_box,
            title: 'Completed',
          ),
          NavigationDistanations(
            icon: Icons.close,
            title: 'Cancelled',
          ),
          NavigationDistanations(
            icon: Icons.access_time_filled_outlined,
            title: 'Progress',
          ),
        ],
      ),
      // ADD TASK BUTTON
    );
  }
}
