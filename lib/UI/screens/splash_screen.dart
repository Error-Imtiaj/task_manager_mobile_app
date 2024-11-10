import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:task_manager_mobile_app/UI/controller/splash_screen_controller.dart';
import 'package:task_manager_mobile_app/UI/utils/assetPath.dart';
import 'package:task_manager_mobile_app/UI/utils/colors.dart';


class SplashScreen extends StatefulWidget {
  static const String text = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _splashController = Get.find<SplashScreenController>();

  @override
  void initState() {
    _splashController.moveToNextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.backGroundColor,
      body: Center(
        child: SvgPicture.asset(
          Assetpath.splashSvg,
          height: 600,
          width: 400,
        ),
      ),
    );
  }
}
