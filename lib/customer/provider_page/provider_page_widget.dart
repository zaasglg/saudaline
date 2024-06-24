import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sauda_line/customer/product_page/product_page_widget.dart';
import 'package:sauda_line/customer/products_by_categories/products_by_categories_widget.dart';
import 'package:sauda_line/customer/provider_categories/provider_categories_widget.dart';
import 'package:sauda_line/home_page/home_page_widget.dart';
import 'package:sauda_line/main.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'provider_page_model.dart';
export 'provider_page_model.dart';
import '/flutter_flow/custom_functions.dart' as functions;

class ProviderPageWidget extends StatefulWidget {
  const ProviderPageWidget({
    super.key,
    required this.providerId,
  });

  final int? providerId;

  @override
  State<ProviderPageWidget> createState() => _ProviderPageWidgetState();
}

class _ProviderPageWidgetState extends State<ProviderPageWidget> {
  late ProviderPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProviderPageModel());
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

    return FutureBuilder<ApiCallResponse>(
      future: ProviderAPiGroup.providerByIdCall.call(
        providerId: widget.providerId,
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
        final providerPageProviderByIdResponse = snapshot.data!;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 0.0),
                      child: FutureBuilder<ApiCallResponse>(
                        future: ProviderAPiGroup.providerByIdCall.call(
                          providerId: widget.providerId,
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
                          final containerProviderByIdResponse = snapshot.data!;
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: isDarkMode ? Colors.black : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 3.0,
                                  color: Color(0x33000000),
                                  offset: Offset(0.0, 1.0),
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 90.0,
                                    height: 90.0,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(5.0),

                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50.0),
                                        child: CachedNetworkImage(
                                          fadeInDuration: const Duration(milliseconds: 500),
                                          fadeOutDuration: const Duration(milliseconds: 500),
                                          imageUrl: valueOrDefault<String>(ProviderAPiGroup.providerByIdCall.logotype(containerProviderByIdResponse.jsonBody,), 'https://saudaline.kz/images/logo.png',),
                                          width: 60.0,
                                          height: 60.0,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Поставщик',
                                          style: TextStyle(fontFamily: 'Gilroy',
                                            color: isDarkMode ? Colors.white54 : Color(0xFF14181B),
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        AutoSizeText(
                                          ProviderAPiGroup.providerByIdCall.name(containerProviderByIdResponse.jsonBody,)!.maybeHandleOverflow(
                                            maxChars: 20,
                                            replacement: '…',
                                          ),
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontFamily: 'Futura',
                                            color: isDarkMode ? CupertinoColors.white : CupertinoColors.label,
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                              child: Text('Тел:', style: TextStyle(
                                                  fontFamily: 'Gilroy',
                                                  color: Color(0xFF57636C),
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(5.0, 4.0, 0.0, 0.0),
                                              child: Text(
                                                ProviderAPiGroup.providerByIdCall.phone(containerProviderByIdResponse.jsonBody,)!,
                                                style: const TextStyle(
                                                  fontFamily: 'Gilroy',
                                                  color: Color(0xFF57636C),
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.normal,
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
                          );
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 130.0,
                      decoration: const BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 16.0, 16.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Продукция поставщика',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {

                                    // pushNewScreen(context, screen: ProviderCategoriesWidget(
                                    //   providerName: serializeParam(ProviderAPiGroup.providerByIdCall.name(providerPageProviderByIdResponse.jsonBody,),ParamType.String,),
                                    //   providerId: int.tryParse(serializeParam(widget.providerId, ParamType.int,) ?? '0'),
                                    // ));

                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                      return ProviderCategoriesWidget(
                                        providerName: serializeParam(ProviderAPiGroup.providerByIdCall.name(providerPageProviderByIdResponse.jsonBody,),ParamType.String,),
                                        providerId: int.tryParse(serializeParam(widget.providerId, ParamType.int,) ?? '0'),
                                      );
                                    }));

                                    // context.pushNamed(
                                    //   'ProviderCategories',
                                    //   queryParameters: {
                                    //     'providerName': serializeParam(ProviderAPiGroup.providerByIdCall.name(providerPageProviderByIdResponse.jsonBody,),ParamType.String,),
                                    //     'providerId': serializeParam(widget.providerId, ParamType.int,),
                                    //   }.withoutNulls,
                                    // );
                                  },
                                  child: const Text(
                                    'Все',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      color: Color(0xFF0E5E99),
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w700
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                child: FutureBuilder<ApiCallResponse>(
                                  future: ProviderAPiGroup.providerCategoriesCall.call(providerId: widget.providerId,),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 50.0,
                                          height: 50.0,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    final gridViewProviderCategoriesResponse = snapshot.data!;
                                    return Builder(
                                      builder: (context) {
                                        final category = getJsonField(gridViewProviderCategoriesResponse.jsonBody, r'''$''',).toList().take(9).toList();
                                        return SingleChildScrollView(
                                          child: Wrap(
                                            spacing: 8.0,
                                            alignment: WrapAlignment.start,
                                            children: category.map<Widget>((item) {
                                              return ActionChip(
                                                label: Text(item['title']),
                                                onPressed: () {
                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                                    return ProductsByCategoriesWidget(
                                                      categoryName: item['title'],
                                                      categoryId: item['id'],
                                                    );
                                                  }));
                                                },
                                              );
                                            }).toList(),
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
                    const SizedBox(
                      child: Divider(
                        thickness: 0.5,
                        color: Color(0xFFB3B0B0),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 5.0, 16.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Товары поставщика',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (false)
                                  Text(
                                    'Все',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Readex Pro',
                                      color: const Color(0xFF0E5E99),
                                      fontSize: 16.0,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 50.0),
                      child: FutureBuilder<ApiCallResponse>(
                        future: (_model.apiRequestCompleter ??= Completer<
                            ApiCallResponse>()
                          ..complete(
                              ProviderAPiGroup.providerProductsCall.call(
                                providerId: widget.providerId,
                              )))
                            .future,
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
                          final gridViewProviderProductsResponse = snapshot.data!;
                          return Builder(
                            builder: (context) {
                              final product = getJsonField(
                                gridViewProviderProductsResponse.jsonBody,
                                r'''$''',
                              ).toList();
                              return RefreshIndicator(
                                onRefresh: () async {
                                  setState(() => _model.apiRequestCompleter = null);
                                  await _model.waitForApiRequestCompleted();
                                },
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: product.length,
                                  itemBuilder: (context, productIndex) {
                                    final productItem = product[productIndex];
                                    return InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                          return ProductPageWidget(
                                            id: int.tryParse(serializeParam(getJsonField(productItem, r'''$.id''',), ParamType.int,) ?? '0'),
                                          );
                                        }));

                                        if (!FFAppState().lastViewed.containsMap(getJsonField(productItem, r'''$'''))) {
                                          setState(() {
                                            FFAppState().addToLastViewed(getJsonField(productItem, r'''$''',));
                                          });
                                        }

                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1,
                                              color: Colors.black12
                                            )
                                          )
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 100,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  valueOrDefault<String>(
                                                    getJsonField(
                                                      productItem,
                                                      r'''$.mainPhoto.url''',
                                                    )?.toString(),
                                                    'https://saudaline.kz/images/logo.png',
                                                  ),
                                                  width: 100.0,
                                                  height: 100.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),

                                            SizedBox(width: 20.0,),

                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  getJsonField(productItem, r'''$.title''',).toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "Futura",
                                                      fontSize: 17,
                                                  ),
                                                ),
                                                Text(
                                                  getJsonField(productItem, r'''$.category.title''',).toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: "Futura"
                                                  ),
                                                ),

                                                SizedBox(height: 10.0,),

                                                Container(
                                                  width: MediaQuery.of(context).size.width / 2,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("${getJsonField(
                                                        productItem,
                                                        r'''$.discountprice''',
                                                      )} ₸", style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight: FontWeight.w600,
                                                        fontFamily: "Futura"
                                                      ),),

                                                      if (!FFAppState().isProvider) ...[
                                                        ElevatedButton(onPressed: () {
                                                          setState(() {
                                                            print(productItem);
                                                            FFAppState().addToCardProducts(productItem['id']);
                                                            FFAppState().addToCardProviders(productItem["category"]["provider"]["id"]);
                                                            FFAppState().basketProducts =
                                                                functions
                                                                    .generatJsonProduct(productItem['id'], 1, FFAppState().basketProducts.toList(),
                                                                    productItem["category"]["provider"]["id"],
                                                                    productItem["category"]["provider"]["name"],
                                                                    GetProductByIdCall.providerLogo(productItem,),
                                                                    GetProductByIdCall.price(productItem,),
                                                                    GetProductByIdCall.productImage(productItem,),
                                                                    GetProductByIdCall.productName(productItem,),
                                                                    valueOrDefault<int>(GetProductByIdCall.discount(productItem,), 0,))!
                                                                    .toList()
                                                                    .cast<dynamic>();
                                                          });

                                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                                            return NavBarPage(currentPageName: "cart",);
                                                          }));
                                                        }, child: Text('В корзину'), style: ElevatedButton.styleFrom(
                                                            backgroundColor: Color(0xffE8751A)
                                                        ),),
                                                      ]

                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
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
      },
    );
  }
}
