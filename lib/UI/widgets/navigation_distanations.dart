import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/UI/utils/colors.dart';

class NavigationDistanations extends StatelessWidget {
  final IconData icon;
  final String title;
  const NavigationDistanations(
      {super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      selectedIcon: Icon(
        icon,
        color: ColorsUtils.backGroundColor,
      ),
      icon: Icon(
        icon,
        color: ColorsUtils.primaryColor,
      ),
      label: title,
    );
  }
}
