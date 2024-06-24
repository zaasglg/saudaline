import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'registration_page_widget.dart' show RegistrationPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class RegistrationPageModel extends FlutterFlowModel<RegistrationPageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for businessName widget.
  FocusNode? businessNameFocusNode;
  TextEditingController? businessNameTextController;
  String? Function(BuildContext, String?)? businessNameTextControllerValidator;
  String? _businessNameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Поле, обязательное для заполнения';
    }

    return null;
  }

  // State field(s) for providerCategory widget.
  String? providerCategoryValue;
  FormFieldController<String>? providerCategoryValueController;
  // State field(s) for businessNumber widget.
  FocusNode? businessNumberFocusNode;
  TextEditingController? businessNumberTextController;
  final businessNumberMask = MaskTextInputFormatter(mask: '############');
  String? Function(BuildContext, String?)?
  businessNumberTextControllerValidator;
  String? _businessNumberTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Поле, обязательное для заполнения';
    }

    return null;
  }

  // State field(s) for formBusiness widget.
  FormFieldController<String>? formBusinessValueController;
  // State field(s) for region widget.
  String? regionValue;
  FormFieldController<String>? regionValueController;
  // State field(s) for city widget.
  List<String>? cityValue;
  FormFieldController<List<String>>? cityValueController;
  // State field(s) for address widget.
  FocusNode? addressFocusNode;
  TextEditingController? addressTextController;
  String? Function(BuildContext, String?)? addressTextControllerValidator;
  String? _addressTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Поле, обязательное для заполнения';
    }

    return null;
  }

  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  String? _nameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Поле, обязательное для заполнения';
    }

    return null;
  }

  // State field(s) for surname widget.
  FocusNode? surnameFocusNode;
  TextEditingController? surnameTextController;
  String? Function(BuildContext, String?)? surnameTextControllerValidator;
  String? _surnameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Поле, обязательное для заполнения';
    }

    return null;
  }

  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  String? _emailTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Поле, обязательное для заполнения';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Has to be a valid email address.';
    }
    return null;
  }

  // State field(s) for phoneNumber widget.
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberTextController;
  final phoneNumberMask = MaskTextInputFormatter(mask: '+# (###) ###-##-##');
  String? Function(BuildContext, String?)? phoneNumberTextControllerValidator;
  String? _phoneNumberTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Поле, обязательное для заполнения';
    }

    return null;
  }

  // State field(s) for login widget.
  FocusNode? loginFocusNode;
  TextEditingController? loginTextController;
  String? Function(BuildContext, String?)? loginTextControllerValidator;
  String? _loginTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Поле, обязательное для заполнения';
    }

    if (!RegExp(kTextValidatorUsernameRegex).hasMatch(val)) {
      return 'Must start with a letter and can only contain letters, digits and - or _.';
    }
    return null;
  }

  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;
  String? _passwordTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Поле, обязательное для заполнения';
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (Registration Saudaline)] action in Button widget.
  ApiCallResponse? apiResult5od;
  // Stores action output result for [Backend Call - API (SendVerificationMail)] action in Button widget.
  ApiCallResponse? apiResultx2j;

  @override
  void initState(BuildContext context) {
    businessNameTextControllerValidator = _businessNameTextControllerValidator;
    businessNumberTextControllerValidator = _businessNumberTextControllerValidator;
    addressTextControllerValidator = _addressTextControllerValidator;
    nameTextControllerValidator = _nameTextControllerValidator;
    surnameTextControllerValidator = _surnameTextControllerValidator;
    emailTextControllerValidator = _emailTextControllerValidator;
    phoneNumberTextControllerValidator = _phoneNumberTextControllerValidator;
    loginTextControllerValidator = _loginTextControllerValidator;
    passwordVisibility = false;
    passwordTextControllerValidator = _passwordTextControllerValidator;
  }

  @override
  void dispose() {
    businessNameFocusNode?.dispose();
    businessNameTextController?.dispose();

    businessNumberFocusNode?.dispose();
    businessNumberTextController?.dispose();

    addressFocusNode?.dispose();
    addressTextController?.dispose();

    nameFocusNode?.dispose();
    nameTextController?.dispose();

    surnameFocusNode?.dispose();
    surnameTextController?.dispose();

    emailFocusNode?.dispose();
    emailTextController?.dispose();

    phoneNumberFocusNode?.dispose();
    phoneNumberTextController?.dispose();

    loginFocusNode?.dispose();
    loginTextController?.dispose();

    passwordFocusNode?.dispose();
    passwordTextController?.dispose();
  }

  /// Additional helper methods.
  String? get formBusinessValue => formBusinessValueController?.value;
}
