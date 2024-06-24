import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sauda_line/customer/product_page/product_page_widget.dart';

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
import 'package:provider/provider.dart';
import 'search_page_model.dart';
export 'search_page_model.dart';

class SearchPageWidget extends StatefulWidget {
  const SearchPageWidget({super.key});

  @override
  State<SearchPageWidget> createState() => _SearchPageWidgetState();
}

class _SearchPageWidgetState extends State<SearchPageWidget> {
  late SearchPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchPageModel());

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
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 10.0),
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
                        '_model.textController', Duration(milliseconds: 2000), () async {
                          _model.apiResult3r9 = await ProductGroup.searchProductsCall.call(
                            cityId: FFAppState().cityId,
                            keyword: functions.deleteSpaces(_model.textController.text),
                          );

                          setState(() {});
                        },
                      ),
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 18.0,
                                ),
                        hintText: 'Поиск товаров...',
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 18.0,
                                ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xFFFCA522),
                          size: 20.0,
                        ),
                        suffixIcon: _model.textController!.text.isNotEmpty
                            ? InkWell(
                                onTap: () async {
                                  _model.textController?.clear();
                                  _model.apiResult3r9 = await ProductGroup
                                      .searchProductsCall
                                      .call(
                                    cityId: FFAppState().cityId,
                                    keyword: functions.deleteSpaces(
                                        _model.textController.text),
                                  );

                                  setState(() {});
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.clear,
                                  size: 20.0,
                                ),
                              )
                            : null,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? FlutterFlowTheme.of(context).primary
                                    : Colors.black,
                            fontSize: 18.0,
                          ),
                      validator:
                          _model.textControllerValidator.asValidator(context),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 60.0),
                    child: Stack(
                      children: [
                        if (_model.textController.text != null && _model.textController.text != '')
                          Builder(
                            builder: (context) {
                              final product = getJsonField((_model.apiResult3r9?.jsonBody ?? ''), r'''$''',).toList();

                              if (product.length == 0) {
                                return Center(
                                  child: Text("Товар не найден"),
                                );
                              }

                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                primary: false,
                                scrollDirection: Axis.vertical,
                                itemCount: product.length,
                                itemBuilder: (context, productIndex) {
                                  final productItem = product[productIndex];
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      pushNewScreen(context, screen: ProductPageWidget(
                                        id: int.tryParse(serializeParam(getJsonField(productItem, r'''$.id''',),ParamType.int,) ?? '0'),
                                      ));

                                      // context.pushNamed(
                                      //   'ProductPage',
                                      //   queryParameters: {
                                      //     'id':
                                      //   }.withoutNulls,
                                      // );
                                    },
                                    child: Container(
                                      width: 100.0,
                                      height: 120.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    15.0, 10.0, 10.0, 10.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                valueOrDefault<String>(
                                                  getJsonField(
                                                    productItem,
                                                    r'''$.mainPhoto.url''',
                                                  )?.toString(),
                                                  'https://saudaline.kz/static/media/logo-black.3dd0c1b45c67d12b1064a6cd9bc8bca3.svg',
                                                ),
                                                width: 102.0,
                                                height: 200.0,
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 10.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.55,
                                                  height: 40.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            -1.0, 0.0),
                                                    child: SelectionArea(
                                                        child: AutoSizeText(
                                                      getJsonField(
                                                        productItem,
                                                        r'''$.title''',
                                                      ).toString(),
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 2,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                      minFontSize: 14.0,
                                                    )),
                                                  ),
                                                ),
                                                Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.55,
                                                  height: 20.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            -1.0, 0.0),
                                                    child: SelectionArea(
                                                        child: AutoSizeText(
                                                      getJsonField(
                                                        productItem,
                                                        r'''$.category.title''',
                                                      ).toString(),
                                                      maxLines: 1,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                      minFontSize: 14.0,
                                                    )),
                                                  ),
                                                ),
                                                Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.55,
                                                  height: 20.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            -1.0, 0.0),
                                                    child: SelectionArea(
                                                        child: AutoSizeText(
                                                      getJsonField(
                                                        productItem,
                                                        r'''$.provider.name''',
                                                      ).toString(),
                                                      maxLines: 1,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                      minFontSize: 14.0,
                                                    )),
                                                  ),
                                                ),
                                                RichText(
                                                  textScaleFactor:
                                                      MediaQuery.of(context)
                                                          .textScaleFactor,
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: getJsonField(
                                                          productItem,
                                                          r'''$.price''',
                                                        ).toString(),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                      ),
                                                      TextSpan(
                                                        text: ' тг',
                                                        style: TextStyle(),
                                                      )
                                                    ],
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium,
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
                          ),
                      ],
                    ),
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
