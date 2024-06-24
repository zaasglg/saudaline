import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sauda_line/app_state.dart';
import 'package:sauda_line/flutter_flow/flutter_flow_theme.dart';
import 'package:sauda_line/flutter_flow/flutter_flow_util.dart';
import 'package:sauda_line/flutter_flow/flutter_flow_web_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sauda_line/flutter_flow/custom_functions.dart' as functions;

class AdminOrdersDetailPage extends StatefulWidget {
  const AdminOrdersDetailPage({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  final int orderId;

  @override
  State<AdminOrdersDetailPage> createState() => _AdminOrdersDetailPageState();
}

class _AdminOrdersDetailPageState extends State<AdminOrdersDetailPage> {

  Future<dynamic> fetchRequestsList() async {
    final response = await http.get(
        Uri.parse('https://server.saudaline.kz/api/v1/orders/get-by-id?orderId=${widget.orderId}'),
        headers: { "Authorization": "Bearer ${FFAppState().jwttoken}" }
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        automaticallyImplyLeading: true,
        title: Text("Заказ №${widget.orderId}", style: TextStyle(
          fontFamily: "Futura",
        ),),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: CupertinoColors.systemGrey6,
          ),
          child: FutureBuilder<dynamic>(
            future: fetchRequestsList(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CupertinoActivityIndicator();
              } else {
                var order = snapshot.data;

                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Text('Заказчик:  ',
                                    style: TextStyle(
                                      fontFamily: 'Futura',
                                      color: Colors.black54,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10.0,),
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      color: Colors.white
                                  ),
                                  child: Text("${order["customer"]["businessType"]["name"]} ${order["customer"]["name"]}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Futura"
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.0,),

                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Text('Заказ:  ',
                                    style: TextStyle(
                                      fontFamily: 'Futura',
                                      color: Colors.black54,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10.0,),
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      color: Colors.white
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        textScaleFactor:
                                        MediaQuery.of(context).textScaleFactor,
                                        text: TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: 'Дата заказа: ',
                                              style: TextStyle(
                                                fontFamily: 'Futura',
                                                color: Colors.black,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            TextSpan(
                                              text: functions.formatDate(order["created"]).toString(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Futura",
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      RichText(
                                        textScaleFactor:
                                        MediaQuery.of(context).textScaleFactor,
                                        text: TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: 'Адрес доставки: ',
                                              style: TextStyle(
                                                fontFamily: 'Futura',
                                                color: Colors.black,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            TextSpan(
                                              text: order["deliveryDetails"]["address"],
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Futura",
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      if (order["deliveryDate"] != null)
                                        RichText(
                                          textScaleFactor:
                                          MediaQuery.of(context).textScaleFactor,
                                          text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: 'Дата доставки: ',
                                                style: TextStyle(
                                                  fontFamily: 'Futura',
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              TextSpan(
                                                text: functions.formatDate(order["deliveryDate"]).toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Futura",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),

                                      Text(
                                        functions.formatAdminStatus(order["status"]).toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontFamily: 'Futura',
                                          color: Color(0xFF0E5E99),
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            FlutterFlowWebView(
                              content: functions.generateMapScript("[${order["deliveryDetails"]["longitude"]}, ${order["deliveryDetails"]["latitude"]}]")!,
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: 300.0,
                              verticalScroll: true,
                              horizontalScroll: true,
                              html: true,
                            ),

                            Container(
                              color: Colors.white,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                              child: CupertinoButton(
                                  color: FlutterFlowTheme.of(context).primary,
                                  child: Text("Открыть карту"),
                                  onPressed: () {
                                    // launch("https://yandex.ru/maps/?rtext=~${widget.latitude},${widget.longitude}&rtt=auto");
                                  }
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 0.0, 20.0),
                              child: Text('Товары',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: 'Futura',
                                  color: const Color(0xFF14181B),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Builder(
                              builder: (context) {
                                final products = order["details"];

                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: products.length,
                                  itemBuilder: (context, productIndex) {
                                    final productItem = products[productIndex];
                                    return Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Stack(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 0.0, 0.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(8.0),
                                                  child: Image.network(
                                                      productItem["product"]["mainPhoto"]["url"],
                                                    width: 100.0,
                                                    height: 100.0,
                                                    fit: BoxFit.fitWidth,
                                                  ),
                                                ),
                                              ),
                                              if (getJsonField(
                                                productItem,
                                                r'''$.discount''',
                                              ) !=
                                                  getJsonField(
                                                    functions.returnJsonZero(),
                                                    r'''$.value''',
                                                  ))
                                                Padding(
                                                  padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                      14.0, 12.0, 0.0, 0.0),
                                                  child: Container(
                                                    width: 40.0,
                                                    height: 20.0,
                                                    decoration: BoxDecoration(
                                                      color: const Color(0xFFCF1212),
                                                      borderRadius:
                                                      BorderRadius.circular(40.0),
                                                    ),
                                                    alignment: const AlignmentDirectional(
                                                        0.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          getJsonField(
                                                            productItem,
                                                            r'''$.sumWithDiscount''',
                                                          ).toString(),
                                                          style: FlutterFlowTheme.of(
                                                              context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'Readex Pro',
                                                            color: Colors.white,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                        Text(
                                                          '%',
                                                          style: FlutterFlowTheme.of(
                                                              context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'Readex Pro',
                                                            color: Colors.white,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                10.0, 20.0, 0.0, 10.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 210.0,
                                                  height: 40.0,
                                                  decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  child: AutoSizeText(
                                                    getJsonField(
                                                      productItem,
                                                      r'''$.product.title''',
                                                    ).toString().maybeHandleOverflow(
                                                      maxChars: 40,
                                                      replacement: '…',
                                                    ),
                                                    maxLines: 2,
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .bodyMedium
                                                        .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: const Color(0xFF14181B),
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ),
                                                RichText(
                                                  textScaleFactor:
                                                  MediaQuery.of(context)
                                                      .textScaleFactor,
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: 'Количество: ',
                                                        style: FlutterFlowTheme.of(
                                                            context)
                                                            .bodyMedium
                                                            .override(
                                                          fontFamily:
                                                          'Readex Pro',
                                                          color: Colors.black,
                                                          fontWeight:
                                                          FontWeight.w600,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: functions
                                                            .doubleToInt(getJsonField(
                                                          productItem,
                                                          r'''$.quantity''',
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
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                      0.0, 5.0, 0.0, 0.0),
                                                  child: RichText(
                                                    textScaleFactor:
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'Цена: ',
                                                          style: FlutterFlowTheme.of(
                                                              context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'Readex Pro',
                                                            color: Colors.black,
                                                            fontWeight:
                                                            FontWeight.w600,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: functions
                                                              .doubleToInt(
                                                              getJsonField(
                                                                productItem,
                                                                r'''$.price''',
                                                              ))
                                                              .toString(),
                                                          style: const TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        const TextSpan(
                                                          text: ' т',
                                                          style: TextStyle(),
                                                        )
                                                      ],
                                                      style:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium,
                                                    ),
                                                  ),
                                                ),
                                                if (getJsonField(
                                                  productItem,
                                                  r'''$.discount''',
                                                ) !=
                                                    getJsonField(
                                                      functions.returnJsonZero(),
                                                      r'''$.value''',
                                                    ))
                                                  Padding(
                                                    padding: const EdgeInsetsDirectional
                                                        .fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                    child: RichText(
                                                      textScaleFactor:
                                                      MediaQuery.of(context)
                                                          .textScaleFactor,
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: 'Цена со скидкой: ',
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .bodyMedium
                                                                .override(
                                                              fontFamily:
                                                              'Readex Pro',
                                                              color: Colors.black,
                                                              fontWeight:
                                                              FontWeight.w600,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: functions
                                                                .doubleToInt(
                                                                getJsonField(
                                                                  productItem,
                                                                  r'''$.priceWithDiscount''',
                                                                ))
                                                                .toString(),
                                                            style: const TextStyle(
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                          const TextSpan(
                                                            text: ' т',
                                                            style: TextStyle(),
                                                          )
                                                        ],
                                                        style: FlutterFlowTheme.of(
                                                            context)
                                                            .bodyMedium,
                                                      ),
                                                    ),
                                                  ),
                                                if (getJsonField(
                                                  productItem,
                                                  r'''$.discount''',
                                                ) !=
                                                    getJsonField(
                                                      functions.returnJsonZero(),
                                                      r'''$.value''',
                                                    ))
                                                  Padding(
                                                    padding: const EdgeInsetsDirectional
                                                        .fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                    child: RichText(
                                                      textScaleFactor:
                                                      MediaQuery.of(context)
                                                          .textScaleFactor,
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                            'Сумма со скидкой: ',
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .bodyMedium
                                                                .override(
                                                              fontFamily:
                                                              'Readex Pro',
                                                              color: Colors.black,
                                                              fontWeight:
                                                              FontWeight.w600,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: functions
                                                                .doubleToInt(
                                                                getJsonField(
                                                                  productItem,
                                                                  r'''$.sumWithDiscount''',
                                                                ))
                                                                .toString(),
                                                            style: const TextStyle(
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                          const TextSpan(
                                                            text: ' т',
                                                            style: TextStyle(),
                                                          )
                                                        ],
                                                        style: FlutterFlowTheme.of(
                                                            context)
                                                            .bodyMedium,
                                                      ),
                                                    ),
                                                  ),
                                                if (getJsonField(
                                                  productItem,
                                                  r'''$.discount''',
                                                ) ==
                                                    getJsonField(
                                                      functions.returnJsonZero(),
                                                      r'''$.value''',
                                                    ))
                                                  Padding(
                                                    padding: const EdgeInsetsDirectional
                                                        .fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                    child: RichText(
                                                      textScaleFactor:
                                                      MediaQuery.of(context)
                                                          .textScaleFactor,
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: 'Сумма: ',
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .bodyMedium
                                                                .override(
                                                              fontFamily:
                                                              'Readex Pro',
                                                              color: Colors.black,
                                                              fontWeight:
                                                              FontWeight.w600,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: functions
                                                                .doubleToInt(
                                                                getJsonField(
                                                                  productItem,
                                                                  r'''$.sum''',
                                                                ))
                                                                .toString(),
                                                            style: const TextStyle(
                                                              color: Colors.black,
                                                            ),
                                                          )
                                                        ],
                                                        style: FlutterFlowTheme.of(
                                                            context)
                                                            .bodyMedium,
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20.0),
                              decoration: BoxDecoration(
                                  color: Colors.white
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1,
                                                color: Colors.black12
                                            )
                                        )
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Количество: ", style: TextStyle(
                                          fontFamily: 'Futura',
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                        ),),
                                        Text("${functions.doubleToInt(order["totalQuantity"]).toString()} Шт", style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Futura",
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Сумма заказа", style: TextStyle(
                                              fontFamily: 'Futura',
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                            ),),
                                            Text("Cкидка от SaudaLine (1%):", style: TextStyle(
                                              fontFamily: 'Futura',
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),),
                                          ],
                                        ),

                                        Text("${functions.minusOnePercent(getJsonField(order, r'''$.totalAmountWithDiscount''',)).toString()} Тг", style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Futura",
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
