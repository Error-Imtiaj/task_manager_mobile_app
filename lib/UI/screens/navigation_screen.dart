import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TmAppbar(),
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
    );
  }
}

