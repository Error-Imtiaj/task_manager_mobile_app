import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager_mobile_app/UI/screens/set_password_screen.dart';
import 'package:task_manager_mobile_app/UI/utils/assetPath.dart';
import 'package:task_manager_mobile_app/UI/utils/colors.dart';
import 'package:task_manager_mobile_app/UI/utils/urls.dart';
import 'package:task_manager_mobile_app/UI/widgets/custom_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_mobile_app/UI/widgets/snack_bar.dart';
import 'package:task_manager_mobile_app/data/model/network_response.dart';
import 'package:task_manager_mobile_app/data/services/network_caller.dart';

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
  bool _inProgressVerify = false;
  bool _resendAgain = false;
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
              Visibility(
                visible: !_inProgressVerify,
                replacement: const Center(child: CircularProgressIndicator()),
                child: Custombutton(
                  ButtonName: "Verify",
                  ontap: () {
                    if (_formkey.currentState!.validate()) {
                      _pinVerification();
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: !_resendAgain,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _sendVerificationMail() async {
    // LOADING START
    _resendAgain = true;
    setState(() {});
    try {
      NetworkModel sendMailResponse = await NetworkCaller.getRequest(
        url: '${Urls.sendOtpToEmailUrl}/${widget.email}',
      );
      // LOADING END
      _resendAgain = false;
      setState(() {});
      if (sendMailResponse.statusCode == 200) {
        showSnackBar(
          context,
          sendMailResponse.message,
          false,
        );
      } else {
        showSnackBar(context, sendMailResponse.errorMessage, true);
      }
    } catch (e) {
      // LOADING END
      _resendAgain = false;
      setState(() {});
      showSnackBar(context, e.toString(), true);
    }
  }

  Future _pinVerification() async {
    // LOADING START
    _inProgressVerify = true;
    setState(() {});

    try {
      NetworkModel pinVerifycall = await NetworkCaller.getRequest(
        url: '${Urls.pinVerifyUrl}/${widget.email}/${pinController.text}',
      );
      // LOADING END
      _inProgressVerify = false;
      setState(() {});
      if (pinVerifycall.statusCode == 200) {
        showSnackBar(context, pinVerifycall.message, false);
        _navigateToSetPass();
      } else {
        showSnackBar(context, pinVerifycall.errorMessage, true);
      }
    } catch (e) {
      // LOADING END
      _inProgressVerify = false;
      setState(() {});
      // SHOW THE ERROR
      showSnackBar(context, e.toString(), true);
    }
  }

  void _navigateToSetPass() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SetPasswordScreen(
                  email: widget.email,
                  otp: pinController.text,
                )));
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
