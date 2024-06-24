import 'dart:convert';

import 'package:sauda_line/index.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'promotion_add_page_model.dart';
export 'promotion_add_page_model.dart';
import 'package:http/http.dart' as http;

class PromotionAddPageWidget extends StatefulWidget {
  const PromotionAddPageWidget({super.key});

  @override
  State<PromotionAddPageWidget> createState() => _PromotionAddPageWidgetState();
}

class _PromotionAddPageWidgetState extends State<PromotionAddPageWidget> {
  late PromotionAddPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  int? selectedCityId;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PromotionAddPageModel());

    _model.promotionNameController ??= TextEditingController();
    _model.promotionNameFocusNode ??= FocusNode();

    _model.promotionShortTitleController ??= TextEditingController();
    _model.promotionShortTitleFocusNode ??= FocusNode();

    _model.promotionDescriptionController ??= TextEditingController();
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
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'Добавить акцию',
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
                        'Картинка акции',
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
                                    child: Image.memory(
                                      _model.uploadedLocalFile.bytes ??
                                          Uint8List.fromList([]),
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
                              selectedMedia.every((m) =>
                                  validateFileFormat(m.storagePath, context))) {
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
                        'Название рекламной акции',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                      controller: _model.promotionNameController,
                      focusNode: _model.promotionNameFocusNode,
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
                      validator: _model.promotionNameControllerValidator
                          .asValidator(context),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                      child: Text(
                        'Подзаголовок акции',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                      controller: _model.promotionShortTitleController,
                      focusNode: _model.promotionShortTitleFocusNode,
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
                      validator: _model.promotionShortTitleControllerValidator
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
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _model.promotionDescriptionController,
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
                      validator: _model.promotionDescriptionControllerValidator
                          .asValidator(context),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      height: 25.0,
                      decoration: BoxDecoration(),
                      alignment: AlignmentDirectional(-1.0, -1.0),
                      child: Text(
                        'Дата начала',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                            locale: Locale("ru")
                        ).then((selectedDate) {
                          // After selecting the date, display the time picker.
                          if (selectedDate != null) {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((selectedTime) {
                              // Handle the selected date and time here.
                              if (selectedTime != null) {
                                DateTime selectedDateTime = DateTime(
                                  selectedDate.year,
                                  selectedDate.month,
                                  selectedDate.day,
                                  selectedTime.hour,
                                  selectedTime.minute,
                                );

                                setState(() {
                                  _model.startDatePicker = selectedDateTime;
                                });
                              }
                            });
                          }
                        });

                        setState(() {});
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 320.0,
                                      height: 30.0,
                                      decoration: BoxDecoration(),
                                      alignment:
                                          AlignmentDirectional(-1.0, 0.0),
                                      child: AutoSizeText(
                                        valueOrDefault<String>(
                                          dateTimeFormat('dd-MM-y, HH:mm',
                                              _model.startDatePicker),
                                          '01-01-2023, 00:00',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 16.0,
                                            ),
                                        minFontSize: 14.0,
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
                            Divider(
                              thickness: 1.0,
                              color: Color(0xCC9E9E9E),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      height: 25.0,
                      decoration: BoxDecoration(),
                      alignment: AlignmentDirectional(-1.0, -1.0),
                      child: Text(
                        'Дата окончания',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 10.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        /*_model.endDatePicker = await showDatePicker(
                          context: context,
                          locale: const Locale("ru"),
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2050),
                        );*/

                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                          locale: Locale("ru")
                        ).then((selectedDate) {
                          // After selecting the date, display the time picker.
                          if (selectedDate != null) {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((selectedTime) {
                              // Handle the selected date and time here.
                              if (selectedTime != null) {
                                DateTime selectedDateTime = DateTime(
                                  selectedDate.year,
                                  selectedDate.month,
                                  selectedDate.day,
                                  selectedTime.hour,
                                  selectedTime.minute,
                                );
                                

                                setState(() {

                                  _model.endDatePicker = selectedDateTime;
                                });
                              }
                            });
                          }
                        });

                        setState(() {});
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 320.0,
                                      height: 30.0,
                                      decoration: BoxDecoration(),
                                      alignment: AlignmentDirectional(-1.0, 0.0),
                                      child: AutoSizeText(
                                        valueOrDefault<String>(
                                          dateTimeFormat('dd-MM-y, HH:mm', _model.endDatePicker), '01-01-2023, 00:00',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 16.0,
                                            ),
                                        minFontSize: 14.0,
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
                            Divider(
                              thickness: 1.0,
                              color: Color(0xCC9E9E9E),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 15.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        print(dateTimeFormat('y-MM-ddT00:00:00Z', _model.startDatePicker));
                        if (_model.uploadedLocalFile != null && (_model.uploadedLocalFile.bytes?.isNotEmpty ?? false)) {_model.promotionPhoto = await FileGroup.uploadMainPhotoCall.call(
                            file: _model.uploadedLocalFile,
                            jwtToken: FFAppState().jwttoken,
                          );
                          _model.apiResultoCreatePromotion =
                              await PromotionGroup.createPromotionCall.call(
                                  title: _model.promotionNameController.text,
                                  subTitle: _model.promotionShortTitleController.text,
                                  description: _model.promotionDescriptionController.text,
                                  photoJson: (_model.promotionPhoto?.jsonBody ?? ''),
                                  startDate: dateTimeFormat('y-MM-ddThh:mm:00', _model.startDatePicker),
                                  provider: getJsonField(FFAppState().accountInfo, r'''$.id''',),
                                  jwtToken: FFAppState().jwttoken,
                                  finishDate: dateTimeFormat('y-MM-ddThh:mm:00', _model.endDatePicker),
                                  city: selectedCityId
                          );
                          if ((_model.apiResultoCreatePromotion?.succeeded ?? true)) {

                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return WebViewAware(
                                  child: AlertDialog(
                                    title: Text('Успешно'),
                                    content:
                                    Text('Акция успешно создано'),
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

                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return ProvidersPromotionsWidget();
                            }));
                          } else {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return WebViewAware(
                                  child: AlertDialog(
                                    title: Text('Ошибка'),
                                    content:
                                        Text('Ошибка при добавлении акций'),
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
                          await showDialog(
                            context: context,
                            builder: (alertDialogContext) {
                              return WebViewAware(
                                child: AlertDialog(
                                  title: Text('Обязательные поля не заполнены!'),
                                  content: Text('Сначала загрузите  изображение'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(alertDialogContext),
                                      child: Text('Oк'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }

                        setState(() {});
                      },
                      text: 'Сохранить',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 40.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
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
