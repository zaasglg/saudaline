import 'dart:convert';

import 'package:flutter/scheduler.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sauda_line/index.dart';
import 'package:sauda_line/main.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'providers_promotions_model.dart';
export 'providers_promotions_model.dart';
import 'package:http/http.dart' as http;

class ProvidersPromotionsWidget extends StatefulWidget {
  const ProvidersPromotionsWidget({super.key});

  @override
  State<ProvidersPromotionsWidget> createState() =>
      _ProvidersPromotionsWidgetState();
}

class _ProvidersPromotionsWidgetState extends State<ProvidersPromotionsWidget> {
  late ProvidersPromotionsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? orderStatus = 'ACTIVE';
  int? selectedCityId;

  @override
  void initState() {
    super.initState();

    _model = createModel(context, () => ProvidersPromotionsModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<List<dynamic>> fetchCities() async {
    final response = await http.get(Uri.parse('https://server.saudaline.kz/api/v1/provider/get-by-userid?id=${FFAppState().accountInfo["id"]}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['city'];
    } else {
      throw Exception('Failed to load cities');
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async {

          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return NavBarPage(currentPageName: "profile",);
          }));

          return false;
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primary,
            automaticallyImplyLeading: true,
            title: Text(
              'Акции',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Readex Pro',
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    pushNewScreen(context, screen: const PromotionAddPageWidget());
                    // context.pushNamed('PromotionAddPage');
                  },
                  child: const Icon(
                    Icons.add,
                    color: Color(0xFFF1F1F1),
                    size: 24.0,
                  ),
                ),
              ),
            ],
            centerTitle: true,
            elevation: 4.0,
          ),
          body: SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15.0, 8.0, 8.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    setState(() {
                                      orderStatus = "ACTIVE";
                                    });
                                  },
                                  text: 'Активные',
                                  options: FFButtonOptions(
                                    height: 28.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                    color:
                                    orderStatus == "ACTIVE"
                                        ? Color(0xFFFCA522)
                                        : Colors.white,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                      fontFamily: 'Readex Pro',
                                      color: orderStatus == "ACTIVE"
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 14.0,
                                    ),
                                    borderSide: BorderSide(
                                      color: Color(0xFFFCA522),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(0.0),
                                      bottomRight: Radius.circular(0.0),
                                      topLeft: Radius.circular(0.0),
                                      topRight: Radius.circular(0.0),
                                    ),
                                  ),
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  setState(() {
                                    orderStatus = "INACTIVE";
                                  });
                                },
                                text: 'Неактивные',
                                options: FFButtonOptions(
                                  height: 28.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: orderStatus == "INACTIVE"
                                      ? Color(0xFFFCA522)
                                      : Colors.white,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                    fontFamily: 'Readex Pro',
                                    color: orderStatus == "INACTIVE"
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 14.0,
                                  ),
                                  borderSide: BorderSide(
                                    color: Color(0xFFFCA522),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(0.0),
                                    bottomRight: Radius.circular(0.0),
                                    topLeft: Radius.circular(0.0),
                                    topRight: Radius.circular(0.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: FutureBuilder<List<dynamic>>(
                      future: fetchCities(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('No cities found'));
                        } else {

                          List<dynamic> cities = snapshot.data!;

                          return Container(
                            margin: const EdgeInsets.all(10.0),
                            height: 30.0,
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(100.0),
                                color: Colors.grey.withOpacity(0.2)
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                hint: Text('Город'),
                                value: selectedCityId,
                                padding: EdgeInsets.zero,
                                onChanged: (int? newValue) {
                                  setState(() {
                                    selectedCityId = newValue;
                                  });
                                },
                                items: cities.map((city) {
                                  return DropdownMenuItem<int>(
                                    value: city['id'],
                                    child: Text(city['name'], style: TextStyle(
                                        fontFamily: "Futura",
                                        fontSize: 13.0
                                    ),),
                                  );
                                }).toList(),
                              ),
                            ),
                          );

                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 50.0),
                    child: FutureBuilder<ApiCallResponse>(
                      future: PromotionsGroup.getProvidersPromotionsCall.call(
                        jwtToken: FFAppState().jwttoken,
                        userId: getJsonField(
                          FFAppState().accountInfo,
                          r'''$.id''',
                        ),
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
                        final listViewGetProvidersPromotionsResponse = snapshot.data!;
                        return Builder(
                          builder: (context) {
                            final promotion = getJsonField(listViewGetProvidersPromotionsResponse.jsonBody, r'''$.list''',).toList();

                            var filterData = promotion.where((element) => element["isActive"] == true).toList() ?? [];

                            if (orderStatus == "ACTIVE") {
                              filterData = promotion.where((element) => element["isActive"] == true).toList() ?? [];
                            } else {
                              filterData = promotion.where((element) => element["isActive"] == false).toList() ?? [];
                            }

                            if (selectedCityId != null) {
                              filterData = filterData.where((element) => element["city"]["id"] == selectedCityId).toList() ?? [];
                            }

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              reverse: true,
                              itemCount: filterData.length,
                              itemBuilder: (context, promotionIndex) {

                                final promotionItem = filterData[promotionIndex];

                                return Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: const Color(0x28000000),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 15.0, 0.0),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                      child: RichText(
                                                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  'Номер акции: ',
                                                              style: TextStyle(
                                                                    fontFamily:
                                                                        'Futura',
                                                                    color: Colors.black,
                                                                    fontWeight:
                                                                        FontWeight.w600,
                                                                  ),
                                                            ),
                                                            TextSpan(
                                                              text: getJsonField(
                                                                promotionItem,
                                                                r'''$.id''',
                                                              ).toString(),
                                                              style: const TextStyle(
                                                                color:
                                                                    Colors.black,
                                                              ),
                                                            )
                                                          ],
                                                          style:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(0.0, 5.0,
                                                                  0.0, 0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Container(
                                                            width: 250.0,
                                                            height: 20.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                            ),
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    -1.0, 0.0),
                                                            child: Text(
                                                              getJsonField(
                                                                promotionItem,
                                                                r'''$.title''',
                                                              ).toString(),
                                                              textAlign: TextAlign
                                                                  .center,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    color:
                                                                        colorFromCssString(
                                                                      functions
                                                                          .formatStatusColor(
                                                                              getJsonField(
                                                                        promotionItem,
                                                                        r'''$.status''',
                                                                      ).toString())!,
                                                                      defaultColor:
                                                                          Colors
                                                                              .black,
                                                                    ),
                                                                    fontSize:
                                                                        14.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(0.0, 0.0,
                                                                  0.0, 5.0),
                                                      child: RichText(
                                                        textScaleFactor:
                                                            MediaQuery.of(context)
                                                                .textScaleFactor,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: 'Статус: ',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                            ),
                                                            TextSpan(
                                                              text: getJsonField(
                                                                promotionItem,
                                                                r'''$.isActive''',
                                                              )
                                                                  ? 'Активный'
                                                                  : 'Не активный',
                                                              style: const TextStyle(
                                                                color:
                                                                    Colors.black,
                                                              ),
                                                            )
                                                          ],
                                                          style:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                      child: RichText(
                                                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: 'Город: ',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                            ),
                                                            TextSpan(
                                                              text: promotionItem["city"]["name"],
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.black,
                                                              ),
                                                            )
                                                          ],
                                                          style: FlutterFlowTheme.of(context).bodyMedium,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                      child: RichText(
                                                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                              'Дата начала: ',
                                                              style: FlutterFlowTheme
                                                                  .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                fontFamily:
                                                                'Readex Pro',
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: functions.formatDate(promotionItem["startDate"]),
                                                              style: TextStyle(
                                                                color:
                                                                Colors.black,
                                                              ),
                                                            )
                                                          ],
                                                          style: FlutterFlowTheme.of(context).bodyMedium,
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
                                                            text:
                                                                'Дата окончания: ',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                          TextSpan(
                                                            text: functions.formatDate(promotionItem["finishDate"]),
                                                            style: const TextStyle(
                                                              color: Colors.black,
                                                            ),
                                                          )
                                                        ],
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Divider(
                                                thickness: 0.4,
                                                color: Color(0xCCB9B9B9),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                                                child: InkWell(
                                                  splashColor: Colors.transparent,
                                                  focusColor: Colors.transparent,
                                                  hoverColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  onTap: () async {

                                                    pushNewScreen(context, screen: PromotionPageProviderWidget(
                                                      promotionId: int.tryParse(serializeParam(getJsonField(promotionItem, r'''$.id''',), ParamType.int,) ?? '0'),
                                                    ));
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 37.0,
                                                    decoration: const BoxDecoration(
                                                      color: Colors.white,
                                                    ),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        const Text('Подробности акции',
                                                          style: TextStyle(
                                                            fontFamily: 'Atyp',
                                                            color: Color(0xFF0B7FD1),
                                                            fontWeight: FontWeight.w900,
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons.keyboard_arrow_right,
                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                          size: 24.0,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
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
                        );
                      },
                    ),
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
