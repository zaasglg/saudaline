import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sauda_line/customer/order/confirmation_order/confirmation_order_widget.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'selecting_delivery_address_model.dart';
export 'selecting_delivery_address_model.dart';

class SelectingDeliveryAddressWidget extends StatefulWidget {
  const SelectingDeliveryAddressWidget({
    super.key,
    required this.address,
  });

  final String? address;

  @override
  State<SelectingDeliveryAddressWidget> createState() =>
      _SelectingDeliveryAddressWidgetState();
}

class _SelectingDeliveryAddressWidgetState
    extends State<SelectingDeliveryAddressWidget> {
  late SelectingDeliveryAddressModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectingDeliveryAddressModel());

    _model.textController ??= TextEditingController(text: widget.address);
    _model.textFieldFocusNode ??= FocusNode();
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
          automaticallyImplyLeading: true,
          actions: [],
          centerTitle: true,
          elevation: 4.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10.0, 15.0, 10.0, 10.0),
                child: TextFormField(
                  controller: _model.textController,
                  focusNode: _model.textFieldFocusNode,
                  autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Адрес....',
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
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium,
                  validator:
                      _model.textControllerValidator.asValidator(context),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    _model.apiResultkf5 = await YandexMapGeocoderCall.call(
                      address: _model.textController.text,
                    );
                    if ((_model.apiResultkf5?.succeeded ?? true)) {
                      setState(() {
                        FFAppState().findedMapAddress = getJsonField(
                          (_model.apiResultkf5?.jsonBody ?? ''),
                          r'''$.response.GeoObjectCollection.featureMember''',
                          true,
                        )!
                            .toList()
                            .cast<dynamic>();
                      });
                    }

                    setState(() {});
                  },
                  text: 'Найти адрес',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 48.0,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Outfit',
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                    elevation: 3.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              if (FFAppState().findedMapAddress.length != 0 ? true : false)
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 0.0),
                    child: Builder(
                      builder: (context) {
                        final address = FFAppState()
                            .findedMapAddress
                            .toList()
                            .take(5)
                            .toList();
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: address.length,
                          itemBuilder: (context, addressIndex) {
                            final addressItem = address[addressIndex];
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 10.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    FFAppState().customerAddress =
                                        '${getJsonField(
                                      addressItem,
                                      r'''$.GeoObject.description''',
                                    ).toString()}${getJsonField(
                                      addressItem,
                                      r'''$.GeoObject.name''',
                                    ).toString()}';
                                    FFAppState().LonLng =
                                        functions.generateLatLng(getJsonField(
                                      addressItem,
                                      r'''$.GeoObject.Point.pos''',
                                    ).toString())!;
                                  });

                                  // context.pushNamed('ConfirmationOrder');

                                  pushNewScreen(context, screen: ConfirmationOrderWidget());
                                },
                                child: Container(
                                  width: 100.0,
                                  height: 65.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15.0, 10.0, 0.0, 10.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              getJsonField(
                                                addressItem,
                                                r'''$.GeoObject.description''',
                                              ).toString(),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: Color(0xFF14181B),
                                                    fontSize: 14.0,
                                                  ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 5.0, 0.0, 0.0),
                                              child: Text(
                                                getJsonField(
                                                  addressItem,
                                                  r'''$.GeoObject.name''',
                                                ).toString(),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: Color(0xFF14181B),
                                                      fontSize: 16.0,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        height: 1.0,
                                        color: Color(0xCC959595),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
