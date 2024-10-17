

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager_mobile_app/UI/screens/set_password_screen.dart';
import 'package:task_manager_mobile_app/UI/utils/assetPath.dart';
import 'package:task_manager_mobile_app/UI/utils/colors.dart';
import 'package:task_manager_mobile_app/UI/widgets/custom_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinScreens extends StatefulWidget {
  const PinScreens({super.key});

  @override
  State<PinScreens> createState() => _PinScreensState();
}

class _PinScreensState extends State<PinScreens> {
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset(
                Assetpath.pinSvg,
                width: 200,
              ),
              const SizedBox(
                height: 80,
              ),
              // TITLE
              Text(
                "Pin Verification",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: ColorsUtils.primaryColor,
                    fontSize: 34),
              ),
              // SENT MEAASGE

              Text(
                "Write the 6 digit OTP which was sent to your email",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: Colors.grey,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 30,
              ),

              // EMAIL FIELD
              _verifyPin(),
              const SizedBox(
                height: 20,
              ),

              // BUTTON
              Custombutton(
                ButtonName: "Verify",
                // TODO VERIFY
                ontap: () {
                  _navigateToSetPass();
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToSetPass() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> const SetPasswordScreen()
    ));
  }

  Widget _verifyPin() {
    return PinCodeTextField(
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: Colors.transparent,
          inactiveFillColor: ColorsUtils.fieldPrimaryColor,
          activeColor: ColorsUtils.primaryColor,
          inactiveColor: ColorsUtils.primaryColor,
          selectedFillColor: Colors.transparent,
          selectedColor: ColorsUtils.primaryColor),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      appContext: context,
      keyboardType: TextInputType.number,
    );
  }
}
