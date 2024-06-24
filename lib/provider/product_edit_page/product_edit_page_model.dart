import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import 'product_edit_page_widget.dart' show ProductEditPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class ProductEditPageModel extends FlutterFlowModel<ProductEditPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // State field(s) for productName widget.
  FocusNode? productNameFocusNode;
  TextEditingController? productNameController;
  String? Function(BuildContext, String?)? productNameControllerValidator;
  // State field(s) for productArticle widget.
  FocusNode? productArticleFocusNode;
  TextEditingController? productArticleController;
  String? Function(BuildContext, String?)? productArticleControllerValidator;
  // State field(s) for Description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionController;
  String? Function(BuildContext, String?)? descriptionControllerValidator;
  // State field(s) for Category widget.
  String? categoryValue;
  FormFieldController<String>? categoryValueController;
  // State field(s) for Brand widget.
  String? brandValue;
  FormFieldController<String>? brandValueController;
  // State field(s) for Price widget.
  FocusNode? priceFocusNode;
  TextEditingController? priceController;
  String? Function(BuildContext, String?)? priceControllerValidator;
  // Stores action output result for [Backend Call - API (UploadMainPhoto)] action in Button widget.
  ApiCallResponse? mainPhoto;
  // Stores action output result for [Backend Call - API (UpdateProduct)] action in Button widget.
  ApiCallResponse? apiResultoUpdateProduct;
  // Stores action output result for [Backend Call - API (UpdateProduct)] action in Button widget.
  ApiCallResponse? apiResultoUpdateProductWithoutPhoto;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    productNameFocusNode?.dispose();
    productNameController?.dispose();
    productArticleController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionController?.dispose();

    priceFocusNode?.dispose();
    priceController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
