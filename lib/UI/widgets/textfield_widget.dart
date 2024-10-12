import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Textfieldwidget extends StatelessWidget {
  final String hintText;
  final Color fillColor;
  final TextEditingController controller;
  final bool? secureText;
  final TextInputType? keyboardtype;
  const Textfieldwidget({
    super.key,
    required this.fillColor,
    required this.controller,
    this.secureText,
    required this.hintText,
    this.keyboardtype,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: secureText ?? false,
      decoration: InputDecoration(
        fillColor: fillColor,
        filled: true,
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(fontSize: 18),
        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(70),
          borderSide: BorderSide.none,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(70),
          borderSide: BorderSide.none,
        ),
      ),
      keyboardType: keyboardtype ?? TextInputType.name,
    );
  }
}
