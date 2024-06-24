import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'city_selection_pega_widget.dart' show CitySelectionPegaWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class CitySelectionPegaModel extends FlutterFlowModel<CitySelectionPegaWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (CityByName)] action in Text widget.
  ApiCallResponse? apiResultSearch;
  // Stores action output result for [Custom Action - setCity] action in Container widget.
  bool? cityBoolean;
  // Stores action output result for [Custom Action - getCityId] action in Container widget.
  int? cityId;
  // Stores action output result for [Custom Action - getCityName] action in Container widget.
  String? cityName;
  // Stores action output result for [Custom Action - setCity] action in Container widget.
  bool? cityBoolean2;
  // Stores action output result for [Custom Action - getCityId] action in Container widget.
  int? cityId2;
  // Stores action output result for [Custom Action - getCityName] action in Container widget.
  String? cityName2;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
