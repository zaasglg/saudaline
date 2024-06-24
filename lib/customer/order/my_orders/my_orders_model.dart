import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/customer/order/order_products/order_products_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'my_orders_widget.dart' show MyOrdersWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class MyOrdersModel extends FlutterFlowModel<MyOrdersWidget> {
  ///  Local state fields for this page.

  OrderStatus? orderStatus;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (OrderById)] action in Container widget.
  ApiCallResponse? apiResultj5eCopy;

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
