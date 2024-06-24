import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sauda_line/index.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'select_address_model.dart';
export 'select_address_model.dart';

class SelectAddressWidget extends StatefulWidget {
  const SelectAddressWidget({super.key});

  @override
  State<SelectAddressWidget> createState() => _SelectAddressWidgetState();
}

class _SelectAddressWidgetState extends State<SelectAddressWidget> {
  late SelectAddressModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectAddressModel());
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
          title: Text(
            'Выбрать адрес доставки',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  color: Colors.white,
                  fontSize: 16.0,
                ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  // context.pushNamed('AddAddress');

                  pushNewScreen(context, screen: const AddAddressWidget());
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 24.0,
                ),
              ),
            ),
          ],
          centerTitle: true,
          elevation: 4.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 55.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                  child: RichText(
                    textScaleFactor: MediaQuery.of(context).textScaleFactor,
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Выбран адрес: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: FFAppState().customerAddress,
                          style: const TextStyle(),
                        )
                      ],
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                    maxLines: 2,
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                      child: FutureBuilder<ApiCallResponse>(
                        future: DeliveryDetailsGroup.customersAddressesCall.call(jwtToken: FFAppState().jwttoken,
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
                          final listViewCustomersAddressesResponse = snapshot.data!;
                          return Builder(
                            builder: (context) {
                              final address = getJsonField(listViewCustomersAddressesResponse.jsonBody, r'''$''',).toList();
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                primary: false,
                                scrollDirection: Axis.vertical,
                                itemCount: address.length,
                                itemBuilder: (context, addressIndex) {
                                  final addressItem = address[addressIndex];
                                  return Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 2.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        setState(() {
                                          FFAppState().addressid = getJsonField(addressItem, r'''$.id''',);
                                          FFAppState().customerAddress = getJsonField(addressItem, r'''$.address''',).toString();
                                        });
                                        // context.safePop();
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                          return const ConfirmationOrderWidget();
                                        }));
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 50.0,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 5.0, 5.0, 5.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 240.0,
                                                height: 50.0,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                child: AutoSizeText(getJsonField(addressItem, r'''$.address''',).toString(),
                                                  maxLines: 2,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            const Color(0xFF14181B),
                                                        fontSize: 15.0,
                                                      ),
                                                ),
                                              ),
                                              if ((FFAppState().addressid != null) && (FFAppState().addressid == getJsonField(addressItem, r'''$.id''',)))
                                                const Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                                                  child: Icon(
                                                    Icons.check,
                                                    color: Color(0xFF1A73B3),
                                                    size: 24.0,
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
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
