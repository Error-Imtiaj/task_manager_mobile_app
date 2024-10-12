import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager_mobile_app/UI/utils/colors.dart';

class Custombutton extends StatelessWidget {
  final Function()? ontap;
  final String ButtonName;
  const Custombutton({super.key, this.ontap, required this.ButtonName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: ColorsUtils.primaryColor,
            borderRadius: BorderRadius.circular(70)),
        child: Center(
          child: Text(
            ButtonName,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
