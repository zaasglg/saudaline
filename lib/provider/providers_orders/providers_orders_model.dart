import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'providers_orders_widget.dart' show ProvidersOrdersWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class ProvidersOrdersModel extends FlutterFlowModel<ProvidersOrdersWidget> {
  ///  Local state fields for this page.

  OrderStatus? orderStatus;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (OrderById)] action in Container widget.
  ApiCallResponse? apiResultj5eCopy;
  // Stores action output result for [Backend Call - API (AcceptOrder)] action in Row widget.
  ApiCallResponse? apiResultAccept;
  // Stores action output result for [Backend Call - API (RejectOrder)] action in Row widget.
  ApiCallResponse? apiResultRejectOrder;

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
