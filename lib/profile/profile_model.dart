import '/backend/api_requests/api_calls.dart';
import '/components/connect_tariff_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'profile_widget.dart' show ProfileWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class ProfileModel extends FlutterFlowModel<ProfileWidget> {
  ///  Local state fields for this page.

  bool isLoading = true;

  bool tariffEist = false;

  int? balance = 0;

  bool tariffRequestExist = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (checkToken)] action in Profile widget.
  ApiCallResponse? apiResult0no;
  // Stores action output result for [Backend Call - API (getUserInfo)] action in Profile widget.
  ApiCallResponse? apiResultnUserInfo;
  // Stores action output result for [Backend Call - API (Get Provider Info By Principal To mobile)] action in Profile widget.
  ApiCallResponse? apiProviderInfoByPrincipal;
  // Stores action output result for [Custom Action - doesPinCodeExist] action in Profile widget.
  bool? doesPinExist;
  // Stores action output result for [Custom Action - deleteJwtTokenAction] action in contentView_1 widget.
  bool? actionExit;
  // Stores action output result for [Custom Action - deleteJwtTokenAction] action in contentView_1 widget.
  bool? actionExitProvider;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
