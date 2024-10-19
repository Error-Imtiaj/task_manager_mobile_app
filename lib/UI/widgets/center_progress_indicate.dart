import 'package:flutter/material.dart';

class CenterProgressIndicate extends StatelessWidget {
  const CenterProgressIndicate({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
