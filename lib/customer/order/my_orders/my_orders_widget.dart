import '../../../main.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/customer/order/order_products/order_products_widget.dart';
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
import 'my_orders_model.dart';
export 'my_orders_model.dart';

class MyOrdersWidget extends StatefulWidget {
  const MyOrdersWidget({super.key});

  @override
  State<MyOrdersWidget> createState() => _MyOrdersWidgetState();
}

class _MyOrdersWidgetState extends State<MyOrdersWidget> {
  late MyOrdersModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyOrdersModel());

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
            'Мои заказы',
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
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(15.0, 8.0, 8.0, 0.0),
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
                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  setState(() {
                                    _model.orderStatus = OrderStatus.CREATED;
                                  });
                                },
                                text: 'Ожидающие',
                                options: FFButtonOptions(
                                  height: 28.0,
                                  padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                  iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                  color: _model.orderStatus == OrderStatus.CREATED ? const Color(0xFFFCA522) : Colors.white,
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
                                  borderSide: const BorderSide(
                                    color: Color(0xFFFCA522),
                                    width: 1.0,
                                  ),
                                  borderRadius: const BorderRadius.only(
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color:
                                    _model.orderStatus == OrderStatus.APPROVED
                                        ? const Color(0xFFFCA522)
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
                                borderSide: const BorderSide(
                                  color: Color(0xFFFCA522),
                                  width: 1.0,
                                ),
                                borderRadius: const BorderRadius.only(
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color:
                                    _model.orderStatus == OrderStatus.CANCELED
                                        ? const Color(0xFFFCA522)
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
                                borderSide: const BorderSide(
                                  color: Color(0xFFFCA522),
                                  width: 1.0,
                                ),
                                borderRadius: const BorderRadius.only(
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: _model.orderStatus == OrderStatus.CLOSED
                                    ? const Color(0xFFFCA522)
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
                                borderSide: const BorderSide(
                                  color: Color(0xFFFCA522),
                                  width: 1.0,
                                ),
                                borderRadius: const BorderRadius.only(
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
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 50.0),
                  child: FutureBuilder<ApiCallResponse>(

                    future: OrderGroup.myOrdersCall.call(
                      jwtToken: FFAppState().jwttoken,
                      status: _model.orderStatus?.name,
                    ),

                    builder: (context, snapshot) {

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

                      final listViewMyOrdersResponse = snapshot.data!;
                      return Builder(
                        builder: (context) {
                          final order = getJsonField(listViewMyOrdersResponse.jsonBody, r'''$.list''',).toList();
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: order.length,
                            itemBuilder: (context, orderIndex) {
                              final orderItem = order[orderIndex];

                              return Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 8.0),
                                child: Container(
                                  width: 100.0,
                                  height: 200.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: const Color(0x28000000),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 15.0, 0.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                    child: RichText(
                                                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: 'Заказ номер: ',
                                                            style: FlutterFlowTheme.of(context).bodyMedium
                                                                .override(
                                                                  fontFamily: 'Readex Pro',
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                          ),
                                                          TextSpan(
                                                            text: getJsonField(
                                                              orderItem,
                                                              r'''$.id''',
                                                            ).toString(),
                                                            style: const TextStyle(
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
                                                        const EdgeInsetsDirectional
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
                                                              const AlignmentDirectional(
                                                                  -1.0, 0.0),
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              functions
                                                                  .formatStatus(
                                                                      getJsonField(
                                                                orderItem,
                                                                r'''$.status''',
                                                              ).toString()),
                                                              '0',
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: const Color(
                                                                      0xFF0E5E99),
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
                                                          text: 'Поставщик:  ',
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
                                                            r'''$.provider.name''',
                                                          ).toString(),
                                                          style: const TextStyle(
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
                                                          style: const TextStyle(
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
                                                          style: const TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        const TextSpan(
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
                                            const Divider(
                                              thickness: 0.4,
                                              color: Color(0xCCB9B9B9),
                                            ),
                                            Builder(
                                              builder: (context) => Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                                                child: InkWell(
                                                  splashColor: Colors.transparent,
                                                  focusColor: Colors.transparent,
                                                  hoverColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  onTap: () async {
                                                    _model.apiResultj5eCopy = await OrderGroup.orderByIdCall.call(
                                                      jwtToken: FFAppState().jwttoken,
                                                      orderId: getJsonField(orderItem, r'''$.id''',),
                                                    );

                                                    // print(orderItem["deliveryDetails"]["latitude"]);

                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                                      return OrderProductsWidget(
                                                        order: getJsonField(orderItem, r'''$''',),
                                                        products: getJsonField((_model.apiResultj5eCopy?.jsonBody ?? ''), r'''$.details''',),
                                                        latitude: orderItem["deliveryDetails"]["latitude"],
                                                        longitude: orderItem["deliveryDetails"]["longitude"],
                                                      );
                                                    }));

                                                    // if ((_model.apiResultj5eCopy?.succeeded ?? true)) {
                                                    //   await showDialog(
                                                    //     context: context,
                                                    //     builder: (dialogContext) {
                                                    //       return Dialog(
                                                    //         elevation: 0,
                                                    //         insetPadding: EdgeInsets.zero,
                                                    //         backgroundColor: Colors.transparent,
                                                    //         alignment: AlignmentDirectional(0.0, 0.0)
                                                    //             .resolve(Directionality.of(context)),
                                                    //         child: WebViewAware(
                                                    //           child: GestureDetector(
                                                    //                 onTap: () => _model.unfocusNode.canRequestFocus
                                                    //                     ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                    //                     : FocusScope.of(context).unfocus(),
                                                    //                 child: OrderProductsWidget(order: getJsonField(orderItem, r'''$''',), products: getJsonField((_model.apiResultj5eCopy?.jsonBody ?? ''), r'''$.details''',),),
                                                    //               ),
                                                    //         ),
                                                    //       );
                                                    //     },
                                                    //   ).then((value) => setState(() {}));
                                                    // } else {
                                                    //   await showDialog(
                                                    //     context: context,
                                                    //     builder:
                                                    //         (alertDialogContext) {
                                                    //       return WebViewAware(
                                                    //         child: AlertDialog(
                                                    //           title: Text(
                                                    //               'Ошибка'),
                                                    //           content: Text((_model
                                                    //                       .apiResultj5eCopy
                                                    //                       ?.jsonBody ??
                                                    //                   '')
                                                    //               .toString()),
                                                    //           actions: [
                                                    //             TextButton(
                                                    //               onPressed: () =>
                                                    //                   Navigator.pop(
                                                    //                       alertDialogContext),
                                                    //               child: Text(
                                                    //                   'Ok'),
                                                    //             ),
                                                    //           ],
                                                    //         ),
                                                    //       );
                                                    //     },
                                                    //   );
                                                    // }
                                                    //
                                                    // setState(() {});
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 37.0,
                                                    decoration: const BoxDecoration(
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
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Readex Pro',
                                                                color: const Color(
                                                                    0xFF0B7FD1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .keyboard_arrow_right,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          size: 24.0,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Divider(
                                              thickness: 0.4,
                                              color: Color(0xCCB9B9B9),
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
    );
  }
}
