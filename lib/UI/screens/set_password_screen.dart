import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager_mobile_app/UI/screens/login_screen.dart';
import 'package:task_manager_mobile_app/UI/utils/colors.dart';
import 'package:task_manager_mobile_app/UI/utils/urls.dart';
import 'package:task_manager_mobile_app/UI/widgets/custom_button.dart';
import 'package:task_manager_mobile_app/UI/widgets/snack_bar.dart';
import 'package:task_manager_mobile_app/UI/widgets/textfield_widget.dart';
import 'package:task_manager_mobile_app/data/model/network_response.dart';
import 'package:task_manager_mobile_app/data/services/network_caller.dart';

class SetPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;
  const SetPasswordScreen({super.key, required this.email, required this.otp});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isLoading = false;

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
                    fontSize: 14,
                  ),
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
            Form(
              key: _formkey,
              child: Textfieldwidget(
                fillColor: ColorsUtils.fieldPrimaryColor,
                controller: _confirmPassController,
                hintText: "Confirm Password",
                validatorFunction: (p0) => _validator2(p0),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // BUTTON SET PASSWORD
            Visibility(
              visible: !_isLoading,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: Custombutton(
                ButtonName: "Set Password",
                ontap: () {
                  if (_formkey.currentState!.validate()) {
                    _setPassword();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _setPassword() async {
    try {
      _isLoading = true;
      setState(() {});
      Map<String, dynamic> body = {
        "email": widget.email,
        "OTP": widget.otp,
        "password": _passController.text,
      };
      NetworkModel setPasswordResponse = await NetworkCaller.postRequest(
        url: Urls.setPassUrl,
        body: body,
      );
      _isLoading = false;
      setState(() {});
      if (setPasswordResponse.statusCode == 200) {
        showSnackBar(context, setPasswordResponse.message);
        _navigateToSignInPage();
      } else {
        showSnackBar(context, setPasswordResponse.errorMessage);
      }
    } catch (e) {
      _isLoading = false;
      setState(() {});
      showSnackBar(context, e.toString());
    }
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

  _validator2(
    String? value,
  ) {
    if (value!.isEmpty) {
      return 'Field must not be empty';
    } else if (value.length <= 8) {
      return 'Input must be more than 8 character';
    } else if (_passController.text != _confirmPassController.text) {
      return 'Password do not match';
    } else {
      return null;
    }
  }
}
