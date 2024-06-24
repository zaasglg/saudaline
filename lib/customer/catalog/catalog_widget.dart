import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sauda_line/customer/category_providers/category_providers_widget.dart';
import 'package:sauda_line/main.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'catalog_model.dart';
export 'catalog_model.dart';

class CatalogWidget extends StatefulWidget {
  const CatalogWidget({super.key});

  @override
  State<CatalogWidget> createState() => _CatalogWidgetState();
}

class _CatalogWidgetState extends State<CatalogWidget> {
  late CatalogModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CatalogModel());
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
      child: WillPopScope(
        onWillPop: () async{
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return NavBarPage(currentPageName: "home",);
          }));

          return false;
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primary,
            automaticallyImplyLeading: true,
            title: const Text(
              'Каталог',
              style: TextStyle(
                    fontFamily: 'Gilroy',
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            actions: [],
            elevation: 0,
          ),
          body: SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 0.0, 0.0),
                    child: Text(
                      'Категории поставщиков товаров',
                      style: TextStyle(
                            fontFamily: 'Atyp',
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  FutureBuilder<ApiCallResponse>(
                    future: GetAllProviderCategoryCall.call(),
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
                      final listViewGetAllProviderCategoryResponse = snapshot.data!;
                      return Builder(
                        builder: (context) {
                          final category = getJsonField(listViewGetAllProviderCategoryResponse.jsonBody, r'''$[:]''',).toList();
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: category.length,
                            itemBuilder: (context, categoryIndex) {
                              final categoryItem = category[categoryIndex];
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                      return CategoryProvidersWidget(
                                        categoryTitle: serializeParam(getJsonField(categoryItem, r'''$.nameRu''',).toString(), ParamType.String,),
                                        categoryId: int.tryParse(serializeParam(getJsonField(categoryItem, r'''$.id''',), ParamType.int,) ?? '0') ?? 0,
                                      );
                                    }));

                                  },
                                  child: Container(
                                    width: 100.0,
                                    height: 90.0,
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
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  valueOrDefault<String>(
                                                    getJsonField(categoryItem, r'''$.photo[:1].url''',)?.toString(), 'https://saudaline.kz/images/logo.png',
                                                  ),
                                                  width: 80.0,
                                                  height: 70.0,
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(-1.0, 0.0),
                                              child: Container(
                                                width: 200.0,
                                                height: 70.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                ),
                                                alignment: AlignmentDirectional(-1.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    getJsonField(
                                                      categoryItem,
                                                      r'''$.nameRu''',
                                                    ).toString(),
                                                    style: TextStyle(
                                                      fontFamily: "Avenger",
                                                      fontSize: 15.0
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
