import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager_mobile_app/UI/screens/login_screen.dart';
import 'package:task_manager_mobile_app/UI/utils/colors.dart';
import 'package:task_manager_mobile_app/UI/utils/urls.dart';
import 'package:task_manager_mobile_app/UI/widgets/center_progress_indicate.dart';
import 'package:task_manager_mobile_app/UI/widgets/custom_button.dart';
import 'package:task_manager_mobile_app/UI/widgets/snack_bar.dart';
import 'package:task_manager_mobile_app/UI/widgets/textfield_widget.dart';
import 'package:task_manager_mobile_app/data/model/network_response.dart';
import 'package:task_manager_mobile_app/data/services/network_caller.dart';

class SignupScreen extends StatefulWidget {
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
  bool _inProgress = false;

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
                Visibility(
                  visible: !_inProgress,
                  replacement: const CenterProgressIndicate(),
                  child: Custombutton(
                    ButtonName: "Sign Up",
                    ontap: () {
                      _next();
                    },
                  ),
                ),
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
    _inProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": emailController.text.trim(),
      "firstName": fnameController.text.trim(),
      "lastName": lnameController.text.trim(),
      "mobile": numberController.text.trim(),
      "password": passController.text.trim()
    };
    NetworkModel response = await NetworkCaller.postRequest(
        url: Urls.registrationUrl, body: requestBody);
    _inProgress = false;
    setState(() {});
    if (response.isSuccess) {
      showSnackBar(context, "Congratulations! Your account has been created");
      _navigateToSignInPage();
      showSnackBar(context, "Please Sign in");
      emailController.clear();
      fnameController.clear();
      lnameController.clear();
      numberController.clear();
      passController.clear();
    } else {
      showSnackBar(context, response.errorMessage, true);
    }
  }

  void _navigateToSignInPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
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

  _nameValidator(String? value) {
    if (value!.isEmpty) {
      return 'Field must not be empty';
    } else {
      return null;
    }
  }
}
