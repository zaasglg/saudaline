import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sauda_line/provider/providers_products/providers_products_widget.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'product_edit_page_model.dart';
export 'product_edit_page_model.dart';

class ProductEditPageWidget extends StatefulWidget {
  const ProductEditPageWidget({
    super.key,
    required this.productId,
  });

  final int? productId;

  @override
  State<ProductEditPageWidget> createState() => _ProductEditPageWidgetState();
}

class _ProductEditPageWidgetState extends State<ProductEditPageWidget> {
  late ProductEditPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProductEditPageModel());

    _model.productNameFocusNode ??= FocusNode();

    _model.productArticleFocusNode ??= FocusNode();

    _model.descriptionFocusNode ??= FocusNode();

    _model.priceFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<ApiCallResponse>(
      future: GetProductByIdCall.call(
        id: widget.productId,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        final productEditPageGetProductByIdResponse = snapshot.data!;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).primary,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 24.0,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              title: Text(
                'Редактировать',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      fontSize: 22.0,
                    ),
              ),
              actions: [],
              centerTitle: true,
              elevation: 2.0,
            ),
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Align(
                      alignment: AlignmentDirectional(-1.0, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 0.0, 0.0),
                        child: Text('Изображение товара',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontFamily: 'Gilroy', color: Color(0xFF787878),),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Stack(
                          children: [
                            if (_model.uploadedLocalFile == null ||
                                (_model.uploadedLocalFile.bytes?.isEmpty ??
                                    true))
                              Align(
                                alignment: AlignmentDirectional(-1.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(10.0, 8.0, 10.0, 0.0),
                                  child: Container(
                                    width: 200.0,
                                    height: 120.0,
                                    decoration: BoxDecoration(),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: GetProductByIdCall.productImage(
                                        productEditPageGetProductByIdResponse.jsonBody,
                                      ) != null
                                          ? Image.network(
                                        GetProductByIdCall.productImage(
                                          productEditPageGetProductByIdResponse.jsonBody,
                                        )!,
                                        width: 300.0,
                                        height: 200.0,
                                        fit: BoxFit.fitHeight,
                                      )
                                          : Placeholder(), // Placeholder can be replaced with any widget you want to show when the image is null
                                    ),
                                  ),
                                ),
                              ),

                            if (_model.uploadedLocalFile != null && (_model.uploadedLocalFile.bytes?.isNotEmpty ?? false))
                              Align(
                                alignment: AlignmentDirectional(-1.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 8.0, 10.0, 0.0),
                                  child: Container(
                                    width: 200.0,
                                    height: 120.0,
                                    decoration: BoxDecoration(),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.memory(
                                        _model.uploadedLocalFile.bytes ??
                                            Uint8List.fromList([]),
                                        width: 300.0,
                                        height: 200.0,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            // NewImageUpload
                            final selectedMedia = await selectMedia(
                              mediaSource: MediaSource.photoGallery,
                              multiImage: false,
                            );
                            if (selectedMedia != null &&
                                selectedMedia.every((m) => validateFileFormat(
                                    m.storagePath, context))) {
                              setState(() => _model.isDataUploading = true);
                              var selectedUploadedFiles = <FFUploadedFile>[];

                              try {
                                selectedUploadedFiles = selectedMedia
                                    .map((m) => FFUploadedFile(
                                          name: m.storagePath.split('/').last,
                                          bytes: m.bytes,
                                          height: m.dimensions?.height,
                                          width: m.dimensions?.width,
                                          blurHash: m.blurHash,
                                        ))
                                    .toList();
                              } finally {
                                _model.isDataUploading = false;
                              }
                              if (selectedUploadedFiles.length ==
                                  selectedMedia.length) {
                                setState(() {
                                  _model.uploadedLocalFile =
                                      selectedUploadedFiles.first;
                                });
                              } else {
                                setState(() {});
                                return;
                              }
                            }
                          },
                          text: 'Изменить',
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                            color: Color(0xFF939B9E),
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                ),
                            elevation: 3.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: AlignmentDirectional(-1.0, 0.0),
                      child: Padding(padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                        child: Text(
                          'Наименование товара',
                          textAlign: TextAlign.start,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF787878),
                                  ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8.0, 10.0, 8.0, 0.0),
                      child: TextFormField(
                        controller: _model.productNameController ??=
                            TextEditingController(
                          text: GetProductByIdCall.productName(
                            productEditPageGetProductByIdResponse.jsonBody,
                          ),
                        ),
                        focusNode: _model.productNameFocusNode,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintStyle: FlutterFlowTheme.of(context).labelMedium,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFCFCFCF),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium,
                        maxLines: 2,
                        validator: _model.productNameControllerValidator
                            .asValidator(context),
                      ),
                    ),


                    // article
                    Align(
                      alignment: AlignmentDirectional(-1.0, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 10.0, 0.0, 0.0),
                        child: Text(
                          'Артикуль товара',
                          textAlign: TextAlign.start,
                          style:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFF787878),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8.0, 10.0, 8.0, 0.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: CupertinoButton(
                            color: CupertinoColors.systemGrey5,
                            child: const Text("Сканировать штрих код", style: TextStyle(
                                fontFamily: "Gilroy",
                                color: CupertinoColors.black
                            ),),
                            onPressed: () async {
                              var res = await Navigator.push(context,
                                  MaterialPageRoute(
                                    builder: (context) => const SimpleBarcodeScannerPage(
                                      cancelButtonText: "Назад",
                                    ),
                                  ));

                              setState(() async {
                                _model.productArticleController.text = res;
                              });
                            }
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8.0, 10.0, 8.0, 0.0),
                      child: TextFormField(
                        controller: _model.productArticleController ??=
                            TextEditingController(
                              text: GetProductByIdCall.productArticle(
                                productEditPageGetProductByIdResponse.jsonBody,
                              ),
                            ),
                        focusNode: _model.productArticleFocusNode,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintStyle: FlutterFlowTheme.of(context).labelMedium,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFFCFCFCF),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium,
                        maxLines: 1,
                        validator: _model.productArticleControllerValidator
                            .asValidator(context),
                      ),
                    ),


                    Align(
                      alignment: AlignmentDirectional(-1.0, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 10.0, 0.0, 0.0),
                        child: Text(
                          'Краткое описание продукта',
                          textAlign: TextAlign.start,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF787878),
                                  ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _model.descriptionController ??=
                            TextEditingController(
                          text: getJsonField(
                            productEditPageGetProductByIdResponse.jsonBody,
                            r'''$.description''',
                          ).toString(),
                        ),
                        focusNode: _model.descriptionFocusNode,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: FlutterFlowTheme.of(context).labelMedium,
                          hintStyle: FlutterFlowTheme.of(context).labelMedium,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium,
                        maxLines: 7,
                        validator: _model.descriptionControllerValidator
                            .asValidator(context),
                      ),
                    ),

                    Align(
                      alignment: AlignmentDirectional(-1.0, 0.0),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                        child: Text(
                          'Категория',
                          textAlign: TextAlign.start,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF787878),
                                  ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 0.0),
                      child: FutureBuilder<ApiCallResponse>(
                        future:
                            CategoryGroup.getCategoryTitlesByProviderCall.call(
                          userId: getJsonField(
                            FFAppState().accountInfo,
                            r'''$.id''',
                          ),
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    FlutterFlowTheme.of(context).primary,
                                  ),
                                ),
                              ),
                            );
                          }
                          final categoryGetCategoryTitlesByProviderResponse =
                              snapshot.data!;
                          return FlutterFlowDropDown<String>(
                            controller: _model.categoryValueController ??=
                                FormFieldController<String>(
                              _model.categoryValue ??= getJsonField(
                                productEditPageGetProductByIdResponse.jsonBody,
                                r'''$.category.title''',
                              ).toString(),
                            ),
                            options: List<String>.from(CategoryGroup
                                .getCategoryTitlesByProviderCall
                                .listOfTitles(
                              categoryGetCategoryTitlesByProviderResponse
                                  .jsonBody,
                            )!),
                            optionLabels: CategoryGroup
                                .getCategoryTitlesByProviderCall
                                .listOfTitles(
                              categoryGetCategoryTitlesByProviderResponse
                                  .jsonBody,
                            )!,
                            onChanged: (val) =>
                                setState(() => _model.categoryValue = val),
                            width: double.infinity,
                            height: 50.0,
                            textStyle: FlutterFlowTheme.of(context).bodyMedium,
                            hintText: 'Выберите категорию',
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                            fillColor: FlutterFlowTheme.of(context).lineColor,
                            elevation: 2.0,
                            borderColor: Color(0xEBD0D1D1),
                            borderWidth: 2.0,
                            borderRadius: 8.0,
                            margin: EdgeInsetsDirectional.fromSTEB(
                                16.0, 4.0, 16.0, 4.0),
                            hidesUnderline: true,
                            isSearchable: false,
                            isMultiSelect: false,
                          );
                        },
                      ),
                    ),

                    Align(
                      alignment: AlignmentDirectional(-1.0, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 10.0, 0.0, 0.0),
                        child: Text(
                          'Торговая марка',
                          textAlign: TextAlign.start,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF787878),
                                  ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 0.0),
                      child: FutureBuilder<ApiCallResponse>(
                        future: CatalogGroup.getAllBrandsNamesCall.call(),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    FlutterFlowTheme.of(context).primary,
                                  ),
                                ),
                              ),
                            );
                          }
                          final brandGetAllBrandsNamesResponse = snapshot.data!;
                          return FlutterFlowDropDown<String>(
                            controller: _model.brandValueController ??=
                                FormFieldController<String>(
                              _model.brandValue ??= getJsonField(
                                productEditPageGetProductByIdResponse.jsonBody,
                                r'''$.brand.name''',
                              ).toString(),
                            ),
                            options: List<String>.from(
                                CatalogGroup.getAllBrandsNamesCall.brandsList(
                              brandGetAllBrandsNamesResponse.jsonBody,
                            )!),
                            optionLabels:
                                CatalogGroup.getAllBrandsNamesCall.brandsList(
                              brandGetAllBrandsNamesResponse.jsonBody,
                            )!,
                            onChanged: (val) =>
                                setState(() => _model.brandValue = val),
                            width: double.infinity,
                            height: 50.0,
                            textStyle: FlutterFlowTheme.of(context).bodyMedium,
                            hintText: 'Выберите бренд',
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                            fillColor: FlutterFlowTheme.of(context).lineColor,
                            elevation: 2.0,
                            borderColor: Color(0xEBD0D1D1),
                            borderWidth: 2.0,
                            borderRadius: 8.0,
                            margin: EdgeInsetsDirectional.fromSTEB(
                                16.0, 4.0, 16.0, 4.0),
                            hidesUnderline: true,
                            isSearchable: false,
                            isMultiSelect: false,
                          );
                        },
                      ),
                    ),

                    Align(
                      alignment: AlignmentDirectional(-1.0, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 10.0, 0.0, 0.0),
                        child: Text(
                          'Цена',
                          textAlign: TextAlign.start,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF787878),
                                  ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(8.0, 10.0, 8.0, 0.0),
                      child: TextFormField(
                        controller: _model.priceController ??=
                            TextEditingController(
                          text: GetProductByIdCall.price(
                            productEditPageGetProductByIdResponse.jsonBody,
                          )?.toString(),
                        ),
                        focusNode: _model.priceFocusNode,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFCFCFCF),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium,
                        keyboardType: TextInputType.number,
                        validator: _model.priceControllerValidator
                            .asValidator(context),
                      ),
                    ),

                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 15.0, 10.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          print("toke ${FFAppState().jwttoken}");
                          if (_model.uploadedLocalFile != null && (_model.uploadedLocalFile.bytes?.isNotEmpty ?? false)) {
                            _model.mainPhoto = await FileGroup.uploadMainPhotoCall.call(
                              file: _model.uploadedLocalFile,
                              jwtToken: FFAppState().jwttoken,
                            );
                            if ((_model.mainPhoto?.succeeded ?? true)) {
                              _model.apiResultoUpdateProduct = await ProductGroup.updateProductCall.call(
                                productId: widget.productId,
                                jwtToken: FFAppState().jwttoken,
                                title: _model.productNameController.text,
                                article: _model.productArticleController.text,
                                description: _model.descriptionController.text,
                                brand: _model.brandValue,
                                mainPhotoExist: _model.uploadedLocalFile != null && (_model.uploadedLocalFile.bytes?.isNotEmpty ?? false),
                                mainPhotoUid: getJsonField((_model.mainPhoto?.jsonBody ?? ''), r'''$.uid''',).toString(),
                                mainPhotoJson: (_model.mainPhoto?.jsonBody ?? ''),
                                category: _model.categoryValue,
                                price: int.tryParse(_model.priceController.text),
                                provider: getJsonField(FFAppState().accountInfo, r'''$.id''',),
                              );
                              if ((_model.apiResultoUpdateProduct?.succeeded ?? true)) {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return WebViewAware(
                                      child: AlertDialog(
                                        title: Text('Данные успешно обновлены!'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(alertDialogContext),
                                            child: Text('Ok'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );

                                // context.pushNamed('ProvidersProducts');
                                Navigator.of(context).pop();
                              } else {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return WebViewAware(
                                      child: AlertDialog(
                                        title: Text('Ошибка при обновление'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: Text('Ok'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            }
                          } else {
                            _model.apiResultoUpdateProductWithoutPhoto = await ProductGroup.updateProductCall.call(
                              productId: widget.productId,
                              jwtToken: FFAppState().jwttoken,
                              title: _model.productNameController.text,
                              description: _model.descriptionController.text,
                              article: _model.productArticleController.text,
                              brand: _model.brandValue,
                              mainPhotoExist: _model.isDataUploading,
                              mainPhotoUid: getJsonField(
                                productEditPageGetProductByIdResponse.jsonBody,
                                r'''$.mainPhoto.uid''',
                              ).toString(),
                              mainPhotoJson: null,
                              category: _model.categoryValue,
                              price: int.tryParse(_model.priceController.text),
                              provider: getJsonField(
                                FFAppState().accountInfo,
                                r'''$.id''',
                              ),
                            );
                            if ((_model.apiResultoUpdateProductWithoutPhoto?.succeeded ?? true)) {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return WebViewAware(
                                    child: AlertDialog(
                                      title: Text('Данные успешно обновлены!'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
                                          child: Text('Ok'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );

                              // context.pushNamed('ProvidersProducts');
                              Navigator.of(context).pop();
                              // pushNewScreen(context, screen: ProvidersProductsWidget());

                              // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              //   return ProvidersProductsWidget();
                              // }));

                            } else {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return WebViewAware(
                                    child: AlertDialog(
                                      title: Text('Ошибка во время обновления!'),
                                      actions: [
                                        TextButton(onPressed: () => Navigator.pop(alertDialogContext), child: Text('Ok'),),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          }

                          setState(() {});
                        },
                        text: 'Сохранить',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                  ),
                          elevation: 3.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
