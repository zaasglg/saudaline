import 'package:flutter/cupertino.dart';
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
import 'product_add_page_model.dart';
export 'product_add_page_model.dart';

class ProductAddPageWidget extends StatefulWidget {
  const ProductAddPageWidget({super.key});

  @override
  State<ProductAddPageWidget> createState() => _ProductAddPageWidgetState();
}

class _ProductAddPageWidgetState extends State<ProductAddPageWidget> {
  late ProductAddPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProductAddPageModel());

    _model.productNameController ??= TextEditingController();
    _model.productNameFocusNode ??= FocusNode();

    _model.productArticleController ??= TextEditingController();
    _model.productArticleFocusNode ??= FocusNode();

    _model.descriptionController ??= TextEditingController();
    _model.descriptionFocusNode ??= FocusNode();

    _model.priceController ??= TextEditingController();
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
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 24.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Добавить',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 18.0,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 0.0, 0.0),
                      child: Text(
                        'Изображение товара',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF787878),
                            ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Stack(
                        children: [
                          if (_model.uploadedLocalFile != null &&
                              (_model.uploadedLocalFile.bytes?.isNotEmpty ??
                                  false))
                            Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 8.0, 10.0, 0.0),
                                child: Container(
                                  width: 200.0,
                                  height: 120.0,
                                  decoration: BoxDecoration(),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.memory(_model.uploadedLocalFile.bytes ?? Uint8List.fromList([]),
                                      width: 300.0,
                                      height: 200.0,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          final selectedMedia = await selectMedia(
                            mediaSource: MediaSource.photoGallery,
                            multiImage: false,
                          );
                          if (selectedMedia != null &&
                              selectedMedia.every((m) => validateFileFormat(m.storagePath, context))) {
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
                        text: 'Выбрать',
                        options: FFButtonOptions(
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Color(0xFF939B9E),
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    fontSize: 14.0,
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
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                      child: Text(
                        'Наименование товара',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF787878),
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 10.0, 8.0, 0.0),
                    child: TextFormField(
                      controller: _model.productNameController,
                      focusNode: _model.productNameFocusNode,
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
                      maxLines: 2,
                      validator: _model.productNameControllerValidator
                          .asValidator(context),
                    ),
                  ),


                  // article
                  Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                      child: Text('Артикуль товара',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                      controller: _model.productArticleController,
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
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                      child: Text(
                        'Краткое описание продукта',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF787878),
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _model.descriptionController,
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
                      padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                      child: Text(
                        'Категория',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF787878),
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 0.0),
                    child: FutureBuilder<ApiCallResponse>(
                      future:
                          CategoryGroup.getCategoryTitlesByProviderCall.call(userId: getJsonField(FFAppState().accountInfo, r'''$.id''',),
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
                        final categoryGetCategoryTitlesByProviderResponse = snapshot.data!;
                        return FlutterFlowDropDown<String>(
                          controller: _model.categoryValueController ??= FormFieldController<String>(null),
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
                      padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                      child: Text(
                        'Торговая марка',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF787878),
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 0.0),
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
                        print(brandGetAllBrandsNamesResponse.jsonBody);
                        return FlutterFlowDropDown<String>(
                          controller: _model.brandValueController ??= FormFieldController<String>(null),
                          options: List.from(CatalogGroup.getAllBrandsNamesCall.brandsList(brandGetAllBrandsNamesResponse.jsonBody,)!),
                          optionLabels: CatalogGroup.getAllBrandsNamesCall.brandsList(brandGetAllBrandsNamesResponse.jsonBody,)!,
                          onChanged: (val) => setState(() => _model.brandValue = val),
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
                          margin: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
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
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                      child: Text(
                        'Цена',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF787878),
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 10.0, 8.0, 0.0),
                    child: TextFormField(
                      controller: _model.priceController,
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
                      validator: _model.priceControllerValidator.asValidator(context),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10.0, 15.0, 10.0, 15.0),
                    child: FFButtonWidget(
                      onPressed: () async {


                        if (_model.uploadedLocalFile != null && (_model.uploadedLocalFile.bytes?.isNotEmpty ?? false)) {
                          _model.mainPhoto = await FileGroup.uploadMainPhotoCall.call(
                            file: _model.uploadedLocalFile,
                            jwtToken: FFAppState().jwttoken,
                          );
                          _model.apiResultoCreateProduct = await ProductGroup.createProductCall.call(
                            jwtToken: FFAppState().jwttoken,
                            title: _model.productNameController.text,
                            article: _model.productArticleController.text,
                            description: _model.descriptionController.text,
                            brand: _model.brandValue,
                            mainPhotoExist: _model.uploadedLocalFile != null && (_model.uploadedLocalFile.bytes?.isNotEmpty ?? false),
                            mainPhotoUid: (_model.mainPhoto?.succeeded ?? true) ? getJsonField((_model.mainPhoto?.jsonBody ?? ''), r'''$.uid''',).toString() : null,
                            mainPhotoJson: getJsonField((_model.mainPhoto?.succeeded ?? true) ? (_model.mainPhoto?.jsonBody ?? '') : null, r'''$''',),
                            category: _model.categoryValue,
                            price: int.tryParse(_model.priceController.text),
                            provider: getJsonField(FFAppState().accountInfo, r'''$.id''',),
                          );
                          if ((_model.apiResultoCreateProduct?.succeeded ??
                              true)) {
                            // context.pushNamed('ProvidersProducts');
                            Navigator.of(context).pop();
                          } else {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return WebViewAware(
                                  child: AlertDialog(
                                    title: Text('Ошибка'),
                                    content:
                                        Text('Ошибка при добавлении продукта'),
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
                          }
                        } else {
                          _model.apiResultoCreateProductWithoutImage = await ProductGroup.createProductCall.call(
                            jwtToken: FFAppState().jwttoken,
                            title: _model.productNameController.text,
                            article: _model.productArticleController.text,
                            description: _model.descriptionController.text,
                            brand: _model.brandValue,
                            mainPhotoExist: _model.uploadedLocalFile != null && (_model.uploadedLocalFile.bytes?.isNotEmpty ?? false),
                            mainPhotoUid: null,
                            mainPhotoJson: null,
                            category: _model.categoryValue,
                            price: int.tryParse(_model.priceController.text),
                            provider: getJsonField(
                              FFAppState().accountInfo,
                              r'''$.id''',
                            ),
                          );
                          if ((_model.apiResultoCreateProductWithoutImage
                                  ?.succeeded ??
                              true)) {
                            // context.pushNamed('ProvidersProducts');
                            Navigator.of(context).pop();
                          } else {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return WebViewAware(
                                  child: AlertDialog(
                                    title: Text('Ошибка'),
                                    content:
                                        Text('Ошибка при добавлении продукта'),
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
                          }
                        }

                        setState(() {});
                      },
                      text: 'Сохранить',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 40.0,
                        padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
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
      ),
    );
  }
}
