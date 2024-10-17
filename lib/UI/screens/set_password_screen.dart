import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager_mobile_app/UI/screens/login_screen.dart';
import 'package:task_manager_mobile_app/UI/utils/colors.dart';
import 'package:task_manager_mobile_app/UI/widgets/custom_button.dart';
import 'package:task_manager_mobile_app/UI/widgets/textfield_widget.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  void dispose() {
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Set Password",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.white),
        ),
        backgroundColor: ColorsUtils.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Set Your Password",
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ColorsUtils.primaryColor,
                  fontSize: 32),
            ),
            const SizedBox(
              height: 10,
            ),

            Text(
              "Minimum number of password should be 6 digits",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Colors.grey,
                  fontSize: 14),
            ),
            const SizedBox(
              height: 20,
            ),

            // PASSWORD FIELD
            Textfieldwidget(
              fillColor: ColorsUtils.fieldPrimaryColor,
              controller: _passController,
              hintText: "Password",
              validatorFunction: (p0) => _validator(p0),
            ),
            const SizedBox(
              height: 10,
            ),

            // CONFIRM PASSWORD FIELD
            Textfieldwidget(
              fillColor: ColorsUtils.fieldPrimaryColor,
              controller: _confirmPassController,
              hintText: "Confirm Password",
              validatorFunction: (p0) => _validator(p0),
            ),
            const SizedBox(
              height: 10,
            ),
            // BUTTON SET PASSWORD
            Custombutton(
              ButtonName: "Set Password",
              ontap: () {},
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
                        ..onTap = _navigateToSignInPage,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSignInPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const LoginScreen();
    }));
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
}
