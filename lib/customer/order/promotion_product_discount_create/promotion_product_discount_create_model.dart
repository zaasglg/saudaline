import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'promotion_product_discount_create_widget.dart'
    show PromotionProductDiscountCreateWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class PromotionProductDiscountCreateModel
    extends FlutterFlowModel<PromotionProductDiscountCreateWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for discount widget.
  FocusNode? discountFocusNode;
  TextEditingController? discountController;
  String? Function(BuildContext, String?)? discountControllerValidator;
  // Stores action output result for [Backend Call - API ( Add Discount To Product)] action in Button widget.
  ApiCallResponse? apiResultcAddDiscountToPromotion;

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
