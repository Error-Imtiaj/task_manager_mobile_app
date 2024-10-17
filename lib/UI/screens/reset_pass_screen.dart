import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager_mobile_app/UI/screens/login_screen.dart';
import 'package:task_manager_mobile_app/UI/screens/pin_screens.dart';
import 'package:task_manager_mobile_app/UI/utils/colors.dart';
import 'package:task_manager_mobile_app/UI/widgets/custom_button.dart';
import 'package:task_manager_mobile_app/UI/widgets/textfield_widget.dart';

class ResetPassScreen extends StatefulWidget {
  const ResetPassScreen({super.key});

  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  final TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fromkey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reset Password",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.white),
        ),
        backgroundColor: ColorsUtils.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Form(
            key: fromkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                // TITLE
                Text(
                  "Your email address",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: ColorsUtils.primaryColor,
                      fontSize: 34),
                ),
                // SENT MEAASGE

                Text(
                  "A 6 digit verification OTP will be sent to your email",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: Colors.grey,
                      fontSize: 14),
                ),
                const SizedBox(
                  height: 30,
                ),

                // EMAIL FIELD
                Textfieldwidget(
                  fillColor: ColorsUtils.fieldPrimaryColor,
                  controller: emailController,
                  hintText: "Email",
                  validatorFunction: (p0) => _nameValidator(p0),
                ),
                const SizedBox(
                  height: 20,
                ),

                // BUTTON
                Custombutton(
                  ButtonName: "Send verification Code",
                  ontap: () => _navigateToPinVerifyPage(),
                ),
                const SizedBox(
                  height: 20,
                ),

                // SIGN IN
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Have Account?",
                            style: GoogleFonts.poppins(
                                color: ColorsUtils.primaryColor)),
                        TextSpan(
                            text: " Log in",
                            style: GoogleFonts.poppins(
                                color: ColorsUtils.primaryColor,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _navigateToSignInPage),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToSignInPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const LoginScreen();
    }));
  }

  void _navigateToPinVerifyPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const PinScreens();
    }));
  }

  _nameValidator(String? value) {
    if (value!.isEmpty) {
      return 'Field must not be empty';
    } else {
      return null;
    }
  }
}
