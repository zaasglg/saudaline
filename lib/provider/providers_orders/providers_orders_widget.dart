import 'dart:convert';

import 'package:sauda_line/index.dart';
import 'package:sauda_line/main.dart';

import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'providers_orders_model.dart';
export 'providers_orders_model.dart';
import "package:http/http.dart" as http;

class ProvidersOrdersWidget extends StatefulWidget {
  const ProvidersOrdersWidget({super.key});

  @override
  State<ProvidersOrdersWidget> createState() => _ProvidersOrdersWidgetState();
}

class _ProvidersOrdersWidgetState extends State<ProvidersOrdersWidget> {
  late ProvidersOrdersModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  int? selectedCityId;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProvidersOrdersModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.orderStatus = OrderStatus.CREATED;
      });
    });
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
          automaticallyImplyLeading: true,
          title: Text(
            'Заказы',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 4.0,
        ),
        body: WillPopScope(
          onWillPop: () async {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return NavBarPage(currentPageName: "profile",);
            }));

            return false;
          },
          child: SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15.0, 8.0, 8.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    setState(() {
                                      _model.orderStatus = OrderStatus.CREATED;
                                    });
                                  },
                                  text: 'Ожидающие',
                                  options: FFButtonOptions(
                                    height: 28.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                    color:
                                        _model.orderStatus == OrderStatus.CREATED
                                            ? Color(0xFFFCA522)
                                            : Colors.white,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: _model.orderStatus ==
                                                  OrderStatus.CREATED
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 14.0,
                                        ),
                                    borderSide: BorderSide(
                                      color: Color(0xFFFCA522),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(0.0),
                                      bottomRight: Radius.circular(0.0),
                                      topLeft: Radius.circular(0.0),
                                      topRight: Radius.circular(0.0),
                                    ),
                                  ),
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  setState(() {
                                    _model.orderStatus = OrderStatus.APPROVED;
                                  });
                                },
                                text: 'Принятые',
                                options: FFButtonOptions(
                                  height: 28.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color:
                                      _model.orderStatus == OrderStatus.APPROVED
                                          ? Color(0xFFFCA522)
                                          : Colors.white,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: _model.orderStatus ==
                                                OrderStatus.APPROVED
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14.0,
                                      ),
                                  borderSide: BorderSide(
                                    color: Color(0xFFFCA522),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(0.0),
                                    bottomRight: Radius.circular(0.0),
                                    topLeft: Radius.circular(0.0),
                                    topRight: Radius.circular(0.0),
                                  ),
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  setState(() {
                                    _model.orderStatus = OrderStatus.CANCELED;
                                  });
                                },
                                text: 'Непринятые',
                                options: FFButtonOptions(
                                  height: 28.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color:
                                      _model.orderStatus == OrderStatus.CANCELED
                                          ? Color(0xFFFCA522)
                                          : Colors.white,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: _model.orderStatus ==
                                                OrderStatus.CANCELED
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14.0,
                                      ),
                                  borderSide: BorderSide(
                                    color: Color(0xFFFCA522),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(0.0),
                                    bottomRight: Radius.circular(0.0),
                                    topLeft: Radius.circular(0.0),
                                    topRight: Radius.circular(0.0),
                                  ),
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  setState(() {
                                    _model.orderStatus = OrderStatus.CLOSED;
                                  });
                                },
                                text: 'Отклонные ',
                                options: FFButtonOptions(
                                  height: 28.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: _model.orderStatus == OrderStatus.CLOSED
                                      ? Color(0xFFFCA522)
                                      : Colors.white,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: _model.orderStatus ==
                                                OrderStatus.CLOSED
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14.0,
                                      ),
                                  borderSide: BorderSide(
                                    color: Color(0xFFFCA522),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(0.0),
                                    bottomRight: Radius.circular(0.0),
                                    topLeft: Radius.circular(0.0),
                                    topRight: Radius.circular(0.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: FutureBuilder<List<dynamic>>(
                      future: fetchCities(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('No cities found'));
                        } else {

                          List<dynamic> cities = snapshot.data!;

                          return Container(
                            margin: const EdgeInsets.all(10.0),
                            height: 30.0,
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(100.0),
                                color: Colors.grey.withOpacity(0.2)
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                hint: Text('Город'),
                                value: selectedCityId,
                                padding: EdgeInsets.zero,
                                onChanged: (int? newValue) {
                                  setState(() {
                                    selectedCityId = newValue;
                                  });
                                },
                                items: cities.map((city) {
                                  return DropdownMenuItem<int>(
                                    value: city['id'],
                                    child: Text(city['name'], style: TextStyle(
                                      fontFamily: "Futura",
                                      fontSize: 13.0
                                    ),),
                                  );
                                }).toList(),
                              ),
                            ),
                          );

                        }
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 50.0),
                    child: FutureBuilder<ApiCallResponse>(
                      future: OrdersGroup.getProvidersOrdersCall.call(
                        jwtToken: FFAppState().jwttoken,
                        userId: getJsonField(FFAppState().accountInfo, r'''$.id''',),
                        status: _model.orderStatus?.name,
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
                        final listViewGetProvidersOrdersResponse = snapshot.data!;

                        return Builder(
                          builder: (context) {
                            final order = OrdersGroup.getProvidersOrdersCall.ordersList(listViewGetProvidersOrdersResponse.jsonBody,)?.toList() ?? [];

                            var filterData = order;
                            if (selectedCityId != null) {
                              filterData = order.where((element) => element["city"]["id"] == selectedCityId).toList();
                            }


                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: filterData.length,
                              itemBuilder: (context, orderIndex) {
                                final orderItem = filterData[orderIndex];
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Color(0x28000000),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 15.0, 0.0),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                      child: RichText(
                                                        textScaleFactor:
                                                            MediaQuery.of(context)
                                                                .textScaleFactor,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  'Заказ номер: ',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                            ),
                                                            TextSpan(
                                                              text: getJsonField(
                                                                orderItem,
                                                                r'''$.id''',
                                                              ).toString(),
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.black,
                                                              ),
                                                            )
                                                          ],
                                                          style:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(0.0, 5.0,
                                                                  0.0, 0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Container(
                                                            width: 250.0,
                                                            height: 20.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                            ),
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -1.0, 0.0),
                                                            child: Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                functions
                                                                    .formatStatusProvider(
                                                                        getJsonField(
                                                                  orderItem,
                                                                  r'''$.status''',
                                                                ).toString()),
                                                                'error',
                                                              ),
                                                              textAlign: TextAlign
                                                                  .center,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    color:
                                                                        colorFromCssString(
                                                                      functions
                                                                          .formatStatusColor(
                                                                              getJsonField(
                                                                        orderItem,
                                                                        r'''$.status''',
                                                                      ).toString())!,
                                                                      defaultColor:
                                                                          Colors
                                                                              .black,
                                                                    ),
                                                                    fontSize:
                                                                        14.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    RichText(
                                                      textScaleFactor:
                                                          MediaQuery.of(context)
                                                              .textScaleFactor,
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                'Сумма заказа: ',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                          TextSpan(
                                                            text: functions
                                                                .doubleToInt(
                                                                    getJsonField(
                                                                  orderItem,
                                                                  r'''$.totalAmountWithDiscount''',
                                                                ))
                                                                .toString(),
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                            ),
                                                          )
                                                        ],
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium,
                                                      ),
                                                    ),
                                                    RichText(
                                                      textScaleFactor:
                                                      MediaQuery.of(context)
                                                          .textScaleFactor,
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                            'Город: ',
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .bodyMedium
                                                                .override(
                                                              fontFamily:
                                                              'Readex Pro',
                                                              color: Colors
                                                                  .black,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: getJsonField(
                                                              orderItem,
                                                              r'''$.city.name''',
                                                            ),
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                            ),
                                                          )
                                                        ],
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyMedium,
                                                      ),
                                                    ),
                                                    RichText(
                                                      textScaleFactor:
                                                          MediaQuery.of(context)
                                                              .textScaleFactor,
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: 'Товаров: ',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                          TextSpan(
                                                            text: functions
                                                                .doubleToInt(
                                                                    getJsonField(
                                                                  orderItem,
                                                                  r'''$.totalQuantity''',
                                                                ))
                                                                .toString(),
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: ' шт',
                                                            style: TextStyle(),
                                                          )
                                                        ],
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                thickness: 0.4,
                                                color: Color(0xCCB9B9B9),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                                                child: InkWell(
                                                  splashColor: Colors.transparent,
                                                  focusColor: Colors.transparent,
                                                  hoverColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  onTap: () async {
                                                    _model.apiResultj5eCopy =
                                                        await OrderGroup.orderByIdCall.call(
                                                          jwtToken: FFAppState().jwttoken,
                                                          orderId: getJsonField(orderItem, r'''$.id''',),
                                                        );

                                                    if ((_model.apiResultj5eCopy?.succeeded ?? true)) {

                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                                        return ProviderOrderDetailsWidget(
                                                          order: _model.apiResultj5eCopy?.jsonBody ?? '',
                                                          products: getJsonField((_model.apiResultj5eCopy?.jsonBody ?? ''), r'''$.details''', true,),
                                                          address: orderItem["deliveryDetails"]["address"],
                                                          longitude: orderItem["deliveryDetails"]["longitude"],
                                                          latitude: orderItem["deliveryDetails"]["latitude"],
                                                        );
                                                      }));

                                                    } else {
                                                      await showDialog(
                                                        context: context,
                                                        builder:
                                                            (alertDialogContext) {
                                                          return WebViewAware(
                                                            child: AlertDialog(
                                                              title:
                                                                  Text('Ошибка '),
                                                              content: Text((_model
                                                                          .apiResultj5eCopy
                                                                          ?.jsonBody ??
                                                                      '')
                                                                  .toString()),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext),
                                                                  child:
                                                                      Text('Ok'),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    }

                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 37.0,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Детали заказа',
                                                          style:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    color: Color(
                                                                        0xFF0B7FD1),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                        ),
                                                        Icon(
                                                          Icons.keyboard_arrow_right,
                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                          size: 24.0,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                thickness: 0.4,
                                                color: Color(0xCCB9B9B9),
                                              ),
                                              if (functions
                                                  .orderStatusBtn(getJsonField(
                                                orderItem,
                                                r'''$.status''',
                                              ).toString()))
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          15.0, 0.0, 15.0, 0.0),
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 37.0,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        InkWell(
                                                          splashColor:
                                                              Colors.transparent,
                                                          focusColor:
                                                              Colors.transparent,
                                                          hoverColor:
                                                              Colors.transparent,
                                                          highlightColor:
                                                              Colors.transparent,
                                                          onTap: () async {
                                                            _model.apiResultAccept =
                                                                await OrdersGroup
                                                                    .acceptOrderCall
                                                                    .call(
                                                              jwtToken:
                                                                  FFAppState()
                                                                      .jwttoken,
                                                              orderId:
                                                                  getJsonField(
                                                                orderItem,
                                                                r'''$.id''',
                                                              ),
                                                            );
                                                            if ((_model
                                                                    .apiResultAccept
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
                                                                          'Заказ успешно принят'),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () =>
                                                                                  Navigator.pop(alertDialogContext),
                                                                          child: Text(
                                                                              'Ok'),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            } else {
                                                              await showDialog(
                                                                context: context,
                                                                builder:
                                                                    (alertDialogContext) {
                                                                  return WebViewAware(
                                                                    child:
                                                                        AlertDialog(
                                                                      title: Text(
                                                                          'При принятии заказа произошла ошибка'),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () =>
                                                                                  Navigator.pop(alertDialogContext),
                                                                          child: Text(
                                                                              'Ok'),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            }

                                                            setState(() {});
                                                          },
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize.max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            5.0,
                                                                            0.0),
                                                                child: Icon(
                                                                  Icons.done,
                                                                  color: Color(
                                                                      0xFF0FA131),
                                                                  size: 18.0,
                                                                ),
                                                              ),
                                                              Text(
                                                                'Принять заказ',
                                                                style: FlutterFlowTheme
                                                                        .of(context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Readex Pro',
                                                                      color: Color(
                                                                          0xFF0FA131),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 100.0,
                                                          child: VerticalDivider(
                                                            thickness: 1.0,
                                                            color:
                                                                Color(0xCCC6C6C6),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          splashColor:
                                                              Colors.transparent,
                                                          focusColor:
                                                              Colors.transparent,
                                                          hoverColor:
                                                              Colors.transparent,
                                                          highlightColor:
                                                              Colors.transparent,
                                                          onTap: () async {
                                                            _model.apiResultRejectOrder =
                                                                await OrdersGroup
                                                                    .rejectOrderCall
                                                                    .call(
                                                              jwtToken:
                                                                  FFAppState()
                                                                      .jwttoken,
                                                              orderId:
                                                                  getJsonField(
                                                                orderItem,
                                                                r'''$.id''',
                                                              ),
                                                            );
                                                            if ((_model
                                                                    .apiResultRejectOrder
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
                                                                          'Заказ отклонен'),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () =>
                                                                                  Navigator.pop(alertDialogContext),
                                                                          child: Text(
                                                                              'Ok'),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            } else {
                                                              await showDialog(
                                                                context: context,
                                                                builder:
                                                                    (alertDialogContext) {
                                                                  return WebViewAware(
                                                                    child:
                                                                        AlertDialog(
                                                                      title: Text(
                                                                          'Произошла ошибка при отклонении заказа'),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () =>
                                                                                  Navigator.pop(alertDialogContext),
                                                                          child: Text(
                                                                              'Ok'),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            }

                                                            setState(() {});
                                                          },
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize.max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            5.0,
                                                                            0.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .close_sharp,
                                                                  color: Color(
                                                                      0xFFC84319),
                                                                  size: 18.0,
                                                                ),
                                                              ),
                                                              Text(
                                                                'Отклонить заказ',
                                                                style: FlutterFlowTheme
                                                                        .of(context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Readex Pro',
                                                                      color: Color(
                                                                          0xFFC84319),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
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
          ),
        ),
      ),
    );
  }
}
