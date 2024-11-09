import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager_mobile_app/UI/controller/signup_controller.dart';
import 'package:task_manager_mobile_app/UI/screens/login_screen.dart';
import 'package:task_manager_mobile_app/UI/utils/colors.dart';
import 'package:task_manager_mobile_app/UI/widgets/center_progress_indicate.dart';
import 'package:task_manager_mobile_app/UI/widgets/custom_button.dart';
import 'package:task_manager_mobile_app/UI/widgets/snack_bar.dart';
import 'package:task_manager_mobile_app/UI/widgets/textfield_widget.dart';

class SignupScreen extends StatefulWidget {
  static const String text = '/signUp';
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final _signUpController = Get.find<SignupController>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    fnameController.dispose();
    lnameController.dispose();
    numberController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create New Account",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: ColorsUtils.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Join with us",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorsUtils.primaryColor),
                ),
                const SizedBox(
                  height: 30,
                ),
                // FORMS
                _signupForm(),
                const SizedBox(
                  height: 30,
                ),

                // BUTTON
                GetBuilder(
                    init: _signUpController,
                    builder: (context) {
                      return Visibility(
                        visible: !context.inProgress,
                        replacement: const CenterProgressIndicate(),
                        child: Custombutton(
                          ButtonName: "Sign Up",
                          ontap: () {
                            _next();
                          },
                        ),
                      );
                    }),
                const SizedBox(
                  height: 30,
                ),
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

  Widget _signupForm() {
    return Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            // EMAIL
            Textfieldwidget(
              fillColor: ColorsUtils.fieldPrimaryColor,
              controller: emailController,
              hintText: "Email",
              validatorFunction: (p0) => _nameValidator(p0),
            ),
            const SizedBox(
              height: 10,
            ),
            // FIRST NAME
            Textfieldwidget(
              fillColor: ColorsUtils.fieldPrimaryColor,
              controller: fnameController,
              hintText: "First Name",
              validatorFunction: (p0) => _nameValidator(p0),
            ),
            const SizedBox(
              height: 10,
            ),

            // LAST NAME
            Textfieldwidget(
              fillColor: ColorsUtils.fieldPrimaryColor,
              controller: lnameController,
              hintText: "Last Name",
              validatorFunction: (p0) => _nameValidator(p0),
            ),
            const SizedBox(
              height: 10,
            ),

            // NUMBER
            Textfieldwidget(
              fillColor: ColorsUtils.fieldPrimaryColor,
              controller: numberController,
              hintText: "Number",
              keyboardtype: TextInputType.number,
              validatorFunction: (p0) => _nameValidator(p0),
            ),
            const SizedBox(
              height: 10,
            ),

            // PASSWORD
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

  void _next() {
    if (_formKey.currentState!.validate()) {
      _signUp();
    }
  }

  Future<void> _signUp() async {
    final bool result = await _signUpController.signUp(
      emailController.text.trim(),
      fnameController.text.trim(),
      lnameController.text.trim(),
      numberController.text,
      passController.text,
    );

    if (result) {
      showSnackBar(context, "Congratulations! Your account has been created");
      _navigateToSignInPage();
      showSnackBar(context, "Please Sign in");
      emailController.clear();
      fnameController.clear();
      lnameController.clear();
      numberController.clear();
      passController.clear();
    } else {
      showSnackBar(context, _signUpController.errorMessage!, true);
    }
  }

  void _navigateToSignInPage() {
    Get.toNamed(LoginScreen.text);
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

  _nameValidator(String? value) {
    if (value!.isEmpty) {
      return 'Field must not be empty';
    } else {
      return null;
    }
  }
}
