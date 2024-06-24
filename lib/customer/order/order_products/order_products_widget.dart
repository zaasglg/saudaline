import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sauda_line/flutter_flow/flutter_flow_web_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'order_products_model.dart';
export 'order_products_model.dart';

class OrderProductsWidget extends StatefulWidget {
  const OrderProductsWidget({
    super.key,
    required this.order,
    required this.products,
    required this.latitude,
    required this.longitude
  });

  final dynamic order;
  final dynamic products;
  final String? latitude;
  final String? longitude;

  @override
  State<OrderProductsWidget> createState() => _OrderProductsWidgetState();
}

class _OrderProductsWidgetState extends State<OrderProductsWidget> {
  late OrderProductsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OrderProductsModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    print(widget.order);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        title: Text("Заказ №${getJsonField(widget.order, r'''$.id''',).toString()}", style: const TextStyle(
          fontFamily: "Futura",
        )),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: CupertinoColors.systemGrey6,
        ),
        child: Column(
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
                          child: Text('Поставщик:  ',
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
                          child: Text(getJsonField(widget.order, r'''$.provider.name''',).toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Futura"
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0,),

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
                                      text: valueOrDefault<String>(functions.formatDate(getJsonField(widget.order, r'''$.created''',).toString()), 'error',),
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
                                      text: widget.order["deliveryDetails"]["address"],
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Futura",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              if (getJsonField(widget.order, r'''$.deliveryDate''',) != null)
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
                                      text: valueOrDefault<String>(functions.formatDate(getJsonField(widget.order, r'''$.deliveryDate''',).toString()), 'error',),
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
                                valueOrDefault<String>(functions.formatStatus(getJsonField(widget.order, r'''$.status''',).toString()), '0',),
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
                      content: functions.generateMapScript("[${widget.longitude}, ${widget.latitude}]")!,
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
                            launch("https://yandex.ru/maps/?rtext=~${widget.latitude},${widget.longitude}&rtt=auto");
                          }
                      ),
                    ),

                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 0.0, 20.0),
                      child: Text('Вы заказали',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Futura',
                          color: Color(0xFF14181B),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        final product = widget.products!.toList();
                        print(product);
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: product.length,
                          itemBuilder: (context, productIndex) {
                            final productItem = product[productIndex];
                            return Container(
                              width: 100.0,
                              height: 160.0,
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
                                            valueOrDefault<String>(
                                              getJsonField(
                                                productItem,
                                                r'''$.product.mainPhoto.url''',
                                              )?.toString(),
                                              'https://saudaline.kz/images/logo.png',
                                            ),
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
                                                    r'''$.discount''',
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
                      margin: const EdgeInsets.symmetric(vertical: 20.0),
                      decoration: const BoxDecoration(
                        color: Colors.white
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                            decoration: const BoxDecoration(
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
                                const Text("Количество: ", style: TextStyle(
                                  fontFamily: 'Futura',
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),),
                                Text("${functions.doubleToInt(getJsonField(widget.order, r'''$.totalQuantity''',)).toString()} Шт", style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Futura",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),)
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Сумма заказа", style: TextStyle(
                                      fontFamily: 'Futura',
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),),
                                    Text("Скидка от Saudaline (1%)", style: TextStyle(
                                      fontFamily: 'Futura',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),),
                                  ],
                                ),
                                Text("${functions.minusOnePercent(widget.order["totalAmountWithDiscount"]).toString()} Тг", style: const TextStyle(
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
        ),
      ),
    );
  }
}
