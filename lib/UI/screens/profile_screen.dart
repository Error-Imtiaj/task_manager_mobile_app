import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_mobile_app/UI/controller/profile_update_controller.dart';
import 'package:task_manager_mobile_app/UI/screens/navigation_screen.dart';
import 'package:task_manager_mobile_app/UI/utils/colors.dart';
import 'package:task_manager_mobile_app/UI/widgets/custom_button.dart';
import 'package:task_manager_mobile_app/UI/widgets/snack_bar.dart';
import 'package:task_manager_mobile_app/UI/widgets/textfield_widget.dart';
import 'package:task_manager_mobile_app/UI/widgets/tm_Appbar.dart';

class ProfileScreen extends StatefulWidget {
  static const String text = '/updateProfile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final _profileUpdateController = Get.find<ProfileUpdateController>();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    fnameController.dispose();
    lnameController.dispose();
    numberController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TmAppbar(
        isprofile: true,
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
                  "Update Your profile",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: ColorsUtils.primaryColor,
                      ),
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
                GetBuilder<ProfileUpdateController>(builder: (context) {
                  return Visibility(
                    visible: !context.inProgress,
                    replacement: Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: Custombutton(
                      ButtonName: "Update",
                      ontap: () {
                        if (_formKey.currentState!.validate()) {
                          _updateProfile();
                        }
                      },
                    ),
                  );
                }),
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
        child: Column(
          children: [
            // EMAIL
            Textfieldwidget(
              fillColor: ColorsUtils.fieldPrimaryColor,
              controller: emailController,
              hintText: "Email",
            ),
            const SizedBox(
              height: 10,
            ),
            // FIRST NAME
            Textfieldwidget(
              fillColor: ColorsUtils.fieldPrimaryColor,
              controller: fnameController,
              hintText: "First Name",
            ),
            const SizedBox(
              height: 10,
            ),

            // LAST NAME
            Textfieldwidget(
              fillColor: ColorsUtils.fieldPrimaryColor,
              controller: lnameController,
              hintText: "Last Name",
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
            ),
          ],
        ));
  }

  void _navigateToDashboard() {
    Get.toNamed(NavigationScreen.text);
  }

  Future<void> _updateProfile() async {
    final bool result = await _profileUpdateController.updateProfile(
      emailController.text.trim(),
      fnameController.text,
      lnameController.text,
      numberController.text,
      passController.text,
    );
    if (result) {
      showSnackBar(context, "Your profile has been successfully updated");
      _navigateToDashboard();
    } else {
      showSnackBar(context, _profileUpdateController.errorMessage!);
    }
  }
}
