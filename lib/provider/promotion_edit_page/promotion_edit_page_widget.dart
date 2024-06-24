import 'dart:convert';

import 'package:sauda_line/flutter_flow/flutter_flow_drop_down.dart';
import 'package:sauda_line/flutter_flow/form_field_controller.dart';
import 'package:sauda_line/index.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'promotion_edit_page_model.dart';
export 'promotion_edit_page_model.dart';
import 'package:http/http.dart' as http;

class PromotionEditPageWidget extends StatefulWidget {
  const PromotionEditPageWidget({
    super.key,
    required this.promotionId,
  });

  final int? promotionId;

  @override
  State<PromotionEditPageWidget> createState() =>
      _PromotionEditPageWidgetState();
}

class _PromotionEditPageWidgetState extends State<PromotionEditPageWidget> {
  late PromotionEditPageModel _model;

  int? selectedCityId;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PromotionEditPageModel());

    _model.promotionNameFocusNode ??= FocusNode();

    _model.promotionShortTitleFocusNode ??= FocusNode();

    _model.promotionDescriptionFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<List<dynamic>> fetchCities() async {
    final response = await http.get(Uri.parse('https://server.saudaline.kz/api/v1/provider/get-by-userid?id=${FFAppState().accountInfo["id"]}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['city'];
    } else {
      throw Exception('Failed to load cities');
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<ApiCallResponse>(
      future: PromotionGroup.promotionByIdCall.call(
        promotionId: widget.promotionId,
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
        final promotionEditPagePromotionByIdResponse = snapshot.data!;

        selectedCityId = promotionEditPagePromotionByIdResponse.jsonBody["city"]["id"];
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
                  Navigator.of(context).pop();
                },
              ),
              title: Text(
                'Изменить акцию',
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
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(-1.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 20.0, 0.0, 0.0),
                          child: Text(
                            'Картинка акции',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: const Color(0xFF787878),
                                ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Stack(
                            children: [
                              if (_model.uploadedLocalFile == null || (_model.uploadedLocalFile.bytes?.isEmpty ?? true))
                                Align(
                                  alignment: const AlignmentDirectional(-1.0, 0.0),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(10.0, 8.0, 10.0, 0.0),
                                    child: Container(
                                      width: 200.0,
                                      height: 120.0,
                                      decoration: const BoxDecoration(),
                                      child: Visibility(
                                        visible: _model.uploadedLocalFile == null || (_model.uploadedLocalFile.bytes?.isEmpty ?? true),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: Image.network(promotionEditPagePromotionByIdResponse.jsonBody["photo"][0]["url"].toString(),
                                            width: 300.0,
                                            height: 200.0,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if (_model.uploadedLocalFile != null && (_model.uploadedLocalFile.bytes?.isNotEmpty ?? false))
                                Align(
                                  alignment: const AlignmentDirectional(-1.0, 0.0),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(10.0, 8.0, 10.0, 0.0),
                                    child: Container(
                                      width: 200.0,
                                      height: 120.0,
                                      decoration: const BoxDecoration(),
                                      child: Visibility(
                                        visible: _model.uploadedLocalFile != null && (_model.uploadedLocalFile.bytes?.isNotEmpty ?? false),
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
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: const Color(0xFF939B9E),
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    fontSize: 14.0,
                                  ),
                              elevation: 3.0,
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: const AlignmentDirectional(-1.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 10.0, 0.0, 0.0),
                          child: Text(
                            'Название рекламной акции',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: const Color(0xFF787878),
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(8.0, 10.0, 8.0, 0.0),
                        child: TextFormField(
                          controller: _model.promotionNameController ??=
                              TextEditingController(text: getJsonField(promotionEditPagePromotionByIdResponse.jsonBody, r'''$.title''',).toString(),
                          ),
                          focusNode: _model.promotionNameFocusNode,
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
                          validator: _model.promotionNameControllerValidator
                              .asValidator(context),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(-1.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 10.0, 0.0, 0.0),
                          child: Text(
                            'Подзаголовок акции',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: const Color(0xFF787878),
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8.0, 10.0, 8.0, 0.0),
                        child: TextFormField(
                          controller: _model.promotionShortTitleController ??=
                              TextEditingController(
                            text: getJsonField(
                              promotionEditPagePromotionByIdResponse.jsonBody,
                              r'''$.subtitle''',
                            ).toString(),
                          ),
                          focusNode: _model.promotionShortTitleFocusNode,
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
                          validator: _model
                              .promotionShortTitleControllerValidator
                              .asValidator(context),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(-1.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 10.0, 0.0, 0.0),
                          child: Text(
                            'Краткое описание акции',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: const Color(0xFF787878),
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _model.promotionDescriptionController ??=
                              TextEditingController(text: getJsonField(
                              promotionEditPagePromotionByIdResponse.jsonBody,
                              r'''$.description''',
                            ).toString(),
                          ),
                          focusNode: _model.promotionDescriptionFocusNode,
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
                          validator: _model
                              .promotionDescriptionControllerValidator
                              .asValidator(context),
                        ),
                      ),

                      Align(
                        alignment: const AlignmentDirectional(-1.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 10.0, 0.0, 0.0),
                          child: Text(
                            'Выберите город',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Readex Pro',
                              color: const Color(0xFF787878),
                            ),
                          ),
                        ),
                      ),
                      FutureBuilder<List<dynamic>>(
                        future: fetchCities(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(child: Text('No cities found'));
                          } else {

                            List<dynamic> cities = snapshot.data!;
                            
                            return Container(
                              width: double.infinity,
                              margin: const EdgeInsets.all(8.0),
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.grey.withOpacity(0.1)
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<int>(
                                  hint: Text('Город'),
                                  value: selectedCityId,
                                  onChanged: (int? newValue) {
                                    setState(() {
                                      selectedCityId = newValue;
                                    });
                                  },
                                  items: cities.map((city) {
                                    return DropdownMenuItem<int>(
                                      value: city['id'],
                                      child: Text(city['name']),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );

                          }
                        },
                      ),

                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0, 0.0, 10.0, 0.0),
                        child: Container(
                          width: double.infinity,
                          height: 25.0,
                          decoration: const BoxDecoration(),
                          alignment: const AlignmentDirectional(-1.0, -1.0),
                          child: Text(
                            'Дата начала',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.startDatePicker = await actions.customDatePicker(
                              context,
                            );

                            setState(() {});
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 320.0,
                                          height: 30.0,
                                          decoration: const BoxDecoration(),
                                          alignment:
                                              const AlignmentDirectional(-1.0, 0.0),
                                          child: Stack(
                                            children: [
                                              if (_model.startDatePicker ==
                                                  null)
                                                AutoSizeText(
                                                  valueOrDefault<String>(
                                                    functions.formatDate(
                                                        getJsonField(
                                                          promotionEditPagePromotionByIdResponse
                                                              .jsonBody, r'''$.startDate''',
                                                        ).toString()), '0',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 16.0,
                                                      ),
                                                  minFontSize: 14.0,
                                                ),
                                              if (_model.startDatePicker !=
                                                  null)
                                                AutoSizeText(
                                                  valueOrDefault<String>(
                                                    dateTimeFormat('dd-MM-y', _model.startDatePicker), '01-01-2023',
                                                  ),
                                                  style: FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 16.0,
                                                      ),
                                                  minFontSize: 14.0,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_right,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 24.0,
                                    ),
                                  ],
                                ),
                                const Divider(
                                  thickness: 1.0,
                                  color: Color(0xCC9E9E9E),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                        child: Container(
                          width: double.infinity,
                          height: 25.0,
                          decoration: const BoxDecoration(),
                          alignment: const AlignmentDirectional(-1.0, -1.0),
                          child: Text(
                            'Дата окончания',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 10.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.endDatePicker =
                                await actions.customDatePicker(
                              context,
                            );

                            setState(() {});
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 320.0,
                                          height: 30.0,
                                          decoration: const BoxDecoration(),
                                          alignment:
                                              const AlignmentDirectional(-1.0, 0.0),
                                          child: Stack(
                                            children: [
                                              if (_model.endDatePicker == null)
                                                AutoSizeText(
                                                  valueOrDefault<String>(
                                                    functions.formatDate(
                                                        getJsonField(
                                                      promotionEditPagePromotionByIdResponse
                                                          .jsonBody,
                                                      r'''$.finishDate''',
                                                    ).toString()),
                                                    '0',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 16.0,
                                                      ),
                                                  minFontSize: 14.0,
                                                ),
                                              if (_model.endDatePicker != null)
                                                AutoSizeText(
                                                  valueOrDefault<String>(
                                                    dateTimeFormat(
                                                        'dd-MM-y, HH:mm',
                                                        _model.endDatePicker),
                                                    '01-01-2023, 00:00',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 16.0,
                                                      ),
                                                  minFontSize: 14.0,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_right,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 24.0,
                                    ),
                                  ],
                                ),
                                const Divider(
                                  thickness: 1.0,
                                  color: Color(0xCC9E9E9E),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(10.0, 15.0, 10.0, 15.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            if (_model.uploadedLocalFile != null &&
                                (_model.uploadedLocalFile.bytes?.isNotEmpty ?? false)) {
                              _model.promotionPhoto = await FileGroup.uploadMainPhotoCall.call(
                                file: _model.uploadedLocalFile,
                                jwtToken: FFAppState().jwttoken,
                              );

                              _model.apiResultoUpdatePromotion =
                              await PromotionGroup.updatePromotionByIdCall.call(
                                  title: _model.promotionNameController.text,
                                  subTitle: _model.promotionShortTitleController.text,
                                  description: _model.promotionDescriptionController.text,
                                  photoJson: (_model.promotionPhoto?.jsonBody ?? ''),
                                  provider: getJsonField(FFAppState().accountInfo, r'''$.id''',),
                                  promotionId: widget.promotionId,
                                  jwtToken: FFAppState().jwttoken,
                                  startDate: dateTimeFormat('y-MM-ddTH:mm:00.000Z', _model.startDatePicker),
                                  finishDate: dateTimeFormat('y-MM-ddTH:mm:00.000Z', _model.endDatePicker),
                                  city: selectedCityId
                              );

                              if ((_model.apiResultoUpdatePromotion?.succeeded ?? true)) {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                  return ProvidersPromotionsWidget();
                                }));
                              } else {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return WebViewAware(
                                      child: AlertDialog(
                                        title: const Text('Ошибка'),
                                        content: const Text('Ошибка при изменении'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: const Text('Ok'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            } else {
                              _model.apiResultoUpdatePromotion2 =
                              await PromotionGroup.updatePromotionByIdCall.call(
                                title: _model.promotionNameController.text,
                                subTitle: _model.promotionShortTitleController.text,
                                description: _model.promotionDescriptionController.text,
                                photoJson: getJsonField(promotionEditPagePromotionByIdResponse.jsonBody, r'''$.photo[:1]''',),
                                provider: getJsonField(FFAppState().accountInfo, r'''$.id''',),
                                promotionId: widget.promotionId,
                                jwtToken: FFAppState().jwttoken,
                                city: selectedCityId,
                                startDate: _model.startDatePicker != null
                                    ? dateTimeFormat('y-MM-ddT', _model.startDatePicker)
                                    : getJsonField(promotionEditPagePromotionByIdResponse.jsonBody, r'''$.startDate''',).toString(),
                                finishDate: _model.endDatePicker != null
                                    ? dateTimeFormat('y-MM-ddT', _model.endDatePicker)
                                    : getJsonField(promotionEditPagePromotionByIdResponse.jsonBody, r'''$.finishDate''',).toString(),
                              );

                              if ((_model.apiResultoUpdatePromotion2?.succeeded ?? true)) {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                  return ProvidersPromotionsWidget();
                                }));
                              } else {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return WebViewAware(
                                      child: AlertDialog(
                                        title: const Text('Ошибка'),
                                        content: const Text('Ошибка при изменении'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: const Text('Ok'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }

                              print(_model.endDatePicker);
                            }

                            setState(() {});
                          },
                          text: 'Сохранить',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 40.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                ),
                            elevation: 3.0,
                            borderSide: const BorderSide(
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
      },
    );
  }
}
