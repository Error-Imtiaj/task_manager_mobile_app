import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Textfieldwidget extends StatelessWidget {
  final String hintText;
  final Color fillColor;
  final TextEditingController controller;
  final bool? secureText;
  final TextInputType? keyboardtype;
  final BorderRadius? Borderradias;
  final Widget? label;
  final int? maxlength;
  final int? maxline;
  final String? Function(String?) validatorFunction;

  const Textfieldwidget({
    super.key,
    required this.fillColor,
    required this.controller,
    this.secureText,
    required this.hintText,
    this.keyboardtype,
    this.Borderradias,
    this.label,
    this.maxlength,
    this.maxline,
    required this.validatorFunction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: secureText ?? false,
      decoration: InputDecoration(
        label: label ?? null,
        fillColor: fillColor,
        filled: true,
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(fontSize: 18),
        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: Borderradias ?? BorderRadius.circular(70),
          borderSide: BorderSide.none,
        ),
        border: OutlineInputBorder(
          borderRadius: Borderradias ?? BorderRadius.circular(70),
          borderSide: BorderSide.none,
        ),
      ),
      keyboardType: keyboardtype ?? TextInputType.name,
      maxLength: maxlength,
      maxLines: maxline ?? 1,
      validator: validatorFunction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
