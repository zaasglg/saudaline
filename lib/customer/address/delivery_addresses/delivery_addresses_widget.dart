import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sauda_line/customer/address/add_address/add_address_widget.dart';
import 'package:sauda_line/customer/address/update_address_page/update_address_page_widget.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'delivery_addresses_model.dart';
export 'delivery_addresses_model.dart';

class DeliveryAddressesWidget extends StatefulWidget {
  const DeliveryAddressesWidget({super.key});

  @override
  State<DeliveryAddressesWidget> createState() =>
      _DeliveryAddressesWidgetState();
}

class _DeliveryAddressesWidgetState extends State<DeliveryAddressesWidget> {
  late DeliveryAddressesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DeliveryAddressesModel());
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
            'Адрес доставки',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  // context.pushNamed('AddAddress');
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return AddAddressWidget();
                  }));
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 26.0,
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
              Expanded(
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                      child: FutureBuilder<ApiCallResponse>(
                        future: DeliveryDetailsGroup.customersAddressesCall.call(
                          jwtToken: FFAppState().jwttoken,
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
                              final address = getJsonField(listViewCustomersAddressesResponse.jsonBody, r'''$''',).reversed.toList();
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                primary: false,
                                scrollDirection: Axis.vertical,
                                itemCount: address.length,
                                itemBuilder: (context, addressIndex) {
                                  final addressItem = address[addressIndex];
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 2.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        setState(() {
                                          FFAppState().addressid = getJsonField(
                                            addressItem,
                                            r'''$.id''',
                                          );
                                          FFAppState().customerAddress =
                                              getJsonField(
                                            addressItem,
                                            r'''$.address''',
                                          ).toString();
                                        });
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 5.0, 5.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 240.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                child: AutoSizeText(
                                                  getJsonField(
                                                    addressItem,
                                                    r'''$.address''',
                                                  ).toString(),
                                                  maxLines: 2,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            Color(0xFF14181B),
                                                        fontSize: 15.0,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0.0, 0.0, 5.0, 0.0),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {


                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                                      return UpdateAddressPageWidget(
                                                        addressId: int.tryParse(serializeParam(getJsonField(addressItem, r'''$.id''',), ParamType.int,) ?? '0'),
                                                      );
                                                    }));

                                                    // context.pushNamed(
                                                    //   'UpdateAddressPage',
                                                    //   queryParameters: {
                                                    //     'addressId': ,
                                                    //   }.withoutNulls,
                                                    // );
                                                  },
                                                  child: Icon(
                                                    Icons.edit_outlined,
                                                    color: Color(0xFF6F9D0E),
                                                    size: 20.0,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 10.0, 0.0),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    var confirmDialogResponse =
                                                        await showDialog<bool>(
                                                              context: context,
                                                              builder:
                                                                  (alertDialogContext) {
                                                                return WebViewAware(
                                                                  child:
                                                                      AlertDialog(
                                                                    title: Text('Предупреждение'),
                                                                    content: Text('Вы собираетесь удалить?'),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed: () => Navigator.pop(
                                                                            alertDialogContext,
                                                                            false),
                                                                        child: Text(
                                                                            'Отмена'),
                                                                      ),
                                                                      TextButton(
                                                                        onPressed: () => Navigator.pop(
                                                                            alertDialogContext,
                                                                            true),
                                                                        child: Text(
                                                                            'Удалить'),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            ) ??
                                                            false;
                                                    if (confirmDialogResponse) {
                                                      _model.apiResultrs5 =
                                                          await DeliveryDetailsGroup
                                                              .deleteDeliveryAddressCall
                                                              .call(
                                                        addressId: getJsonField(
                                                          addressItem,
                                                          r'''$.id''',
                                                        ),
                                                        jwtToken: FFAppState()
                                                            .jwttoken,
                                                      );
                                                      if ((_model.apiResultrs5
                                                              ?.succeeded ??
                                                          true)) {
                                                        await showDialog(
                                                          context: context,
                                                          builder:
                                                              (alertDialogContext) {
                                                            return WebViewAware(
                                                              child:
                                                                  AlertDialog(
                                                                title: Text(
                                                                    'Успешно'),
                                                                content: Text(
                                                                    'Удален успешно'),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            alertDialogContext),
                                                                    child: Text(
                                                                        'Ок'),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        );
                                                        Navigator.pop(context);
                                                      } else {
                                                        await showDialog(
                                                          context: context,
                                                          builder:
                                                              (alertDialogContext) {
                                                            return WebViewAware(
                                                              child:
                                                                  AlertDialog(
                                                                title: Text(
                                                                    'Ошибка'),
                                                                content: Text(
                                                                    'Ошибка при удалении'),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            alertDialogContext),
                                                                    child: Text(
                                                                        'Oк'),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        );
                                                        Navigator.pop(context);
                                                      }
                                                    } else {
                                                      Navigator.pop(context);
                                                    }

                                                    setState(() {});
                                                  },
                                                  child: Icon(
                                                    Icons.delete_outline,
                                                    color: Color(0xFFB11C09),
                                                    size: 20.0,
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
