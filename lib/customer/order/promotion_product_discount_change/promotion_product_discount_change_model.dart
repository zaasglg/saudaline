import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'promotion_product_discount_change_widget.dart'
    show PromotionProductDiscountChangeWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class PromotionProductDiscountChangeModel
    extends FlutterFlowModel<PromotionProductDiscountChangeWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for discount widget.
  FocusNode? discountFocusNode;
  TextEditingController? discountController;
  String? Function(BuildContext, String?)? discountControllerValidator;
  // Stores action output result for [Backend Call - API (Update Product Promotion Discount)] action in Button widget.
  ApiCallResponse? apiResultcUpdateDiscount;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    discountFocusNode?.dispose();
    discountController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
