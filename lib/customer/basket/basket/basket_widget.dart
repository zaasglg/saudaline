import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sauda_line/customer/order/confirmation_order/confirmation_order_widget.dart';
import 'package:sauda_line/customer/product_page/product_page_widget.dart';
import 'package:sauda_line/index.dart';
import 'package:sauda_line/main.dart';

import '../../../profile/profile_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/customer/basket/counter_basket/counter_basket_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'basket_model.dart';
export 'basket_model.dart';

class BasketWidget extends StatefulWidget {
  const BasketWidget({super.key});

  @override
  State<BasketWidget> createState() => _BasketWidgetState();
}

class _BasketWidgetState extends State<BasketWidget> {
  late BasketModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BasketModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;


    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return NavBarPage(currentPageName: "home",);
        }));

        return false;
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: isDarkMode ? Colors.black38 : const Color(0xFFF1F4F8),
        appBar: AppBar(
          backgroundColor: isDarkMode ? Colors.black : const Color(0xFFF1F4F8) ,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: const AlignmentDirectional(-1.0, 0.0),
                child: Text(
                  'Корзина',
                  style: TextStyle(
                        fontFamily: 'Gilroy',
                        color: isDarkMode ? Colors.white : const Color(0xFF14181B),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              if (!FFAppState().isProvider)
                FlutterFlowIconButton(
                  borderRadius: 20.0,
                  borderWidth: 1.0,
                  buttonSize: 40.0,
                  icon: const Icon(
                    Icons.delete_rounded,
                    color: CupertinoColors.systemRed,
                    size: 26.0,
                  ),
                  onPressed: () async {
                    setState(() {
                      FFAppState().cardProducts = [];
                      FFAppState().basketProducts = [];
                    });
                  },
                ),
            ],
          ),
          actions: const [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (!FFAppState().isProvider)
              StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                return Expanded(
                  child: Align(
                    alignment: const AlignmentDirectional(0.0, -1.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (functions.appStateToPrint(FFAppState().cardProducts.toList()) != '[]' ? true : false)
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(5.0, 4.0, 5.0, 16.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isDarkMode ? Colors.black12 : Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 4.0,
                                        color: Color(0x33000000),
                                        offset: Offset(0.0, 2.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (FFAppState().cardProducts.length != null)
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                                            child: Builder(
                                              builder: (context) {
                                                final cartProvider = FFAppState().basketProducts.toList();
                                                return ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  scrollDirection: Axis.vertical,
                                                  itemCount: cartProvider.length,
                                                  itemBuilder: (context, cartProviderIndex) {
                                                    final cartProviderItem = cartProvider[cartProviderIndex];
                                                    return Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Column(
                                                          mainAxisSize: MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 12.0),
                                                              child: Row(
                                                                mainAxisSize: MainAxisSize.max,
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [

                                                                  // Image
                                                                  Container(
                                                                    width: 60.0, height: 60.0,
                                                                    clipBehavior: Clip.antiAlias,
                                                                    decoration: const BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                    ),
                                                                    child: Image.network(valueOrDefault<String>(getJsonField(cartProviderItem, r'''$.providerImage''',)?.toString(), 'https://saudaline.kz/images/logo.png',), fit: BoxFit.fitWidth,),
                                                                  ),
                                                                  SizedBox(width: 10.0,),
                                                                  Column(
                                                                    mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(
                                                                        'Поставщик:', style: TextStyle(
                                                                          fontFamily: 'Gilroy',
                                                                          color: isDarkMode ? Colors.white60 : Color(0xFF14181B),
                                                                          fontSize: 12.0,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        child: AutoSizeText(getJsonField(cartProviderItem, r'''$.providerName''',).toString().maybeHandleOverflow(maxChars: 40, replacement: '…',),
                                                                          maxLines: 3,
                                                                          style: TextStyle(
                                                                            fontFamily: 'Gilroy',
                                                                            color: isDarkMode ? Colors.white : Color(0xFF14181B),
                                                                            fontSize: 14.0,
                                                                            fontWeight: FontWeight.w700,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  // Column(
                                                                  //   mainAxisSize: MainAxisSize.max,
                                                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                                                  //   children: [
                                                                  //     RichText(
                                                                  //       textScaleFactor: MediaQuery.of(context).textScaleFactor,
                                                                  //       text:
                                                                  //       TextSpan(
                                                                  //         children: [
                                                                  //           TextSpan(
                                                                  //             text:
                                                                  //             'Скидка',
                                                                  //             style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  //               fontFamily: 'Readex Pro',
                                                                  //               color: const Color(0xFFFCA522),
                                                                  //               fontWeight: FontWeight.bold,
                                                                  //             ),
                                                                  //           ),
                                                                  //           TextSpan(
                                                                  //             text:
                                                                  //             ' - ',
                                                                  //             style:
                                                                  //             TextStyle(
                                                                  //               color: isDarkMode ? Colors.white : Colors.black,
                                                                  //             ),
                                                                  //           ),
                                                                  //           TextSpan(
                                                                  //             text:
                                                                  //             getJsonField(
                                                                  //               cartProviderItem,
                                                                  //               r'''$.totalDiscount''',
                                                                  //             ).toString(),
                                                                  //             style:
                                                                  //             TextStyle(
                                                                  //               color: isDarkMode ? Colors.white : Colors.black,
                                                                  //             ),
                                                                  //           ),
                                                                  //           TextSpan(text: ' ₸', style:
                                                                  //             TextStyle(
                                                                  //               color: isDarkMode ? Colors.white : Colors.black,
                                                                  //               fontSize: 12.0,
                                                                  //             ),
                                                                  //           )
                                                                  //         ],
                                                                  //         style: FlutterFlowTheme.of(context)
                                                                  //             .bodyMedium,
                                                                  //       ),
                                                                  //     ),
                                                                  //     RichText(
                                                                  //       textScaleFactor:
                                                                  //       MediaQuery.of(context)
                                                                  //           .textScaleFactor,
                                                                  //       text:
                                                                  //       TextSpan(
                                                                  //         children: [
                                                                  //           TextSpan(
                                                                  //             text:
                                                                  //             'Товаров',
                                                                  //             style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  //               fontFamily: 'Readex Pro',
                                                                  //               color: const Color(0xFFFCA522),
                                                                  //               fontWeight: FontWeight.bold,
                                                                  //             ),
                                                                  //           ),
                                                                  //           TextSpan(
                                                                  //             text:
                                                                  //             ' - ',
                                                                  //             style:
                                                                  //             TextStyle(
                                                                  //               color: isDarkMode ? Colors.white : Colors.black,
                                                                  //             ),
                                                                  //           ),
                                                                  //           TextSpan(
                                                                  //             text:
                                                                  //             getJsonField(
                                                                  //               cartProviderItem,
                                                                  //               r'''$.totalQuantity''',
                                                                  //             ).toString(),
                                                                  //             style:
                                                                  //             TextStyle(
                                                                  //               color: isDarkMode ? Colors.white : Colors.black,
                                                                  //             ),
                                                                  //           ),
                                                                  //           TextSpan(
                                                                  //             text:
                                                                  //             ' шт',
                                                                  //             style:
                                                                  //             TextStyle(
                                                                  //               color: isDarkMode ? Colors.white : Colors.black,
                                                                  //               fontSize: 12.0,
                                                                  //             ),
                                                                  //           )
                                                                  //         ],
                                                                  //         style: FlutterFlowTheme.of(context)
                                                                  //             .bodyMedium,
                                                                  //       ),
                                                                  //     ),
                                                                  //     RichText(
                                                                  //       textScaleFactor:
                                                                  //       MediaQuery.of(context).textScaleFactor,
                                                                  //       text: TextSpan(
                                                                  //         children: [
                                                                  //           TextSpan(
                                                                  //             text:
                                                                  //             'Сумма',
                                                                  //             style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  //               fontFamily: 'Readex Pro',
                                                                  //               color: const Color(0xFFFCA522),
                                                                  //               fontWeight: FontWeight.bold,
                                                                  //             ),
                                                                  //           ),
                                                                  //           TextSpan(
                                                                  //             text:
                                                                  //             ' - ',
                                                                  //             style:
                                                                  //             TextStyle(
                                                                  //               color: isDarkMode ? Colors.white : Colors.black,
                                                                  //             ),
                                                                  //           ),
                                                                  //           TextSpan(
                                                                  //             text:
                                                                  //             getJsonField(
                                                                  //               cartProviderItem,
                                                                  //               r'''$.totalSum''',
                                                                  //             ).toString(),
                                                                  //             style:
                                                                  //             TextStyle(
                                                                  //               color: isDarkMode ? Colors.white : Colors.black,
                                                                  //             ),
                                                                  //           ),
                                                                  //           TextSpan(
                                                                  //             text:
                                                                  //             ' ₸',
                                                                  //             style:
                                                                  //             TextStyle(
                                                                  //               color: isDarkMode ? Colors.white : Colors.black,
                                                                  //               fontSize: 12.0,
                                                                  //             ),
                                                                  //           )
                                                                  //         ],
                                                                  //         style: FlutterFlowTheme.of(context)
                                                                  //             .bodyMedium,
                                                                  //       ),
                                                                  //     ),
                                                                  //   ],
                                                                  // ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Builder(
                                                          builder: (context) {
                                                            final providerProduct = getJsonField(cartProviderItem, r'''$.goods''',).toList();
                                                            return ListView.builder(
                                                              padding: EdgeInsets.zero,
                                                              primary: false,
                                                              shrinkWrap: true,
                                                              scrollDirection: Axis.vertical,
                                                              itemCount: providerProduct.length,
                                                              itemBuilder: (context, providerProductIndex) {
                                                                final providerProductItem =
                                                                providerProduct[providerProductIndex];
                                                                return Padding(
                                                                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                                                                  child: Container(
                                                                    width: MediaQuery.sizeOf(context).width * 1.0,
                                                                    decoration: BoxDecoration(
                                                                      color: isDarkMode ? Colors.black : Colors.white,
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          blurRadius: 0.0,
                                                                          color: isDarkMode ? Colors.black87 : Color(0xFFE0E3E7),
                                                                          offset: Offset(0.0, 1.0),
                                                                        )
                                                                      ],
                                                                      borderRadius: BorderRadius.circular(7.0), border: Border.all(color: const Color(0x8D9D9D9D), width: 1.0,),
                                                                    ),
                                                                    child: Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 5.0, 5.0),
                                                                      child: Column(
                                                                        mainAxisSize: MainAxisSize.max,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 12.0),
                                                                            child: InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                                                                  return ProductPageWidget(id: int.tryParse(serializeParam(getJsonField(providerProductIndex, r'''$.productId''',), ParamType.int) ?? '0'));
                                                                                }));

                                                                              },
                                                                              child:
                                                                              Row(
                                                                                mainAxisSize:
                                                                                MainAxisSize.max,
                                                                                mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Stack(
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: const EdgeInsetsDirectional.fromSTEB(8.0, 5.0, 1.0, 1.0),
                                                                                        child: Image.network(
                                                                                          valueOrDefault<String>(
                                                                                            getJsonField(
                                                                                              providerProductItem,
                                                                                              r'''$.productImage''',
                                                                                            )?.toString(),
                                                                                            'https://saudaline.kz/images/logo.png',
                                                                                          ),
                                                                                          width: 70.0,
                                                                                          height: 70.0,
                                                                                          fit: BoxFit.fitWidth,
                                                                                        ),
                                                                                      ),
                                                                                      if (getJsonField(
                                                                                        providerProductItem,
                                                                                        r'''$.productDiscount''',
                                                                                      ) ==
                                                                                          null
                                                                                          ? false
                                                                                          : true)
                                                                                        Container(
                                                                                          width: 40.0,
                                                                                          height: 20.0,
                                                                                          decoration: BoxDecoration(
                                                                                            color: const Color(0xFFFF0000),
                                                                                            borderRadius: BorderRadius.circular(20.0),
                                                                                          ),
                                                                                          alignment: const AlignmentDirectional(0.0, 0.0),
                                                                                          child: RichText(
                                                                                            textScaleFactor: MediaQuery.of(context).textScaleFactor,
                                                                                            text: TextSpan(
                                                                                              children: [
                                                                                                TextSpan(
                                                                                                  text: getJsonField(
                                                                                                    providerProductItem,
                                                                                                    r'''$.productDiscount''',
                                                                                                  ).toString(),
                                                                                                  style: const TextStyle(),
                                                                                                ),
                                                                                                const TextSpan(
                                                                                                  text: '%',
                                                                                                  style: TextStyle(),
                                                                                                )
                                                                                              ],
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Readex Pro',
                                                                                                color: Colors.white,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                    ],
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                    child: Column(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 210.0,
                                                                                          child: AutoSizeText(
                                                                                            getJsonField(
                                                                                              providerProductItem,
                                                                                              r'''$.productName''',
                                                                                            ).toString().maybeHandleOverflow(
                                                                                              maxChars: 15,
                                                                                              replacement: '…',
                                                                                            ),
                                                                                            maxLines: 2,
                                                                                            style: TextStyle(
                                                                                              fontFamily: 'Gilroy',
                                                                                              color: isDarkMode ? Colors.white : Color(0xFF14181B),
                                                                                              fontSize: 14.0,
                                                                                              fontWeight: FontWeight.w500,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                                                          children: [
                                                                                            Text(
                                                                                              getJsonField(
                                                                                                providerProductItem,
                                                                                                r'''$.quantity''',
                                                                                              ).toString(),
                                                                                              textAlign: TextAlign.end,
                                                                                              style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                                fontFamily: 'Outfit',
                                                                                                color: isDarkMode ? Colors.white : Color(0xFF14181B),
                                                                                                fontSize: 14.0,
                                                                                                fontWeight: FontWeight.w500,
                                                                                              ),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(3.0, 0.0, 0.0, 0.0),
                                                                                              child: Text(
                                                                                                'шт',
                                                                                                textAlign: TextAlign.end,
                                                                                                style: TextStyle(
                                                                                                  fontFamily: 'Gilroy',
                                                                                                  color: isDarkMode ? Colors.white : Color(0xFF14181B),
                                                                                                  fontSize: 12.0,
                                                                                                  fontWeight: FontWeight.w500,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                                                          children: [
                                                                                            if (getJsonField(providerProductItem, r'''$.productDiscount''',) == null ? false : true)
                                                                                              Text(
                                                                                                getJsonField(providerProductItem, r'''$.productSum''',).toString(),
                                                                                                textAlign: TextAlign.end,
                                                                                                style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                                  fontFamily: 'Outfit',
                                                                                                  color: isDarkMode ? Colors.white : Color(0xFF14181B),
                                                                                                  fontSize: 12.0,
                                                                                                  fontWeight: FontWeight.w500,
                                                                                                  decoration: TextDecoration.lineThrough,
                                                                                                ),
                                                                                              ),
                                                                                            Padding(
                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                              child: Text(
                                                                                                getJsonField(providerProductItem, r'''$.productSumWithDiscount''',).toString(),
                                                                                                textAlign: TextAlign.end,
                                                                                                style: TextStyle(
                                                                                                  fontFamily: 'Gilroy',
                                                                                                  color: isDarkMode ? Colors.white : Color(0xFF14181B),
                                                                                                  fontSize: 13.0,
                                                                                                  fontWeight: FontWeight.w500,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(3.0, 0.0, 0.0, 0.0),
                                                                                              child: Text(
                                                                                                '₸',
                                                                                                textAlign: TextAlign.end,
                                                                                                style: TextStyle(
                                                                                                  fontFamily: 'Outfit',
                                                                                                  color: isDarkMode ? Colors.white : Color(0xFF14181B),
                                                                                                  fontSize: 12.0,
                                                                                                  fontWeight: FontWeight.w500,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Row(
                                                                            mainAxisSize:
                                                                            MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              RichText(
                                                                                textScaleFactor: MediaQuery.of(context).textScaleFactor,
                                                                                text: TextSpan(
                                                                                  children: [
                                                                                    TextSpan(
                                                                                      text: formatNumber(
                                                                                        getJsonField(providerProductItem, r'''$.quantity''',) * getJsonField(providerProductItem, r'''$.productSumWithDiscount''',),
                                                                                        formatType: FormatType.decimal,
                                                                                        decimalType: DecimalType.commaDecimal,
                                                                                      ),
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Gilroy',
                                                                                        color: isDarkMode ? Colors.white : Color(0xFFFCA522),
                                                                                        fontSize: 18.0,
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                    ),
                                                                                    TextSpan(
                                                                                      text: ' ₸',
                                                                                      style: TextStyle(
                                                                                        color: isDarkMode ? Colors.white : Color(0xFFFCA522),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  SizedBox(
                                                                                    width: 180,
                                                                                    child: CounterBasketWidget(
                                                                                      key: Key('Keyo2r_${providerProductIndex}_of_${providerProduct.length}'),
                                                                                      providerId: getJsonField(cartProviderItem, r'''$.providerId''',),
                                                                                      providerName: getJsonField(cartProviderItem, r'''$.providerName''',).toString(),
                                                                                      providerLogotype: getJsonField(cartProviderItem, r'''$.providerImage''',).toString(),
                                                                                      product: providerProductItem,
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                                                                                    child: InkWell(
                                                                                      splashColor: Colors.transparent,
                                                                                      focusColor: Colors.transparent,
                                                                                      hoverColor: Colors.transparent,
                                                                                      highlightColor: Colors.transparent,
                                                                                      onTap: () async {
                                                                                        setState(() {
                                                                                          FFAppState().basketProducts = functions.deleteFromBasket(getJsonField(cartProviderItem, r'''$.providerId''',), getJsonField(providerProductItem, r'''$.productId''',), FFAppState().basketProducts.toList())!.toList().cast<dynamic>();
                                                                                          FFAppState().removeFromCardProducts(getJsonField(providerProductItem, r'''$.productId''',));
                                                                                        });
                                                                                      },
                                                                                      child: Icon(
                                                                                        Icons.delete_outline,
                                                                                        color: isDarkMode ? Colors.white : const Color(0xFFFF5963),
                                                                                        size: 24.0,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
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
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 12.0, 0.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Итог заказа',
                                                style: TextStyle(
                                                  fontFamily: 'Atyp',
                                                  color: isDarkMode ? Colors.white : Color(0xFF14181B),
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const Divider(
                                                height: 32.0,
                                                thickness: 2.0,
                                                color: Color(0xFFE0E3E7),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 8.0),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Кол. товаров:',
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .bodySmall
                                                                .override(
                                                              fontFamily:
                                                              'Outfit',
                                                              color: const Color(
                                                                  0xFF57636C),
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                              FontWeight
                                                                  .normal,
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            children: [
                                                              Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  functions.getTotalQuantity(
                                                                      FFAppState()
                                                                          .basketProducts
                                                                          .toList()),
                                                                  '0',
                                                                ),
                                                                textAlign:
                                                                TextAlign.end,
                                                                style: TextStyle(
                                                                  fontFamily: 'Plus Jakarta Sans',
                                                                  color: isDarkMode ? Colors.white : Color(0xFF14181B),
                                                                  fontSize: 16.0,
                                                                  fontWeight:
                                                                  FontWeight.normal,
                                                                ),
                                                              ),
                                                              Text(
                                                                ' шт',
                                                                textAlign:
                                                                TextAlign.end,
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                  'Plus Jakarta Sans',
                                                                  color: isDarkMode ? Colors.white : Color(0xFF14181B),
                                                                  fontSize:
                                                                  16.0,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 0.0, 0.0, 8.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Сумма:',
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .bodySmall
                                                                .override(
                                                              fontFamily:
                                                              'Outfit',
                                                              color: const Color(
                                                                  0xFF57636C),
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                              FontWeight
                                                                  .normal,
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            children: [
                                                              Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  functions.getTotalSum(
                                                                      FFAppState()
                                                                          .basketProducts
                                                                          .toList()),
                                                                  '0',
                                                                ),
                                                                textAlign:
                                                                TextAlign.end,
                                                                style: FlutterFlowTheme
                                                                    .of(context)
                                                                    .bodyLarge
                                                                    .override(
                                                                  fontFamily:
                                                                  'Plus Jakarta Sans',
                                                                  color: isDarkMode ? Colors.white : Color(0xFF14181B),
                                                                  fontSize:
                                                                  16.0,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                                ),
                                                              ),
                                                              Text(
                                                                '  ₸',
                                                                textAlign:
                                                                TextAlign.end,
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                  'Plus Jakarta Sans',
                                                                  color: isDarkMode ? Colors.white : Color(0xFF14181B),
                                                                  fontSize:
                                                                  16.0,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 0.0, 0.0, 8.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Cкидка от поставщиков:',
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .bodySmall
                                                                .override(
                                                              fontFamily:
                                                              'Outfit',
                                                              color: const Color(
                                                                  0xFF57636C),
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                              FontWeight
                                                                  .normal,
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            children: [
                                                              Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  functions.getTotalDiscount(
                                                                      FFAppState()
                                                                          .basketProducts
                                                                          .toList()),
                                                                  '0',
                                                                ),
                                                                textAlign:
                                                                TextAlign.end,
                                                                style: FlutterFlowTheme
                                                                    .of(context)
                                                                    .bodyLarge
                                                                    .override(
                                                                  fontFamily:
                                                                  'Plus Jakarta Sans',
                                                                  color: isDarkMode ? Colors.white : Color(0xFF14181B),
                                                                  fontSize:
                                                                  16.0,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 0.0, 0.0, 8.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Cкидка от SaudaLine(1%):',
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .bodySmall
                                                                .override(
                                                              fontFamily:
                                                              'Outfit',
                                                              color: const Color(
                                                                  0xFF57636C),
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                              FontWeight
                                                                  .normal,
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            children: [
                                                              Text(
                                                                '- ',
                                                                textAlign:
                                                                TextAlign.end,
                                                                style: FlutterFlowTheme
                                                                    .of(context)
                                                                    .bodyLarge
                                                                    .override(
                                                                  fontFamily:
                                                                  'Plus Jakarta Sans',
                                                                  color: const Color(
                                                                      0xFF14181B),
                                                                  fontSize:
                                                                  16.0,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                                ),
                                                              ),
                                                              Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  functions.getSaudaLineDiscount(
                                                                      FFAppState()
                                                                          .basketProducts
                                                                          .toList()),
                                                                  '0',
                                                                ),
                                                                textAlign:
                                                                TextAlign.end,
                                                                style: FlutterFlowTheme
                                                                    .of(context)
                                                                    .bodyLarge
                                                                    .override(
                                                                  fontFamily:
                                                                  'Plus Jakarta Sans',
                                                                  color: isDarkMode ? Colors.white : Color(0xFF14181B),
                                                                  fontSize:
                                                                  16.0,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                                ),
                                                              ),
                                                              Text(
                                                                '  ₸',
                                                                textAlign:
                                                                TextAlign.end,
                                                                style: TextStyle(
                                                                  fontFamily: 'Plus Jakarta Sans',
                                                                  color: isDarkMode ? Colors.white : Color(0xFF14181B),
                                                                  fontSize:
                                                                  16.0,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 8.0, 0.0, 8.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            children: [
                                                              Text(
                                                                'Итого:',
                                                                style: FlutterFlowTheme
                                                                    .of(context)
                                                                    .titleMedium
                                                                    .override(
                                                                  fontFamily:
                                                                  'Outfit',
                                                                  color: const Color(
                                                                      0xFF57636C),
                                                                  fontSize:
                                                                  20.0,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                ),
                                                              ),
                                                              FlutterFlowIconButton(
                                                                borderColor: Colors
                                                                    .transparent,
                                                                borderRadius: 30.0,
                                                                borderWidth: 1.0,
                                                                buttonSize: 36.0,
                                                                icon: Icon(
                                                                  Icons.info_outlined,
                                                                  color: isDarkMode ? Colors.white : Color(0xFF57636C),
                                                                  size: 18.0,
                                                                ),
                                                                onPressed: () {
                                                                  print('IconButton pressed ...');
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            children: [
                                                              Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  functions.getTotalSumWithDiscount(
                                                                      FFAppState()
                                                                          .basketProducts
                                                                          .toList()),
                                                                  '0',
                                                                ),
                                                                style: FlutterFlowTheme
                                                                    .of(context)
                                                                    .displaySmall
                                                                    .override(
                                                                  fontFamily:
                                                                  'Outfit',
                                                                  color: isDarkMode ? Colors.white : Color(0xFF14181B),
                                                                  fontSize:
                                                                  36.0,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                ),
                                                              ),
                                                              Text(
                                                                '  ₸',
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                  'Outfit',
                                                                  color: isDarkMode ? Colors.white : Color(0xFF14181B),
                                                                  fontSize:
                                                                  36.0,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (functions.appStateToPrint(FFAppState().cardProducts.toList()) != '[]' ? true : false)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  _model.apiResult0no = await LoginAndRegistrationGroup.checkTokenCall.call(jwtToken: FFAppState().jwttoken,);
                                  if ((_model.apiResult0no?.succeeded ?? true)) {

                                    setState(() {
                                      FFAppState().isLogged = true;
                                      FFAppState().jwttoken = FFAppState().jwttoken;
                                    });

                                    _model.apiResultn3p = await LoginAndRegistrationGroup.getUserInfoCall.call(jwtToken: FFAppState().jwttoken,);

                                    if ((_model.apiResultn3p?.succeeded ?? true)) {

                                      setState(() {
                                        FFAppState().accountInfo = (_model.apiResultn3p?.jsonBody ?? '');
                                      });

                                    } else {

                                      setState(() {
                                        FFAppState().accountInfo = null;
                                      });

                                    }

                                    // context.pushNamed('ConfirmationOrder');
                                    // pushNewScreen(context, screen: const ConfirmationOrderWidget());

                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                      return const ConfirmationOrderWidget();
                                    }));

                                  } else {

                                    setState(() {
                                      FFAppState().isLogged = false;
                                      FFAppState().jwttoken = '';
                                    });

                                    // context.pushNamed('Profile');
                                    // pushNewScreen(context, screen: const ProfileWidget());

                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                      return const LoginWidget(currentPageName: "cart",);
                                    }));

                                  }

                                  setState(() {});
                                },
                                text: 'Оформить заказ',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 50.0,
                                  padding: const EdgeInsets.all(0.0),
                                  iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                  color: const Color(0xFFEF9939),
                                  textStyle: const TextStyle(
                                    fontFamily: 'Gilroy',
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  elevation: 2.0,
                                  borderRadius: BorderRadius.circular(50.0),
                                  hoverColor: const Color(0x4CEFA039),
                                  hoverTextColor: const Color(0xFFEF8739),
                                ),
                              ),
                            ),
                          if (!(functions.appStateToPrint(FFAppState().cardProducts.toList()) == '[]' ? false : true))
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 16.0),
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height / 1.3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Ваша корзина для покупок пуста',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy',
                                            color: isDarkMode ? Colors.white : Colors.black,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
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
              }),
            if (FFAppState().isProvider)
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 0.0),
                child: Text(
                  'Вы не можете использовать корзину, поскольку вы вошли в систему как поставщик.',
                  style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: isDarkMode ? Colors.white : Colors.black
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
