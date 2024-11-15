import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_mobile_app/UI/controller/set_password_controller.dart';
import 'package:task_manager_mobile_app/UI/screens/login_screen.dart';
import 'package:task_manager_mobile_app/UI/utils/colors.dart';
import 'package:task_manager_mobile_app/UI/widgets/custom_button.dart';
import 'package:task_manager_mobile_app/UI/widgets/snack_bar.dart';
import 'package:task_manager_mobile_app/UI/widgets/textfield_widget.dart';

class SetPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;
  static const text = '/setPassScreen';
  const SetPasswordScreen({super.key, required this.email, required this.otp});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final SetPasswordController controller = Get.find<SetPasswordController>();

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
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Set Your Password",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorsUtils.primaryColor,
                      fontSize: 32,
                    ),
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
              Textfieldwidget(
                fillColor: ColorsUtils.fieldPrimaryColor,
                controller: _confirmPassController,
                hintText: "Confirm Password",
                validatorFunction: (p0) => _validator2(p0),
              ),
              const SizedBox(
                height: 20,
              ),
              // BUTTON SET PASSWORD
              GetBuilder<SetPasswordController>(
                init: controller,
                initState: (_) {},
                builder: (controller) {
                  // Change `context` to `controller`
                  return Visibility(
                    visible: !(controller.isLoading ??
                        false), // Access isLoading from the controller
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: Custombutton(
                      ButtonName: "Set Password",
                      ontap: () {
                        if (_formkey.currentState!.validate()) {
                          if (_passController.text ==
                              _confirmPassController.text) {
                            _setPassword();
                          } else {
                            showSnackBar(context, "Passwords do not match");
                          }
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _setPassword() async {
    final bool setResponse = await controller.setPassword(
        widget.email, widget.otp, _passController.text);
    if (setResponse) {
      showSnackBar(context, controller.messsage!);
      _navigateToSignInPage();
    } else {
      showSnackBar(context, controller.messsage!);
    }
  }

  void _navigateToSignInPage() {
    Get.toNamed(LoginScreen.text);
  }

  String? _validator(String? value) {
    if (value!.isEmpty) {
      return 'Field must not be empty';
    } else if (value.length <= 5) {
      return 'Input must be more than 5 characters';
    } else {
      return null;
    }
  }

  String? _validator2(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field must not be empty';
    } else if (value.length <= 5) {
      return 'Input must be more than 5 characters';
    } else {
      return null;
    }
  }
}
