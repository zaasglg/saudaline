// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:shared_preferences/shared_preferences.dart';

Future<bool> doesPinCodeExist() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? pinCode = prefs.getString('pinCode');
  if (pinCode != null) {
    return true;
  } else {
    return false;
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the button on the right!
