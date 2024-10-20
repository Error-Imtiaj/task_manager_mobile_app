import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/UI/utils/colors.dart';

void showSnackBar(BuildContext context, String message,
    [bool isError = false]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: isError ? Colors.white : Colors.black),
      ),
      backgroundColor: isError ? Colors.red : ColorsUtils.fieldPrimaryColor,
    ),
  );
}
