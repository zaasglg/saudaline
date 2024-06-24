import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sauda_line/customer/product_page/product_page_widget.dart';

import '../../main.dart';
import '/backend/api_requests/api_calls.dart';
import '/customer/counter/counter_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'products_by_categories_model.dart';
export 'products_by_categories_model.dart';

class ProductsByCategoriesWidget extends StatefulWidget {
  const ProductsByCategoriesWidget({
    super.key,
    String? categoryName,
    int? categoryId,
  })  : this.categoryName = categoryName ?? '0',
        this.categoryId = categoryId ?? 1;

  final String categoryName;
  final int categoryId;

  @override
  State<ProductsByCategoriesWidget> createState() =>
      _ProductsByCategoriesWidgetState();
}

class _ProductsByCategoriesWidgetState
    extends State<ProductsByCategoriesWidget> {
  late ProductsByCategoriesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProductsByCategoriesModel());
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
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          title: RichText(
            textScaleFactor: MediaQuery.of(context).textScaleFactor,
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Товары по категории ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: widget.categoryName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                )
              ],
              style: FlutterFlowTheme.of(context).bodyMedium,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                child: FutureBuilder<ApiCallResponse>(
                  future: ProductGroup.productsByCategoryCall.call(
                    categoryId: widget.categoryId,
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
                    final listViewProductsByCategoryResponse = snapshot.data!;
                    return Builder(
                      builder: (context) {
                        final product = ProductGroup.productsByCategoryCall
                                .productsList(
                                  listViewProductsByCategoryResponse.jsonBody,
                                )
                                ?.toList() ??
                            [];
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: product.length,
                          itemBuilder: (context, productIndex) {
                            final productItem = product[productIndex];
                            return Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 8.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  boxShadow: [
                                    const BoxShadow(
                                      blurRadius: 3.0,
                                      color: Color(0x411D2429),
                                      offset: Offset(0.0, 1.0),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Stack(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 1.0, 1.0, 1.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {

                                                pushNewScreen(context, screen: ProductPageWidget(
                                                  id: int.tryParse(serializeParam(getJsonField(productItem, r'''$.id''',), ParamType.int,) ?? '0'),
                                                ));

                                                // context.pushNamed(
                                                //   'ProductPage',
                                                //   queryParameters: {
                                                //     'id': ,
                                                //   }.withoutNulls,
                                                // );
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                child: Image.network(
                                                  valueOrDefault<String>(
                                                    getJsonField(
                                                      productItem,
                                                      r'''$.mainPhoto.url''',
                                                    )?.toString(),
                                                    'https://saudaline.kz/images/logo.png',
                                                  ),
                                                  width: 80.0,
                                                  height: 80.0,
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (getJsonField(
                                                productItem,
                                                r'''$.discount''',
                                              ) !=
                                              null)
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 10.0, 0.0, 0.0),
                                              child: Container(
                                                width: 40.0,
                                                height: 20.0,
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFFCF1212),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40.0),
                                                ),
                                                alignment: const AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      getJsonField(
                                                        productItem,
                                                        r'''$.discount''',
                                                      ).toString(),
                                                      style: FlutterFlowTheme
                                                              .of(context)
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
                                                      style: FlutterFlowTheme
                                                              .of(context)
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
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 8.0, 4.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 240.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                ),
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

                                                    pushNewScreen(context, screen: ProductPageWidget(
                                                      id: int.tryParse(serializeParam(getJsonField(productItem, r'''$.id''',), ParamType.int,) ?? '0'),
                                                    ));

                                                    // context.pushNamed(
                                                    //   'ProductPage',
                                                    //   queryParameters: {
                                                    //     'id': ,
                                                    //   }.withoutNulls,
                                                    // );
                                                  },
                                                  child: AutoSizeText(
                                                    getJsonField(
                                                      productItem,
                                                      r'''$.title''',
                                                    ).toString(),
                                                    maxLines: 2,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .headlineSmall
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          fontSize: 18.0,
                                                        ),
                                                    minFontSize: 14.0,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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

                                                      pushNewScreen(context, screen: ProductPageWidget(
                                                          id: int.tryParse(serializeParam(getJsonField(productItem, r'''$.id''',), ParamType.int,) ?? '0')
                                                      ));

                                                      // context.pushNamed(
                                                      //   'ProductPage',
                                                      //   queryParameters: {
                                                      //     'id': ,
                                                      //   }.withoutNulls,
                                                      // );
                                                    },
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        if (getJsonField(
                                                              productItem,
                                                              r'''$.discount''',
                                                            ) !=
                                                            null)
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        4.0,
                                                                        8.0,
                                                                        0.0),
                                                            child: AutoSizeText(
                                                              '${getJsonField(
                                                                productItem,
                                                                r'''$.price''',
                                                              ).toString()} т'
                                                                  .maybeHandleOverflow(
                                                                maxChars: 70,
                                                                replacement:
                                                                    '…',
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough,
                                                                  ),
                                                            ),
                                                          ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      4.0,
                                                                      8.0,
                                                                      0.0),
                                                          child: AutoSizeText(
                                                            '${productItem.toString()}'
                                                                .maybeHandleOverflow(
                                                              maxChars: 70,
                                                              replacement: '…',
                                                            ),
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .labelMedium,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      4.0,
                                                                      8.0,
                                                                      0.0),
                                                          child: AutoSizeText(
                                                            '${getJsonField(
                                                              productItem,
                                                              r'''$.discountprice''',
                                                            ).toString()} т'
                                                                .maybeHandleOverflow(
                                                              maxChars: 70,
                                                              replacement: '…',
                                                            ),
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: const Color(
                                                                      0xFFFCA522),
                                                                  fontSize:
                                                                      16.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  if (!FFAppState().isProvider)
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Stack(
                                                          children: [
                                                            if (!FFAppState()
                                                                .cardProducts
                                                                .contains(
                                                                    getJsonField(
                                                                  productItem,
                                                                  r'''$.id''',
                                                                )))
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            5.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    if (FFAppState()
                                                                        .cardProducts
                                                                        .contains(
                                                                            getJsonField(
                                                                          productItem,
                                                                          r'''$.id''',
                                                                        ))) {
                                                                      await showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (alertDialogContext) {
                                                                          return WebViewAware(
                                                                            child:
                                                                                AlertDialog(
                                                                              title: const Text('Уже есть в корзине'),
                                                                              actions: [
                                                                                TextButton(
                                                                                  onPressed: () => Navigator.pop(alertDialogContext),
                                                                                  child: const Text('Ok'),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                    } else {
                                                                      setState(
                                                                          () {
                                                                        FFAppState()
                                                                            .addToCardProducts(getJsonField(
                                                                          productItem,
                                                                          r'''$.id''',
                                                                        ));
                                                                        FFAppState()
                                                                            .addToCardProviders(getJsonField(
                                                                          productItem,
                                                                          r'''$.provider.id''',
                                                                        ));
                                                                        FFAppState().basketProducts = functions
                                                                            .generatJsonProduct(
                                                                                getJsonField(
                                                                                  productItem,
                                                                                  r'''$.id''',
                                                                                ),
                                                                                1,
                                                                                FFAppState().basketProducts.toList(),
                                                                                getJsonField(
                                                                                  productItem,
                                                                                  r'''$.provider.id''',
                                                                                ),
                                                                                getJsonField(
                                                                                  productItem,
                                                                                  r'''$.provider.name''',
                                                                                ).toString(),
                                                                                getJsonField(
                                                                                  productItem,
                                                                                  r'''$.provider.logotype[:1].url''',
                                                                                ).toString(),
                                                                                getJsonField(
                                                                                  productItem,
                                                                                  r'''$.price''',
                                                                                ),
                                                                                getJsonField(
                                                                                  productItem,
                                                                                  r'''$.mainPhoto.url''',
                                                                                ).toString(),
                                                                                getJsonField(
                                                                                  productItem,
                                                                                  r'''$.title''',
                                                                                ).toString(),
                                                                                valueOrDefault<int>(
                                                                                  getJsonField(
                                                                                    productItem,
                                                                                    r'''$.discount''',
                                                                                  ),
                                                                                  0,
                                                                                ))!
                                                                            .toList()
                                                                            .cast<dynamic>();
                                                                      });
                                                                    }
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: 35.0,
                                                                    height:
                                                                        35.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5.0),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: const Color(
                                                                            0xFFA7A7A7),
                                                                      ),
                                                                    ),
                                                                    child: const Icon(
                                                                      Icons.add,
                                                                      color: Color(
                                                                          0xFFA7A7A7),
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            if (FFAppState()
                                                                .cardProducts
                                                                .contains(
                                                                    getJsonField(
                                                                  productItem,
                                                                  r'''$.id''',
                                                                )))
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            5.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    setState(
                                                                        () {
                                                                      FFAppState()
                                                                          .removeFromCardProducts(
                                                                              getJsonField(
                                                                        productItem,
                                                                        r'''$.id''',
                                                                      ));
                                                                      FFAppState().basketProducts = functions
                                                                          .deleteFromBasket(
                                                                              getJsonField(
                                                                                productItem,
                                                                                r'''$.provider.id''',
                                                                              ),
                                                                              getJsonField(
                                                                                productItem,
                                                                                r'''$.id''',
                                                                              ),
                                                                              FFAppState().basketProducts.toList())!
                                                                          .toList()
                                                                          .cast<dynamic>();
                                                                    });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: 35.0,
                                                                    height:
                                                                        35.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5.0),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: const Color(
                                                                            0xFFC90C0C),
                                                                      ),
                                                                    ),
                                                                    child: const Icon(
                                                                      Icons
                                                                          .delete_outline,
                                                                      color: Color(
                                                                          0xFFC90C0C),
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                        if (FFAppState()
                                                            .cardProducts
                                                            .contains(
                                                                getJsonField(
                                                              productItem,
                                                              r'''$.id''',
                                                            )))
                                                          CounterWidget(
                                                            key: Key(
                                                                'Keyl5r_${productIndex}_of_${product.length}'),
                                                            product:
                                                                productItem,
                                                          ),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            ],
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
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
