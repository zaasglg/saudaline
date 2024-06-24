import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'pincode_entry_page_widget.dart' show PincodeEntryPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class PincodeEntryPageModel extends FlutterFlowModel<PincodeEntryPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for PinCode widget.
  TextEditingController? pinCodeController;
  String? Function(BuildContext, String?)? pinCodeControllerValidator;
  // Stores action output result for [Custom Action - getPinCode] action in PinCode widget.
  String? pinCode;
  // Stores action output result for [Custom Action - getAccessToken] action in PinCode widget.
  String? accesssToken;
  // Stores action output result for [Backend Call - API (getJwtTokenByAccessToken)] action in PinCode widget.
  ApiCallResponse? apiResultjwtTokenResult;
  // Stores action output result for [Backend Call - API (getUserInfo)] action in PinCode widget.
  ApiCallResponse? apiResultnUserInfo;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    pinCodeController = TextEditingController();
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    pinCodeController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
