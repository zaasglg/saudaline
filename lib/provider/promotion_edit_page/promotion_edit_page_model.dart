import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'promotion_edit_page_widget.dart' show PromotionEditPageWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class PromotionEditPageModel extends FlutterFlowModel<PromotionEditPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // State field(s) for promotionName widget.
  FocusNode? promotionNameFocusNode;
  TextEditingController? promotionNameController;
  String? Function(BuildContext, String?)? promotionNameControllerValidator;
  // State field(s) for promotionShortTitle widget.
  FocusNode? promotionShortTitleFocusNode;
  TextEditingController? promotionShortTitleController;
  String? Function(BuildContext, String?)?
      promotionShortTitleControllerValidator;
  // State field(s) for PromotionDescription widget.
  FocusNode? promotionDescriptionFocusNode;
  TextEditingController? promotionDescriptionController;
  String? Function(BuildContext, String?)?
      promotionDescriptionControllerValidator;
  // Stores action output result for [Custom Action - customDatePicker] action in Container widget.
  DateTime? startDatePicker;
  // Stores action output result for [Custom Action - customDatePicker] action in Container widget.
  DateTime? endDatePicker;
  // Stores action output result for [Backend Call - API (UploadMainPhoto)] action in Button widget.
  ApiCallResponse? promotionPhoto;
  // Stores action output result for [Backend Call - API (Update Promotion By Id)] action in Button widget.
  ApiCallResponse? apiResultoUpdatePromotion;
  // Stores action output result for [Backend Call - API (Update Promotion By Id)] action in Button widget.
  ApiCallResponse? apiResultoUpdatePromotion2;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    promotionNameFocusNode?.dispose();
    promotionNameController?.dispose();

    promotionShortTitleFocusNode?.dispose();
    promotionShortTitleController?.dispose();

    promotionDescriptionFocusNode?.dispose();
    promotionDescriptionController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
