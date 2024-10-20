import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/UI/screens/login_screen.dart';
import 'package:task_manager_mobile_app/UI/screens/profile_screen.dart';
import 'package:task_manager_mobile_app/UI/utils/colors.dart';
import 'package:task_manager_mobile_app/auth/auth.dart';

class TmAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool isprofile;
  const TmAppbar({
    super.key,
    required this.isprofile,
  });

  @override
  Widget build(BuildContext context) {
    final String? name = Auth.myName;
    final String? email = Auth.myEmail;
    void navigateToProfile() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()));
    }

    return AppBar(
      backgroundColor: ColorsUtils.primaryColor,
      title: GestureDetector(
        onTap: () {
          if (isprofile) {
            return;
          }
          navigateToProfile();
        },
        child: Row(
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
                  name ?? 'no name',
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: ColorsUtils.backGroundColor,
                      ),
                ),

                // EMAIL
                Text(email ?? 'No email',
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 14, color: ColorsUtils.backGroundColor)),
              ],
            ))
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () {
              logout(context);
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

  Future<void> logout(BuildContext context) async {
    await Auth.clearUserData();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (predicate) => false,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(100);
}
