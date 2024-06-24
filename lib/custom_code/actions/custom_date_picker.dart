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

Future<DateTime?> customDatePicker(BuildContext context) async {
  final _datePickedDate = await showDatePicker(
    context: context,
    locale: const Locale("ru"),
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2050),
  );

  if (_datePickedDate != null) {
    return DateTime(
      _datePickedDate.year,
      _datePickedDate.month,
      _datePickedDate.day,
    );
  } else {
    return null;
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the button on the right!
