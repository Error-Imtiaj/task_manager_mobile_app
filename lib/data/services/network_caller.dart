import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager_mobile_app/UI/screens/login_screen.dart';
import 'package:task_manager_mobile_app/app.dart';
import 'package:task_manager_mobile_app/auth/auth.dart';
import 'package:task_manager_mobile_app/data/model/network_response.dart';

class NetworkCaller {
  // GET REQUEST
  static Future<NetworkModel> getRequest({required String url, Map<String,String>? headers}) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint(url);
      Response response = await get(uri, headers:headers );
      printDebug(url, response);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return NetworkModel(
          statusCode: response.statusCode,
          isSuccess: true,
          message: decodeData['data'],
        );
      } else if (response.statusCode == 401) {
        _moveToLogin();
        return NetworkModel(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: "Unauthorized",
        );
      } else {
        return NetworkModel(
            statusCode: response.statusCode,
            isSuccess: false,
            errorMessage: jsonDecode(response.body)['data']);
      }
    } catch (e) {
      return NetworkModel(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  // POST REQUEST
  static Future<NetworkModel> postRequest(
      {required String url,
      Map<String, dynamic>? body,
      Map<String, String>? header}) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint(url);
      final encodeData = jsonEncode(body);
      Response response = await post(uri,
          headers: header ?? {'Content-Type': 'application/json'},
          body: encodeData);
      printDebug(url, response);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        if (decodeData['status'] == 'fail') {
          return NetworkModel(
            statusCode: response.statusCode,
            isSuccess: false,
            errorMessage: decodeData['data'],
          );
        }

        return NetworkModel(
            statusCode: response.statusCode,
            isSuccess: true,
            message: decodeData['data'],
            fullBody: decodeData);
      } else if (response.statusCode == 401) {
        _moveToLogin();
        return NetworkModel(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: "Unauthorized",
        );
      } else {
        final decodeData = jsonDecode(response.body);
        return NetworkModel(
            statusCode: response.statusCode,
            isSuccess: false,
            errorMessage: decodeData['data']);
      }
    } catch (e) {
      return NetworkModel(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  // DEBUG PRINT
  static void printDebug(String url, Response response) {
    debugPrint(
        'URL: $url\nRESPONSE: ${response.statusCode}\nBODY: ${response.body}');
  }

  // MOVE TO LOGIN
  static Future<void> _moveToLogin() async {
    Auth.clearUserData(); // Clear user data

    Navigator.pushAndRemoveUntil(
      TaskMangerApp.navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (p) => false,
    );
  }
}
