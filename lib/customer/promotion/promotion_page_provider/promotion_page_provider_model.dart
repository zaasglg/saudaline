import '/backend/api_requests/api_calls.dart';
import '/customer/order/promotion_product_discount_change/promotion_product_discount_change_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'promotion_page_provider_widget.dart' show PromotionPageProviderWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class PromotionPageProviderModel
    extends FlutterFlowModel<PromotionPageProviderWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (Delete Promotion By Id)] action in Button widget.
  ApiCallResponse? apiResultDeletePromotion;
  // Stores action output result for [Backend Call - API (Delete Product From Promotion By Id)] action in Row widget.
  ApiCallResponse? apiResultyDeleteProductFromPromotion;

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
