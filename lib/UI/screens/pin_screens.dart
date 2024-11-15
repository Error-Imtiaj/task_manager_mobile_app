import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager_mobile_app/UI/controller/pin_controller.dart';
import 'package:task_manager_mobile_app/UI/screens/set_password_screen.dart';
import 'package:task_manager_mobile_app/UI/utils/assetPath.dart';
import 'package:task_manager_mobile_app/UI/utils/colors.dart';
import 'package:task_manager_mobile_app/UI/widgets/custom_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_mobile_app/UI/widgets/snack_bar.dart';

class PinScreens extends StatefulWidget {
  static const String text = '/pinScreen';
  final String email;
  const PinScreens({super.key, required this.email});

  @override
  State<PinScreens> createState() => _PinScreensState();
}

class _PinScreensState extends State<PinScreens> {
  final TextEditingController pinController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey();
  final pinGetController = Get.find<PinControllerGet>();
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
                      fontSize: 14,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),

              // PIN FIELD
              Form(
                autovalidateMode: AutovalidateMode.disabled,
                key: _formkey,
                child: _verifyPin(),
              ),
              const SizedBox(
                height: 20,
              ),

              // BUTTON
              GetBuilder<PinControllerGet>(
                init: PinControllerGet(),
                initState: (_) {},
                builder: (Context) {
                  return Visibility(
                    visible: !Context.inprogressPinVerify,
                    replacement:
                        const Center(child: CircularProgressIndicator()),
                    child: Custombutton(
                      ButtonName: "Verify",
                      ontap: () {
                        if (_formkey.currentState!.validate()) {
                          _pinVerification();
                        }
                      },
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              GetBuilder<PinControllerGet>(
                init: PinControllerGet(),
                initState: (_) {},
                builder: (Context) {
                  return Visibility(
                    visible: !Context.resendAgain,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: "Haven't received the OTP? ",
                                style: GoogleFonts.poppins(
                                    color: ColorsUtils.primaryColor)),
                            TextSpan(
                              text: " Send again",
                              style: GoogleFonts.poppins(
                                  color: ColorsUtils.primaryColor,
                                  fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = _sendVerificationMail,
                            ),
                          ],
                        ),
                      ),
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

  // SEND VERIFICATION EMAIL
  Future _sendVerificationMail() async {
    bool result = await pinGetController.sendVerificationMail(widget.email);
    if (result) {
      showSnackBar(
        context,
        pinGetController.message!,
        false,
      );
    } else {
      showSnackBar(context, pinGetController.message!, true);
    }
  }
  // PIN VERIFICATION

  Future _pinVerification() async {
    bool result = await pinGetController.pinVerification(
        widget.email, pinController.text);
    if (result) {
      showSnackBar(context, pinGetController.message!, false);
      _navigateToSetPass();
    } else {
      showSnackBar(context, pinGetController.message!, true);
    }
  }

  void _navigateToSetPass() {
    Get.to(
      () => SetPasswordScreen(email: widget.email, otp: pinController.text),
    );
  }

  Widget _verifyPin() {
    return PinCodeTextField(
      validator: (value) {
        if (value!.isEmpty || value.length < 6) {
          return 'Please enter 6 digit OTP';
        } else if (value.contains(RegExp(r'[0-9]')) == false) {
          return 'Pin only contains numbers';
        } else {
          return null;
        }
      },
      blinkWhenObscuring: true,
      controller: pinController,
      length: 6,
      obscureText: true,
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
        selectedColor: ColorsUtils.primaryColor,
      ),
      animationDuration: const Duration(
        milliseconds: 300,
      ),
      enableActiveFill: true,
      appContext: context,
      keyboardType: TextInputType.number,
    );
  }
}
