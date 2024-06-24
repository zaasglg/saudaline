import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:sauda_line/customer/product_page/product_page_widget.dart';
import 'package:sauda_line/index.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'providers_products_model.dart';
export 'providers_products_model.dart';
import 'package:http/http.dart' as http;

class ProvidersProductsWidget extends StatefulWidget {
  const ProvidersProductsWidget({super.key});

  @override
  State<ProvidersProductsWidget> createState() =>
      _ProvidersProductsWidgetState();
}

class _ProvidersProductsWidgetState extends State<ProvidersProductsWidget> {
  late ProvidersProductsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  int? selectedCityId;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProvidersProductsModel());

    _model.textController ??= TextEditingController();
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
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          title: const Text("Товары", style: TextStyle(
            color: Colors.black,
            fontFamily: "Gilroy"
          ),),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
              child: CupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 0),
                color: CupertinoColors.activeOrange,
                borderRadius: BorderRadius.circular(50.0),
                onPressed: () async {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return const ProductAddPageWidget();
                  }));
                },
                child: const Row(
                  children: [
                    Icon(CupertinoIcons.plus_circle_fill, color: Colors.white,),
                    SizedBox(width: 5.0,),
                    Text('Добавить', style: TextStyle(fontFamily: 'Gilroy', color: Colors.white, fontWeight: FontWeight.w600),)
                  ],
                ),
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 10.0, 5.0),
              child: Container(
                width: double.infinity,
                height: 48.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextFormField(
                  controller: _model.textController,
                  focusNode: _model.textFieldFocusNode,
                  onChanged: (_) => EasyDebounce.debounce(
                    '_model.textController',
                    const Duration(milliseconds: 2000),
                    () async {
                      _model.apiResult3r9 = await ProductGroup.providersProductsCall.call(
                        jwtToken: FFAppState().jwttoken,
                        keyword: _model.textController.text,
                      );

                      setState(() {});
                    },
                  ),
                  obscureText: false,
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(fontFamily: 'Gilroy', fontSize: 18.0,),
                    hintText: 'Поиск товаров...',
                    hintStyle: const TextStyle(fontFamily: 'Gilroy', fontSize: 18.0,),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    prefixIcon: const Icon(
                      CupertinoIcons.search,
                      color: Color(0xFFFCA522),
                    ),
                    suffixIcon: _model.textController!.text.isNotEmpty
                        ? InkWell(
                            onTap: () async {
                              _model.textController?.clear();
                              _model.apiResult3r9 =
                                  await ProductGroup.providersProductsCall.call(
                                jwtToken: FFAppState().jwttoken,
                                keyword: _model.textController.text,
                              );

                              setState(() {});
                              setState(() {});
                            },
                            child: const Icon(Icons.clear, size: 20.0,),
                          )
                        : null,
                  ),
                  style: TextStyle(
                        fontFamily: 'Gilroy',
                        color: Theme.of(context).brightness == Brightness.dark
                            ? FlutterFlowTheme.of(context).primary
                            : Colors.black,
                        fontSize: 18.0,
                      ),
                  validator: _model.textControllerValidator.asValidator(context),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 50.0),
                child: FutureBuilder<ApiCallResponse>(
                  future: ProductGroup.providersProductsCall.call(
                    jwtToken: FFAppState().jwttoken,
                    keyword: _model.textController.text
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
                    final lsitViewProducts = snapshot.data!;

                    return Builder(
                      builder: (context) {
                        final products = ProductGroup.providersProductsCall.products(lsitViewProducts.jsonBody,)?.toList() ?? [];

                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: products.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, orderIndex) {
                            final productItem = products[orderIndex];
                            return Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 8.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  boxShadow: const [
                                    BoxShadow(
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
                                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 1.0, 1.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor: Colors.transparent,
                                              onTap: () async {

                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                                  return ProductPageWidget(id: getJsonField(
                                                    productItem,
                                                    r'''$.id''',
                                                  ));
                                                }));

                                              },
                                              child: SizedBox(
                                                width: 110,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(6.0),
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
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 4.0, 0.0),
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
                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                ),
                                                child: InkWell(
                                                  splashColor: Colors.transparent,
                                                  focusColor: Colors.transparent,
                                                  hoverColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  onTap: () async {

                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                                      return ProductPageWidget(id: getJsonField(
                                                        productItem,
                                                        r'''$.id''',
                                                      ));
                                                    }));
                                                  },
                                                  child: AutoSizeText(
                                                    getJsonField(
                                                      productItem,
                                                      r'''$.title''',
                                                    ).toString(),
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                        fontFamily: 'Futura',
                                                        fontSize: 20.0,
                                                        fontWeight: FontWeight.w700
                                                    ),
                                                    minFontSize: 14.0,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    splashColor: Colors.transparent,
                                                    focusColor: Colors.transparent,
                                                    hoverColor: Colors.transparent,
                                                    highlightColor:
                                                    Colors.transparent,
                                                    onTap: () async {
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                                        return ProductPageWidget(id: getJsonField(
                                                          productItem,
                                                          r'''$.id''',
                                                        ));
                                                      }));
                                                    },
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        if (getJsonField(
                                                          productItem,
                                                          r'''$.discount''',
                                                        ) !=
                                                            null)
                                                          Padding(padding: const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 8.0, 0.0),
                                                            child: AutoSizeText(
                                                              getJsonField(productItem, r'''$.category.title''',)
                                                                  .toString()
                                                                  .maybeHandleOverflow(
                                                                maxChars: 10,
                                                                replacement: '…',
                                                              ),
                                                              textAlign: TextAlign.start,
                                                              style: const TextStyle(
                                                                  fontFamily: "Futura"
                                                              ),
                                                            ),
                                                          ),
                                                        Padding(
                                                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 8.0, 0.0),
                                                          child: AutoSizeText(
                                                            '${getJsonField(productItem, r'''$.price''',).toString()} тг'.maybeHandleOverflow(
                                                              maxChars: 70,
                                                              replacement: '…',
                                                            ),
                                                            textAlign:
                                                            TextAlign.start,
                                                            style: const TextStyle(
                                                              fontFamily: 'Atyp',
                                                              color: Color(0xFFFCA522),
                                                              fontSize: 16.0,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                        child: InkWell(
                                                          splashColor: Colors.transparent,
                                                          focusColor: Colors.transparent,
                                                          hoverColor: Colors.transparent,
                                                          highlightColor: Colors.transparent,
                                                          onTap: () async {
                                                            if (FFAppState()
                                                                .cardProducts
                                                                .contains(getJsonField(productItem, r'''$.id''',))) {
                                                              await showDialog(
                                                                context: context,
                                                                builder: (alertDialogContext) {
                                                                  return WebViewAware(
                                                                    child: AlertDialog(
                                                                      title: const Text('Уже есть в корзине'),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed: () =>
                                                                              Navigator.pop(alertDialogContext),
                                                                          child: const Text('Ok'),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            } else {
                                                              setState(() {
                                                                FFAppState()
                                                                    .addToCardProducts(
                                                                    getJsonField(
                                                                      productItem,
                                                                      r'''$.id''',
                                                                    ));
                                                                FFAppState()
                                                                    .addToCardProviders(
                                                                    getJsonField(
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
                                                          child: Container(
                                                            child: InkWell(
                                                              splashColor: Colors.transparent,
                                                              focusColor: Colors.transparent,
                                                              hoverColor: Colors.transparent,
                                                              highlightColor: Colors.transparent,
                                                              onTap: () async {
                                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                                                  return ProductEditPageWidget(productId: getJsonField(
                                                                    productItem,
                                                                    r'''$.id''',
                                                                  ));
                                                                }));
                                                              },
                                                              child: const Icon(
                                                                Icons.edit_outlined, size: 24.0,
                                                                color: CupertinoColors.systemGreen,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10.0,),
                                                      Padding(
                                                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 10.0, 0.0),
                                                        child: InkWell(
                                                          splashColor: Colors.transparent,
                                                          focusColor: Colors.transparent,
                                                          hoverColor: Colors.transparent,
                                                          highlightColor: Colors.transparent,
                                                          onTap: () async {

                                                            await showDialog(
                                                              context: context,
                                                              builder: (alertDialogContextDelte) {
                                                                return WebViewAware(
                                                                  child: AlertDialog(
                                                                    title: const Text('Вы хотите удалить?'),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed: () async {
                                                                          Navigator.pop(alertDialogContextDelte);
                                                                        },
                                                                        child: const Text('Отмена'),
                                                                      ),
                                                                      TextButton(
                                                                        onPressed: () async {

                                                                          _model.apiResultcp2 = await ProductGroup.deleteProductByIdCall.call(
                                                                            productId: getJsonField(
                                                                              productItem, r'''$.id''',
                                                                            ),
                                                                            jwtToken: FFAppState().jwttoken,
                                                                          );

                                                                          if ((_model.apiResultcp2?.succeeded ?? true)) {
                                                                              await showDialog(
                                                                                  context: context,
                                                                                  builder: (alertDialogContext) {
                                                                                return WebViewAware(
                                                                                  child: AlertDialog(
                                                                                    title: const Text('Удалено успешно'),
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
                                                                            await showDialog(
                                                                              context: context,
                                                                              builder: (alertDialogContext) {
                                                                                return WebViewAware(
                                                                                  child: AlertDialog(
                                                                                    title: const Text('Ошибка при удалении'),
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
                                                                          }

                                                                          Navigator.pop(alertDialogContextDelte);

                                                                          setState(() {});
                                                                        },
                                                                        child: const Text('Удалить', style: TextStyle(
                                                                          color: Colors.redAccent
                                                                        ),),
                                                                      )
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            );

                                                          },
                                                          child: Container(
                                                            child: const Icon(Icons.delete_outline,
                                                              size: 24.0,
                                                              color: CupertinoColors.systemRed,
                                                            ),
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



            // Expanded(
            //   child: Padding(
            //     padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
            //     child: PagedListView<ApiPagingParams, dynamic>(
            //       pagingController: _model.setListViewController(
            //         (nextPageMarker) => ProductGroup.providersProductsCall.call(
            //           jwtToken: FFAppState().jwttoken,
            //           page: nextPageMarker.nextPageNumber,
            //         ),
            //       ),
            //       padding: EdgeInsets.zero,
            //       primary: false,
            //       shrinkWrap: true,
            //       reverse: false,
            //       scrollDirection: Axis.vertical,
            //       builderDelegate: PagedChildBuilderDelegate<dynamic>(
            //         // Customize what your widget looks like when it's loading the first page.
            //         firstPageProgressIndicatorBuilder: (_) => Center(
            //           child: SizedBox(
            //             width: 50.0,
            //             height: 50.0,
            //             child: CircularProgressIndicator(
            //               valueColor: AlwaysStoppedAnimation<Color>(
            //                 FlutterFlowTheme.of(context).primary,
            //               ),
            //             ),
            //           ),
            //         ),
            //         // Customize what your widget looks like when it's loading another page.
            //         newPageProgressIndicatorBuilder: (_) => Center(
            //           child: SizedBox(
            //             width: 50.0,
            //             height: 50.0,
            //             child: CircularProgressIndicator(
            //               valueColor: AlwaysStoppedAnimation<Color>(
            //                 FlutterFlowTheme.of(context).primary,
            //               ),
            //             ),
            //           ),
            //         ),
            //
            //         itemBuilder: (context, _, productIndex) {
            //
            //
            //           var productItem = _model.listViewPagingController!.itemList![productIndex];
            //           return Padding(
            //             padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 8.0),
            //             child: Container(
            //               width: double.infinity,
            //               decoration: BoxDecoration(
            //                 color: FlutterFlowTheme.of(context)
            //                     .secondaryBackground,
            //                 boxShadow: const [
            //                   BoxShadow(
            //                     blurRadius: 3.0,
            //                     color: Color(0x411D2429),
            //                     offset: Offset(0.0, 1.0),
            //                   )
            //                 ],
            //                 borderRadius: BorderRadius.circular(8.0),
            //               ),
            //               child: Padding(
            //                 padding: EdgeInsets.all(8.0),
            //                 child: Row(
            //                   mainAxisSize: MainAxisSize.max,
            //                   children: [
            //                     Stack(
            //                       children: [
            //                         Padding(
            //                           padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 1.0, 1.0),
            //                           child: InkWell(
            //                             splashColor: Colors.transparent,
            //                             focusColor: Colors.transparent,
            //                             hoverColor: Colors.transparent,
            //                             highlightColor: Colors.transparent,
            //                             onTap: () async {
            //                               context.pushNamed(
            //                                 'ProductPage',
            //                                 queryParameters: {
            //                                   'id': serializeParam(
            //                                     getJsonField(
            //                                       productItem,
            //                                       r'''$.id''',
            //                                     ),
            //                                     ParamType.int,
            //                                   ),
            //                                 }.withoutNulls,
            //                               );
            //                             },
            //                             child: ClipRRect(
            //                               borderRadius:
            //                                   BorderRadius.circular(6.0),
            //                               child: Image.network(
            //                                 valueOrDefault<String>(
            //                                   getJsonField(
            //                                     productItem,
            //                                     r'''$.mainPhoto.url''',
            //                                   )?.toString(),
            //                                   'https://saudaline.kz/images/logo.png',
            //                                 ),
            //                                 width: 80.0,
            //                                 height: 80.0,
            //                                 fit: BoxFit.fitWidth,
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                     Expanded(
            //                       child: Padding(
            //                         padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 4.0, 0.0),
            //                         child: Column(
            //                           mainAxisSize: MainAxisSize.max,
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.center,
            //                           crossAxisAlignment:
            //                               CrossAxisAlignment.start,
            //                           children: [
            //                             Container(
            //                               width: 240.0,
            //                               decoration: BoxDecoration(
            //                                 color: FlutterFlowTheme.of(context).secondaryBackground,
            //                               ),
            //                               child: InkWell(
            //                                 splashColor: Colors.transparent,
            //                                 focusColor: Colors.transparent,
            //                                 hoverColor: Colors.transparent,
            //                                 highlightColor: Colors.transparent,
            //                                 onTap: () async {
            //                                   context.pushNamed(
            //                                     'ProductPage',
            //                                     queryParameters: {
            //                                       'id': serializeParam(
            //                                         getJsonField(
            //                                           productItem,
            //                                           r'''$.id''',
            //                                         ),
            //                                         ParamType.int,
            //                                       ),
            //                                     }.withoutNulls,
            //                                   );
            //                                 },
            //                                 child: AutoSizeText(
            //                                   getJsonField(
            //                                     productItem,
            //                                     r'''$.title''',
            //                                   ).toString(),
            //                                   maxLines: 2,
            //                                   style: const TextStyle(
            //                                             fontFamily: 'Futura',
            //                                             fontSize: 20.0,
            //                                             fontWeight: FontWeight.w700
            //                                           ),
            //                                   minFontSize: 14.0,
            //                                 ),
            //                               ),
            //                             ),
            //                             Row(
            //                               mainAxisSize: MainAxisSize.max,
            //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                               crossAxisAlignment: CrossAxisAlignment.center,
            //                               children: [
            //                                 InkWell(
            //                                   splashColor: Colors.transparent,
            //                                   focusColor: Colors.transparent,
            //                                   hoverColor: Colors.transparent,
            //                                   highlightColor:
            //                                       Colors.transparent,
            //                                   onTap: () async {
            //                                     context.pushNamed(
            //                                       'ProductPage',
            //                                       queryParameters: {
            //                                         'id': serializeParam(
            //                                           getJsonField(
            //                                             productItem,
            //                                             r'''$.id''',
            //                                           ),
            //                                           ParamType.int,
            //                                         ),
            //                                       }.withoutNulls,
            //                                     );
            //                                   },
            //                                   child: Column(
            //                                     mainAxisSize: MainAxisSize.max,
            //                                     crossAxisAlignment:
            //                                         CrossAxisAlignment.start,
            //                                     children: [
            //                                       if (getJsonField(
            //                                             productItem,
            //                                             r'''$.discount''',
            //                                           ) !=
            //                                           null)
            //                                         Padding(padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 8.0, 0.0),
            //                                           child: AutoSizeText(
            //                                             getJsonField(productItem, r'''$.category.title''',)
            //                                                 .toString()
            //                                                 .maybeHandleOverflow(
            //                                                   maxChars: 10,
            //                                                   replacement: '…',
            //                                                 ),
            //                                             textAlign: TextAlign.start,
            //                                             style: TextStyle(
            //                                               fontFamily: "Futura"
            //                                             ),
            //                                           ),
            //                                         ),
            //                                       Padding(
            //                                         padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 8.0, 0.0),
            //                                         child: AutoSizeText(
            //                                           '${getJsonField(productItem, r'''$.price''',).toString()} тг'.maybeHandleOverflow(
            //                                             maxChars: 70,
            //                                             replacement: '…',
            //                                           ),
            //                                           textAlign:
            //                                               TextAlign.start,
            //                                           style: const TextStyle(
            //                                                 fontFamily: 'Atyp',
            //                                                 color: Color(0xFFFCA522),
            //                                                 fontSize: 16.0,
            //                                                 fontWeight: FontWeight.w500,
            //                                               ),
            //                                         ),
            //                                       ),
            //                                     ],
            //                                   ),
            //                                 ),
            //                                 Row(
            //                                   mainAxisSize: MainAxisSize.max,
            //                                   children: [
            //                                     Padding(
            //                                       padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
            //                                       child: InkWell(
            //                                         splashColor: Colors.transparent,
            //                                         focusColor: Colors.transparent,
            //                                         hoverColor: Colors.transparent,
            //                                         highlightColor: Colors.transparent,
            //                                         onTap: () async {
            //                                           if (FFAppState()
            //                                               .cardProducts
            //                                               .contains(getJsonField(productItem, r'''$.id''',))) {
            //                                             await showDialog(
            //                                               context: context,
            //                                               builder: (alertDialogContext) {
            //                                                 return WebViewAware(
            //                                                   child: AlertDialog(
            //                                                     title: Text('Уже есть в корзине'),
            //                                                     actions: [
            //                                                       TextButton(
            //                                                         onPressed: () =>
            //                                                             Navigator.pop(alertDialogContext),
            //                                                         child: Text('Ok'),
            //                                                       ),
            //                                                     ],
            //                                                   ),
            //                                                 );
            //                                               },
            //                                             );
            //                                           } else {
            //                                             setState(() {
            //                                               FFAppState()
            //                                                   .addToCardProducts(
            //                                                   getJsonField(
            //                                                     productItem,
            //                                                     r'''$.id''',
            //                                                   ));
            //                                               FFAppState()
            //                                                   .addToCardProviders(
            //                                                   getJsonField(
            //                                                     productItem,
            //                                                     r'''$.provider.id''',
            //                                                   ));
            //                                               FFAppState().basketProducts = functions
            //                                                   .generatJsonProduct(
            //                                                   getJsonField(
            //                                                     productItem,
            //                                                     r'''$.id''',
            //                                                   ),
            //                                                   1,
            //                                                   FFAppState().basketProducts.toList(),
            //                                                   getJsonField(
            //                                                     productItem,
            //                                                     r'''$.provider.id''',
            //                                                   ),
            //                                                   getJsonField(
            //                                                     productItem,
            //                                                     r'''$.provider.name''',
            //                                                   ).toString(),
            //                                                   getJsonField(
            //                                                     productItem,
            //                                                     r'''$.provider.logotype[:1].url''',
            //                                                   ).toString(),
            //                                                   getJsonField(
            //                                                     productItem,
            //                                                     r'''$.price''',
            //                                                   ),
            //                                                   getJsonField(
            //                                                     productItem,
            //                                                     r'''$.mainPhoto.url''',
            //                                                   ).toString(),
            //                                                   getJsonField(
            //                                                     productItem,
            //                                                     r'''$.title''',
            //                                                   ).toString(),
            //                                                   valueOrDefault<int>(
            //                                                     getJsonField(
            //                                                       productItem,
            //                                                       r'''$.discount''',
            //                                                     ),
            //                                                     0,
            //                                                   ))!
            //                                                   .toList()
            //                                                   .cast<dynamic>();
            //                                             });
            //                                           }
            //                                         },
            //                                         child: Container(
            //                                           child: InkWell(
            //                                             splashColor: Colors.transparent,
            //                                             focusColor: Colors.transparent,
            //                                             hoverColor: Colors.transparent,
            //                                             highlightColor: Colors.transparent,
            //                                             onTap: () async {
            //                                               context.pushNamed(
            //                                                 'ProductEditPage',
            //                                                 queryParameters: {
            //                                                   'productId':
            //                                                   serializeParam(
            //                                                     getJsonField(
            //                                                       productItem,
            //                                                       r'''$.id''',
            //                                                     ),
            //                                                     ParamType.int,
            //                                                   ),
            //                                                 }.withoutNulls,
            //                                               );
            //                                             },
            //                                             child: Icon(
            //                                               Icons.edit_outlined, size: 24.0,
            //                                               color: CupertinoColors.systemGreen,
            //                                             ),
            //                                           ),
            //                                         ),
            //                                       ),
            //                                     ),
            //                                     SizedBox(width: 10.0,),
            //                                     Padding(
            //                                       padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 10.0, 0.0),
            //                                       child: InkWell(
            //                                         splashColor: Colors.transparent,
            //                                         focusColor: Colors.transparent,
            //                                         hoverColor: Colors.transparent,
            //                                         highlightColor: Colors.transparent,
            //                                         onTap: () async {
            //                                           _model.apiResultcp2 =
            //                                               await ProductGroup
            //                                                   .deleteProductByIdCall
            //                                                   .call(
            //                                             productId: getJsonField(
            //                                               productItem,
            //                                               r'''$.id''',
            //                                             ),
            //                                             jwtToken: FFAppState()
            //                                                 .jwttoken,
            //                                           );
            //                                           if ((_model.apiResultcp2
            //                                                   ?.succeeded ??
            //                                               true)) {
            //                                             await showDialog(
            //                                               context: context,
            //                                               builder:
            //                                                   (alertDialogContext) {
            //                                                 return WebViewAware(
            //                                                   child:
            //                                                       AlertDialog(
            //                                                     title: Text(
            //                                                         'Удалено успешно'),
            //                                                     actions: [
            //                                                       TextButton(
            //                                                         onPressed: () =>
            //                                                             Navigator.pop(
            //                                                                 alertDialogContext),
            //                                                         child: Text(
            //                                                             'Ok'),
            //                                                       ),
            //                                                     ],
            //                                                   ),
            //                                                 );
            //                                               },
            //                                             );
            //
            //                                             context.pushNamed(
            //                                                 'ProvidersProducts');
            //                                           } else {
            //                                             await showDialog(
            //                                               context: context,
            //                                               builder:
            //                                                   (alertDialogContext) {
            //                                                 return WebViewAware(
            //                                                   child:
            //                                                       AlertDialog(
            //                                                     title: Text(
            //                                                         'Ошибка при удалении'),
            //                                                     actions: [
            //                                                       TextButton(
            //                                                         onPressed: () =>
            //                                                             Navigator.pop(
            //                                                                 alertDialogContext),
            //                                                         child: Text(
            //                                                             'Ok'),
            //                                                       ),
            //                                                     ],
            //                                                   ),
            //                                                 );
            //                                               },
            //                                             );
            //                                           }
            //
            //                                           setState(() {});
            //                                         },
            //                                         child: Container(
            //                                           child: const Icon(Icons.delete_outline,
            //                                             size: 24.0,
            //                                             color: CupertinoColors.systemRed,
            //                                           ),
            //                                         ),
            //                                       ),
            //                                     ),
            //
            //                                   ],
            //                                 ),
            //                               ],
            //                             ),
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           );
            //         },
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
