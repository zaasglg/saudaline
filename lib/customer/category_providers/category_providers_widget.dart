import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sauda_line/customer/provider_page/provider_page_widget.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'category_providers_model.dart';
export 'category_providers_model.dart';

class CategoryProvidersWidget extends StatefulWidget {
  const CategoryProvidersWidget({
    super.key,
    required this.categoryTitle,
    required this.categoryId,
  });

  final String? categoryTitle;
  final int? categoryId;

  @override
  State<CategoryProvidersWidget> createState() => _CategoryProvidersWidgetState();
}

class _CategoryProvidersWidgetState extends State<CategoryProvidersWidget> {
  late CategoryProvidersModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CategoryProvidersModel());
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 0.0, 0.0),
                  child: Text(
                    'Фирмы и поставщики, поставляющие',
                    style: TextStyle(
                          fontFamily: 'Gilroy',
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 2.0, 0.0, 0.0),
                  child: Text(
                    widget.categoryTitle!,
                    style: TextStyle(
                          fontFamily: 'Gilroy',
                          color: isDarkMode ? Colors.white54 : Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 50.0),
                  child: FutureBuilder<ApiCallResponse>(
                    future: ProviderAPiGroup.providersByCategoryCall.call(
                      providerCatId: widget.categoryId,
                      cityId: FFAppState().cityId,
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
                      final listViewProvidersByCategoryResponse =
                          snapshot.data!;
                      return Builder(
                        builder: (context) {
                          final provider = getJsonField(
                            listViewProvidersByCategoryResponse.jsonBody,
                            r'''$''',
                          ).toList();
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: provider.length,
                            itemBuilder: (context, providerIndex) {
                              final providerItem = provider[providerIndex];
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 10.0, 10.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    // pushNewScreen(
                                    //     context,
                                    //     screen: ProviderPageWidget(providerId: int.tryParse(serializeParam(getJsonField(providerItem, r'''$.id''',), ParamType.int,) ?? '0') ?? 0)
                                    // );

                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                      return ProviderPageWidget(providerId: int.tryParse(serializeParam(getJsonField(providerItem, r'''$.id''',), ParamType.int,) ?? '0') ?? 0);
                                    }));

                                    // context.pushNamed(
                                    //   'ProviderPage',
                                    //   queryParameters: {
                                    //     'providerId': serializeParam(getJsonField(providerItem, r'''$.id''',), ParamType.int,),
                                    //   }.withoutNulls,
                                    // );
                                  },
                                  child: Container(
                                    height: 130.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            if (getJsonField(
                                                      providerItem,
                                                      r'''$.logotype[:1].url''',
                                                    ) ==
                                                    null
                                                ? false
                                                : true)
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 0.0, 0.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.network(
                                                    valueOrDefault<String>(
                                                      getJsonField(
                                                        providerItem,
                                                        r'''$.logotype[:1].url''',
                                                      )?.toString(),
                                                      'https://saudaline.kz/images/logo.png',
                                                    ),
                                                    width: 80.0,
                                                    height: 70.0,
                                                    fit: BoxFit.fitWidth,
                                                  ),
                                                ),
                                              ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Container(
                                                width: 210.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                ),
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 220.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    0.0,
                                                                    0.0,
                                                                    8.0),
                                                        child: AutoSizeText(
                                                          getJsonField(
                                                            providerItem,
                                                            r'''$.name''',
                                                          ).toString(),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Readex Pro',
                                                                fontSize: 18.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            'БИН:',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      5.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            getJsonField(
                                                              providerItem,
                                                              r'''$.businessNumber''',
                                                            ).toString(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            'Тел:',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      5.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            getJsonField(
                                                              providerItem,
                                                              r'''$.phone''',
                                                            ).toString(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 10.0, 0.0),
                                          child: Icon(
                                            Icons.keyboard_arrow_right,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 24.0,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
