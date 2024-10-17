import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/UI/screens/login_screen.dart';
import 'package:task_manager_mobile_app/UI/utils/colors.dart';

class TmAppbar extends StatelessWidget implements PreferredSizeWidget {
  const TmAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsUtils.primaryColor,
      title: Row(
        children: [
          const CircleAvatar(
            radius: 25,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // NAME
              Text(
                "Mohammad Imtiaj",
                maxLines: 1,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: ColorsUtils.backGroundColor,
                    ),
              ),

              // EMAIL
              Text("asharmd2222@gmail.com",
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 14, color: ColorsUtils.backGroundColor)),
            ],
          ))
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (predicate) => false);
            },
            icon: const Icon(
              Icons.logout_outlined,
              size: 34,
              color: ColorsUtils.backGroundColor,
            ),
          ),
        )
      ],
      toolbarHeight: 100,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(100);
}
