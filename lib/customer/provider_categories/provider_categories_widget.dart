import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sauda_line/customer/products_by_categories/products_by_categories_widget.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'provider_categories_model.dart';
export 'provider_categories_model.dart';

class ProviderCategoriesWidget extends StatefulWidget {
  const ProviderCategoriesWidget({
    super.key,
    required this.providerName,
    required this.providerId,
  });

  final String? providerName;
  final int? providerId;

  @override
  State<ProviderCategoriesWidget> createState() =>
      _ProviderCategoriesWidgetState();
}

class _ProviderCategoriesWidgetState extends State<ProviderCategoriesWidget> {
  late ProviderCategoriesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProviderCategoriesModel());
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
                TextSpan(
                  text: 'Продукция поставщика ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: widget.providerName!,
                  style: TextStyle(
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
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                  child: FutureBuilder<ApiCallResponse>(
                    future: CategoryGroup.categoriesByProviderIdCall.call(
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
                      final listViewCategoriesByProviderIdResponse =
                          snapshot.data!;
                      return Builder(
                        builder: (context) {
                          final category = getJsonField(
                            listViewCategoriesByProviderIdResponse.jsonBody,
                            r'''$''',
                          ).toList();
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: category.length,
                            itemBuilder: (context, categoryIndex) {
                              final categoryItem = category[categoryIndex];
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 8.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {

                                    // pushNewScreen(context, screen: ProductsByCategoriesWidget(
                                    //   categoryName: serializeParam(getJsonField(categoryItem, r'''$.title''',).toString(), ParamType.String,),
                                    //   categoryId: int.tryParse(serializeParam(getJsonField(categoryItem, r'''$.id''',), ParamType.int,) ?? '0'),
                                    // ));
                                    //
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                      return ProductsByCategoriesWidget(
                                        categoryName: serializeParam(getJsonField(categoryItem, r'''$.title''',).toString(), ParamType.String,),
                                        categoryId: int.tryParse(serializeParam(getJsonField(categoryItem, r'''$.id''',), ParamType.int,) ?? '0'),
                                      );
                                    }));

                                    // context.pushNamed(
                                    //   'ProductsByCategories',
                                    //   queryParameters: {
                                    //     'categoryName': ,
                                    //     'categoryId': ,
                                    //   }.withoutNulls,
                                    // );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 3.0,
                                          color: Color(0x411D2429),
                                          offset: Offset(0.0, 1.0),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            getJsonField(
                                              categoryItem,
                                              r'''$.title''',
                                            ).toString(),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium,
                                          ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
