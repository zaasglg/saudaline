import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:sauda_line/main.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

import '/backend/api_requests/api_calls.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'city_selection_pega_model.dart';

export 'city_selection_pega_model.dart';

class CitySelectionPegaWidget extends StatefulWidget {
  const CitySelectionPegaWidget({super.key});

  @override
  State<CitySelectionPegaWidget> createState() =>
      _CitySelectionPegaWidgetState();
}

class _CitySelectionPegaWidgetState extends State<CitySelectionPegaWidget> {
  late CitySelectionPegaModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CitySelectionPegaModel());

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

    return FutureBuilder<ApiCallResponse>(
      future: CatalogGroup.cityByNameCall.call(),
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
        final citySelectionPegaCityByNameResponse = snapshot.data!;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).primary,
              automaticallyImplyLeading: true,
              title: Text(
                'Выбор города',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              actions: [],
              centerTitle: true,
              elevation: 4.0,
            ),
            body: SafeArea(
              top: true,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10.0, 15.0, 10.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.75,
                            height: 45.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: const Color(0xFF9D9D9D),
                              ),
                            ),
                            alignment: const AlignmentDirectional(-1.0, 0.0),
                            child: TextFormField(
                              controller: _model.textController,
                              focusNode: _model.textFieldFocusNode,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.textController',
                                const Duration(milliseconds: 2000),
                                    () => setState(() {}),
                              ),
                              obscureText: false,
                              decoration: InputDecoration(
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 18.0,
                                ),
                                hintText: 'Поиск городов...',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 18.0,
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Color(0xFFFCA522),
                                  size: 20.0,
                                ),
                                suffixIcon:
                                _model.textController!.text.isNotEmpty
                                    ? InkWell(
                                  onTap: () async {
                                    _model.textController?.clear();
                                    setState(() {});
                                  },
                                  child: const Icon(
                                    Icons.clear,
                                    size: 20.0,
                                  ),
                                )
                                    : null,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Readex Pro',
                                color: Theme.of(context).brightness ==
                                    Brightness.dark
                                    ? FlutterFlowTheme.of(context).primary
                                    : Colors.black,
                                fontSize: 18.0,
                              ),
                              validator: _model.textControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.apiResultSearch =
                            await CatalogGroup.cityByNameCall.call(
                              cityName: _model.textController.text,
                            );

                            setState(() {});
                          },
                          child: Text(
                            'Найти',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Readex Pro',
                              color: const Color(0xFF6E6E6E),
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          if (getJsonField((_model.apiResultSearch?.jsonBody ?? ''), r'''$[:1].id''',) != null)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                              child: Builder(
                                builder: (context) {
                                  final city = (_model.apiResultSearch?.jsonBody ?? '').toList();
                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    primary: false,
                                    scrollDirection: Axis.vertical,
                                    itemCount: city.length,
                                    itemBuilder: (context, cityIndex) {
                                      final cityItem = city[cityIndex];
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            _model.cityBoolean =
                                            await actions.setCity(
                                              getJsonField(
                                                cityItem,
                                                r'''$.id''',
                                              ),
                                            );
                                            if (_model.cityBoolean!) {
                                              await actions.setCityName(
                                                getJsonField(
                                                  cityItem,
                                                  r'''$.name''',
                                                ).toString(),
                                              );
                                              _model.cityId =
                                              await actions.getCityId();
                                              _model.cityName =
                                              await actions.getCityName();
                                              setState(() {
                                                FFAppState().cityId =
                                                _model.cityId!;
                                                FFAppState().cityName =
                                                _model.cityName!;
                                              });

                                              setState(() {});
                                              Navigator.pop(context);
                                            } else {
                                              await showDialog(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return WebViewAware(
                                                    child: AlertDialog(
                                                      title: const Text('Ошибка'),
                                                      content: Text((_model
                                                          .apiResultSearch
                                                          ?.jsonBody ??
                                                          '')
                                                          .toString()),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext),
                                                          child: const Text('Ок'),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            }

                                            setState(() {});
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 65.0,
                                            decoration: BoxDecoration(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                              borderRadius:
                                              BorderRadius.circular(5.0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 10.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(getJsonField(cityItem, r'''$.region.nameRu''',).toString(),
                                                          style: FlutterFlowTheme
                                                              .of(context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'Readex Pro',
                                                            fontSize: 16.0,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              0.0,
                                                              5.0,
                                                              0.0,
                                                              0.0),
                                                          child: Text(
                                                            getJsonField(
                                                              cityItem,
                                                              r'''$.name''',
                                                            ).toString(),
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .bodyMedium
                                                                .override(
                                                              fontFamily:
                                                              'Readex Pro',
                                                              fontSize:
                                                              18.0,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios_rounded,
                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                    size: 16.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          if (citySelectionPegaCityByNameResponse.succeeded && (getJsonField((_model.apiResultSearch?.jsonBody ?? ''), r'''$[:1].id''',) == null))
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                              child: Builder(
                                builder: (context) {
                                  final city = CatalogGroup.cityByNameCall
                                      .citiesList(citySelectionPegaCityByNameResponse.jsonBody,)?.toList() ?? [];
                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    primary: false,
                                    scrollDirection: Axis.vertical,
                                    itemCount: city.length,
                                    itemBuilder: (context, cityIndex) {
                                      final cityItem = city[cityIndex];
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {

                                            _model.cityBoolean2 = await actions.setCity(
                                              getJsonField(cityItem, r'''$.id''',),
                                            );

                                            Navigator.of(context).pop();

                                            if (_model.cityBoolean2!) {
                                              await actions.setCityName(
                                                getJsonField(
                                                  cityItem,
                                                  r'''$.name''',
                                                ).toString(),
                                              );
                                              _model.cityId2 = await actions.getCityId();
                                              _model.cityName2 = await actions.getCityName();

                                              setState(() {
                                                FFAppState().cityId = _model.cityId2!;
                                                FFAppState().cityName = _model.cityName2!;
                                              });

                                              setState(() {});
                                              Navigator.pop(context);
                                            } else {
                                              await showDialog(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return WebViewAware(
                                                    child: AlertDialog(
                                                      title: const Text('Ошибка'),
                                                      content: Text((_model
                                                          .apiResultSearch
                                                          ?.jsonBody ??
                                                          '')
                                                          .toString()),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext),
                                                          child: const Text('Ок'),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            }

                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 65.0,
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                              borderRadius: BorderRadius.circular(5.0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 10.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                      MainAxisSize.max,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          getJsonField(cityItem, r'''$.region.nameRu''',).toString(),
                                                          style: const TextStyle(
                                                            fontFamily: 'Gilroy', fontSize: 16.0,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                          child: Text(
                                                            getJsonField(cityItem, r'''$.name''',).toString(),
                                                            style: const TextStyle(
                                                              fontFamily: 'Gilroy', fontSize: 18.0, fontWeight: FontWeight.w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios_rounded,
                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                    size: 16.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
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
