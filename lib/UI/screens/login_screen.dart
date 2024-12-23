import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager_mobile_app/UI/controller/signin_controller.dart';
import 'package:task_manager_mobile_app/UI/screens/navigation_screen.dart';
import 'package:task_manager_mobile_app/UI/screens/reset_pass_screen.dart';
import 'package:task_manager_mobile_app/UI/screens/signup_screen.dart';
import 'package:task_manager_mobile_app/UI/utils/assetPath.dart';
import 'package:task_manager_mobile_app/UI/utils/colors.dart';
import 'package:task_manager_mobile_app/UI/widgets/circle_widget.dart';
import 'package:task_manager_mobile_app/UI/widgets/custom_button.dart';
import 'package:task_manager_mobile_app/UI/widgets/snack_bar.dart';
import 'package:task_manager_mobile_app/UI/widgets/textfield_widget.dart';


class LoginScreen extends StatefulWidget {
  static const String text = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final _loginController = Get.find<SigninController>();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _welcomeBack(),
            const SizedBox(
              height: 30,
            ),
            _loginForm(),
            const SizedBox(
              height: 30,
            ),
            // button
            GetBuilder<SigninController>(builder: (context) {
              return Visibility(
                visible: !context.inProgress,
                replacement: Center(child: CircularProgressIndicator()),
                child: Custombutton(
                  ButtonName: "Sign In",
                  ontap: () {
                    if (_formKey.currentState!.validate()) {
                      signIn();
                    }
                  },
                ),
              );
            }),
            const SizedBox(
              height: 10,
            ),

            // FORGOT PASSWORD
            TextButton(
                onPressed: _navigateToForgotPage,
                style: TextButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                ),
                child: Text(
                  'Forgot Password?',
                  style: GoogleFonts.poppins(color: ColorsUtils.primaryColor),
                )),
            // don't create account
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: "Don't have an account?",
                      style:
                          GoogleFonts.poppins(color: ColorsUtils.primaryColor)),
                  TextSpan(
                      text: " Create One",
                      style: GoogleFonts.poppins(
                          color: ColorsUtils.primaryColor,
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = _navigateToSignUpPage),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            // Email Text Field
            Textfieldwidget(
              fillColor: ColorsUtils.fieldPrimaryColor,
              controller: emailController,
              hintText: "Email",
              keyboardtype: TextInputType.emailAddress,
              validatorFunction: (p0) => _nameValidator(p0),
            ),
            const SizedBox(
              height: 10,
            ),

            // password Text Field
            Textfieldwidget(
              fillColor: ColorsUtils.fieldPrimaryColor,
              controller: passController,
              hintText: "Password",
              secureText: true,
              validatorFunction: (p0) => _validator(p0),
            ),
          ],
        ));
  }

  Widget _welcomeBack() {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(),
          width: 300,
          height: 100,
        ),
        const Circlewidget(
          width: 70,
          height: 70,
          color: ColorsUtils.fieldPrimaryColor,
          right: 0,
          top: 2,
        ),
        const Circlewidget(
          width: 30,
          height: 30,
          color: ColorsUtils.pinkColor,
          right: 0,
        ),
        Circlewidget(
          bottom: 0,
          child: SvgPicture.asset(
            Assetpath.bookSvg,
            width: 80,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 80,
          child: Text(
            "Welcome \n Back!",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: ColorsUtils.primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  void _navigateToForgotPage() {
    Get.toNamed(ResetPassScreen.text);
  }

  void _navigateToSignUpPage() {
    Get.toNamed(SignupScreen.text);
  }

  void _navigateToDashboard() {
    Get.toNamed(NavigationScreen.text);
  }

  _nameValidator(String? value) {
    if (value!.isEmpty) {
      return 'Field must not be empty';
    } else {
      return null;
    }
  }

  _validator(
    String? value,
  ) {
    if (value!.isEmpty) {
      return 'Field must not be empty';
    } else if (value.length <= 8) {
      return 'Input must be more than 8 character';
    } else {
      return null;
    }
  }

  Future<void> signIn() async {
    final bool result = await _loginController.signIn(
        emailController.text.trim(), passController.text);
    if (result) {
      showSnackBar(context, "You have successfully signed in");
      _navigateToDashboard();
    } else {
      showSnackBar(context, _loginController.errorMessage!, true);
    }
  }
}
