import '/backend/api_requests/api_calls.dart';
import '/customer/address/address_list/address_list_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'update_address_page_model.dart';
export 'update_address_page_model.dart';

class UpdateAddressPageWidget extends StatefulWidget {
  const UpdateAddressPageWidget({
    super.key,
    this.addressId,
  });

  final int? addressId;

  @override
  State<UpdateAddressPageWidget> createState() =>
      _UpdateAddressPageWidgetState();
}

class _UpdateAddressPageWidgetState extends State<UpdateAddressPageWidget> {
  late UpdateAddressPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UpdateAddressPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.apiResultm96 = await DeliveryDetailsGroup.getAddressByIdCall.call(
        addressId: widget.addressId,
        jwtToken: FFAppState().jwttoken,
      );
      if ((_model.apiResultm96?.succeeded ?? true)) {
        setState(() {
          FFAppState().LonLng = functions.generateLatLng('${getJsonField(
            (_model.apiResultm96?.jsonBody ?? ''),
            r'''$.latitude''',
          ).toString().toString()} ${getJsonField(
            (_model.apiResultm96?.jsonBody ?? ''),
            r'''$.longitude''',
          ).toString().toString()}')!;
          FFAppState().customerAddress = getJsonField(
            (_model.apiResultm96?.jsonBody ?? ''),
            r'''$.address''',
          ).toString().toString();
        });
      }
    });

    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textFieldFocusNode3 ??= FocusNode();

    _model.textFieldFocusNode4 ??= FocusNode();
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
      future: DeliveryDetailsGroup.getAddressByIdCall.call(
        addressId: widget.addressId,
        jwtToken: FFAppState().jwttoken,
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
        final updateAddressPageGetAddressByIdResponse = snapshot.data!;

        print(updateAddressPageGetAddressByIdResponse.jsonBody);
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
              leading: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  context.safePop();
                },
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 24.0,
                ),
              ),
              title: Stack(
                alignment: AlignmentDirectional(0.0, 0.0),
                children: [
                  Text(
                    'Изменить адрес',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
              actions: [],
              centerTitle: true,
              elevation: 2.0,
            ),
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            children: [
                              FlutterFlowWebView(
                                content: functions.generateMapScript(FFAppState().LonLng)!,
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: 300.0,
                                verticalScroll: true,
                                horizontalScroll: true,
                                html: true,
                              ),
                              if (getJsonField(updateAddressPageGetAddressByIdResponse.jsonBody, r'''$.latitude''',) != null
                                  ? true
                                  : false)
                                Opacity(
                                  opacity: 0.7,
                                  child: FaIcon(
                                    FontAwesomeIcons.mapMarkerAlt,
                                    color: Color(0xFFFCA522),
                                    size: 26.0,
                                  ),
                                ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: _model.textController1 ??=
                                            TextEditingController(
                                          text: getJsonField(
                                                    updateAddressPageGetAddressByIdResponse
                                                        .jsonBody,
                                                    r'''$.address''',
                                                  ) !=
                                                  null
                                              ? getJsonField(
                                                  updateAddressPageGetAddressByIdResponse
                                                      .jsonBody,
                                                  r'''$.address''',
                                                ).toString()
                                              : '',
                                        ),
                                        focusNode: _model.textFieldFocusNode1,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Адрес',
                                          labelStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    fontSize: 16.0,
                                                  ),
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium,
                                        validator: _model
                                            .textController1Validator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 0.0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      _model.apiResultkf5 =
                                          await YandexMapGeocoderCall.call(
                                        address: _model.textController1.text,
                                      );
                                      if ((_model.apiResultkf5?.succeeded ??
                                          true)) {
                                        setState(() {
                                          FFAppState().findedMapAddress =
                                              getJsonField(
                                            (_model.apiResultkf5?.jsonBody ??
                                                ''),
                                            r'''$.response.GeoObjectCollection.featureMember''',
                                            true,
                                          )!
                                                  .toList()
                                                  .cast<dynamic>();
                                        });
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          enableDrag: false,
                                          useSafeArea: true,
                                          context: context,
                                          builder: (context) {
                                            return WebViewAware(
                                              child: GestureDetector(
                                                onTap: () => _model.unfocusNode
                                                        .canRequestFocus
                                                    ? FocusScope.of(context)
                                                        .requestFocus(
                                                            _model.unfocusNode)
                                                    : FocusScope.of(context)
                                                        .unfocus(),
                                                child: Padding(
                                                  padding:
                                                      MediaQuery.viewInsetsOf(
                                                          context),
                                                  child: Container(
                                                    height: 445.0,
                                                    child: AddressListWidget(),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ).then((value) => safeSetState(() {}));
                                      }

                                      setState(() {});
                                    },
                                    text: 'Найти адрес',
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 48.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Outfit',
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                      elevation: 3.0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 8.0, 0.0),
                                        child: Text(
                                          'Ваш адрес: ',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 5.0, 0.0, 0.0),
                                        child: Container(
                                          width: 230.0,
                                          height: 65.0,
                                          decoration: BoxDecoration(),
                                          child: Visibility(
                                            visible: getJsonField(
                                                  updateAddressPageGetAddressByIdResponse
                                                      .jsonBody,
                                                  r'''$.address''',
                                                ) !=
                                                null,
                                            child: AutoSizeText(
                                              FFAppState().customerAddress,
                                              maxLines: 3,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 0.0),
                                  child: TextFormField(
                                    controller: _model.textController2 ??=
                                        TextEditingController(
                                      text: getJsonField(
                                                updateAddressPageGetAddressByIdResponse
                                                    .jsonBody,
                                                r'''$.fio''',
                                              ) !=
                                              null
                                          ? getJsonField(
                                              updateAddressPageGetAddressByIdResponse
                                                  .jsonBody,
                                              r'''$.fio''',
                                            ).toString()
                                          : '',
                                    ),
                                    focusNode: _model.textFieldFocusNode2,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium,
                                      hintText: 'ФИО',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    style:
                                        FlutterFlowTheme.of(context).bodyMedium,
                                    validator: _model.textController2Validator
                                        .asValidator(context),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 0.0),
                                  child: TextFormField(
                                    controller: _model.textController3 ??=
                                        TextEditingController(
                                      text: getJsonField(
                                                updateAddressPageGetAddressByIdResponse
                                                    .jsonBody,
                                                r'''$.tel''',
                                              ) !=
                                              null
                                          ? getJsonField(
                                              updateAddressPageGetAddressByIdResponse
                                                  .jsonBody,
                                              r'''$.tel''',
                                            ).toString()
                                          : '',
                                    ),
                                    focusNode: _model.textFieldFocusNode3,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium,
                                      hintText: 'Телефон',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    style:
                                        FlutterFlowTheme.of(context).bodyMedium,
                                    keyboardType: TextInputType.phone,
                                    validator: _model.textController3Validator
                                        .asValidator(context),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 0.0),
                                  child: TextFormField(
                                    controller: _model.textController4 ??=
                                        TextEditingController(
                                      text: getJsonField(
                                                updateAddressPageGetAddressByIdResponse
                                                    .jsonBody,
                                                r'''$.comment''',
                                              ) !=
                                              null
                                          ? getJsonField(
                                              updateAddressPageGetAddressByIdResponse
                                                  .jsonBody,
                                              r'''$.comment''',
                                            ).toString()
                                          : '',
                                    ),
                                    focusNode: _model.textFieldFocusNode4,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium,
                                      hintText: 'Название магазина',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    style:
                                        FlutterFlowTheme.of(context).bodyMedium,
                                    validator: _model.textController4Validator
                                        .asValidator(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 15.0),
                    child: Container(
                      width: double.infinity,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 10.0, 10.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            _model.apiResultoupdate = await DeliveryDetailsGroup
                                .updateDeliveryAddressCall
                                .call(
                              address: _model.textController1.text,
                              latitude: functions
                                  .getlatitude(FFAppState().LonLng)
                                  .toString(),
                              longitude: FFAppState().LonLng != null &&
                                      FFAppState().LonLng != ''
                                  ? functions
                                      .getLongitude(FFAppState().LonLng)
                                      .toString()
                                  : functions
                                      .getLongitude('${getJsonField(
                                        updateAddressPageGetAddressByIdResponse
                                            .jsonBody,
                                        r'''$.longitude''',
                                      ).toString()} ${getJsonField(
                                        updateAddressPageGetAddressByIdResponse
                                            .jsonBody,
                                        r'''$.latitude''',
                                      ).toString()}')
                                      .toString(),
                              comment: _model.textController4.text,
                              fio: _model.textController2.text,
                              tel: _model.textController3.text,
                              addressId: widget.addressId,
                              jwtToken: FFAppState().jwttoken,
                            );
                            if ((_model.apiResultoupdate?.succeeded ?? true)) {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return WebViewAware(
                                    child: AlertDialog(
                                      title: Text('Успешно обновлено'),
                                      content: Text(
                                          'Адрес доставки успешно сохранен.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
                                          child: Text('Ок'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                              context.safePop();
                            } else {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return WebViewAware(
                                    child: AlertDialog(
                                      title: Text('Ошибка'),
                                      content:
                                          Text('Произошла ошибка при запросе'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
                                          child: Text('Ок'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                              context.safePop();
                            }

                            setState(() {});
                          },
                          text: 'Сохранить',
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
