import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager_mobile_app/UI/screens/login_screen.dart';
import 'package:task_manager_mobile_app/UI/screens/splash_screen.dart';
import 'package:task_manager_mobile_app/controller_binders.dart';

class TaskMangerApp extends StatefulWidget {
  const TaskMangerApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  State<TaskMangerApp> createState() => _TaskMangerAppState();
}

class _TaskMangerAppState extends State<TaskMangerApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: TaskMangerApp.navigatorKey,
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
      home: const SplashScreen(),
      initialBinding: ControllerBinders(),
      initialRoute: SplashScreen.text,
      routes: {
        SplashScreen.text: (context) => const SplashScreen(),
        LoginScreen.text: (context) => const LoginScreen(),
      },
    );
  }
}
