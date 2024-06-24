import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sauda_line/admin/about/admin_content_page.dart';
import 'package:sauda_line/admin/cities/admin_cities_page.dart';
import 'package:sauda_line/admin/magazine/admin_magazines_page.dart';
import 'package:sauda_line/admin/orders/admin_orders_page.dart';
import 'package:sauda_line/admin/products/admin_products_page.dart';
import 'package:sauda_line/admin/providers/admin_prodviders_page.dart';
import 'package:sauda_line/admin/regions/admin_regions_page.dart';
import 'package:sauda_line/admin/tariff/admin_tariff_page.dart';
import 'package:sauda_line/city/change_city_widget.dart';
import 'package:sauda_line/common/login/pincode_entry_page/pincode_entry_page_widget.dart';
import 'package:sauda_line/customer/address/delivery_addresses/delivery_addresses_widget.dart';
import 'package:sauda_line/customer/order/my_orders/my_orders_widget.dart';
import 'package:sauda_line/index.dart';
import 'package:sauda_line/main.dart';
import 'package:sauda_line/provider/brands/brands_page_widget.dart';
import 'package:sauda_line/provider/category/category_widget.dart';

import '../provider/my_profile.dart';
import '../provider/providers_orders/providers_orders_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/connect_tariff_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'profile_model.dart';
export 'profile_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileWidget extends StatefulWidget {
  final VoidCallback? changeIsProfilePage;
  const ProfileWidget({super.key, this.changeIsProfilePage});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late ProfileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _model = createModel(context, () => ProfileModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.apiResult0no = await LoginAndRegistrationGroup.checkTokenCall.call(
        jwtToken: FFAppState().jwttoken,
      );
      if ((_model.apiResult0no?.succeeded ?? true)) {
        setState(() {
          FFAppState().isLogged = true;
          FFAppState().jwttoken = FFAppState().jwttoken;
          FFAppState().isProvider = false;
        });
        _model.apiResultnUserInfo =
            await LoginAndRegistrationGroup.getUserInfoCall.call(
          jwtToken: FFAppState().jwttoken,
        );
        if ((_model.apiResultnUserInfo?.succeeded ?? true)) {
          setState(() {
            FFAppState().accountInfo =
                (_model.apiResultnUserInfo?.jsonBody ?? '');
            FFAppState().isProvider =
                LoginAndRegistrationGroup.getUserInfoCall.roleName(
                          (_model.apiResultnUserInfo?.jsonBody ?? ''),
                        ) ==
                        'ROLE_PROVIDER'
                    ? true
                    : false;
          });
        } else {
          setState(() {
            FFAppState().accountInfo = null;
          });
        }

        if (FFAppState().isProvider) {
          _model.apiProviderInfoByPrincipal = await ProviderAPiGroup
              .getProviderInfoByPrincipalToMobileCall
              .call(
            jwtToken: FFAppState().jwttoken,
          );
          if ((_model.apiProviderInfoByPrincipal?.succeeded ?? true)) {
            if (getJsonField(
                  (_model.apiProviderInfoByPrincipal?.jsonBody ?? ''),
                  r'''$.tariff''',
                ) !=
                null) {
              setState(() {
                _model.tariffEist = true;
              });
            } else {
              setState(() {
                _model.tariffEist = false;
              });
            }
          } else {
            await showDialog(
              context: context,
              builder: (alertDialogContext) {
                return WebViewAware(
                  child: AlertDialog(
                    title: const Text('Ошибка при запросе'),
                    content: Text(
                        (_model.apiProviderInfoByPrincipal?.jsonBody ?? '')
                            .toString()),
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
            setState(() {
              _model.tariffEist = false;
              _model.balance = 0;
            });
          }
        } else {
          setState(() {
            FFAppState().isProvider = false;
          });
        }
      } else {
        _model.doesPinExist = await actions.doesPinCodeExist();
        if (_model.doesPinExist!) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return PincodeEntryPageWidget();
          }));
        } else {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return LoginWidget();
          }));
        }
      }

      setState(() {
        _model.isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<Map<String, dynamic>> fetchBalance() async {

    try {
      var response = await http.get(
        Uri.parse("https://server.saudaline.kz/api/v1/provider/get-provider-balance"),
        headers: {"Authorization": "Bearer ${FFAppState().jwttoken}"},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to fetch balance: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return NavBarPage(currentPageName: "home",);
          }));

          return false;
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: isDarkMode ? Colors.black87 : const Color(0xFFF1F4F8),
          appBar: AppBar(
            backgroundColor: isDarkMode ? Colors.black : Colors.white,
            automaticallyImplyLeading: false,
            title: Column(
              children: [
                if (!FFAppState().isProvider)
                  Text(
                    'Мой кабинет',
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Plus Jakarta Sans',
                          color: isDarkMode ? Colors.white : const Color(0xFF14181B),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                if (FFAppState().isProvider)
                  Text(
                    'Кабинет поставщика',
                    style: TextStyle(
                          fontFamily: 'Futura',
                          color: isDarkMode ? Colors.white : const Color(0xFF14181B),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
              ],
            ),
            actions: const [],
            centerTitle: false,
            elevation: 0.0,
          ),
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (!_model.isLoading && !_model.tariffEist && FFAppState().isProvider)
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 20.0, 0.0, 0.0),
                          child: Text(
                            'Чтобы воспользоваться нашим сервисом, вам необходимо подключить тариф',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Readex Pro',
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: Text(
                            'Тарифы',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Readex Pro',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 8.0, 10.0, 0.0),
                          child: Text(
                            'После подключения тарифа ваш баланс будет пополнен на сумму стоимости тарифа',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Readex Pro',
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (FFAppState().isLogged)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 5.0, 0.0, 60.0),
                              child: FutureBuilder<ApiCallResponse>(
                                future: TariffGroup.getAllTariffsCall.call(
                                  jwtToken: FFAppState().jwttoken,
                                ),
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
                                  final listViewGetAllTariffsResponse =
                                  snapshot.data!;
                                  return Builder(
                                    builder: (context) {
                                      final tariff = getJsonField(
                                        listViewGetAllTariffsResponse
                                            .jsonBody,
                                        r'''$''',
                                      ).toList();
                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: tariff.length,
                                        itemBuilder:
                                            (context, tariffIndex) {
                                          final tariffItem =
                                          tariff[tariffIndex];
                                          return Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(
                                                20.0, 10.0, 20.0, 0.0),
                                            child: Container(
                                              width: 100.0,
                                              height: 150.0,
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme.of(
                                                    context)
                                                    .secondaryBackground,
                                              ),
                                              child: Column(
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0.0,
                                                        10.0,
                                                        0.0,
                                                        0.0),
                                                    child: Text(
                                                      getJsonField(
                                                        tariffItem,
                                                        r'''$.title''',
                                                      ).toString(),
                                                      style: FlutterFlowTheme
                                                          .of(context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily:
                                                        'Readex Pro',
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0.0,
                                                        10.0,
                                                        0.0,
                                                        0.0),
                                                    child: Text(
                                                      'Сумма пополнения согласно тарифному плану',
                                                      textAlign:
                                                      TextAlign.center,
                                                      style: FlutterFlowTheme
                                                          .of(context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily:
                                                        'Readex Pro',
                                                        fontSize: 14.0,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0.0,
                                                        10.0,
                                                        0.0,
                                                        0.0),
                                                    child: Text(
                                                      getJsonField(
                                                        tariffItem,
                                                        r'''$.sum''',
                                                      ).toString(),
                                                      style: FlutterFlowTheme
                                                          .of(context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily:
                                                        'Readex Pro',
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                  ),
                                                  Builder(
                                                    builder: (context) =>
                                                        Padding(
                                                          padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              0.0,
                                                              10.0,
                                                              0.0,
                                                              0.0),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              await showDialog(
                                                                context:
                                                                context,
                                                                builder:
                                                                    (dialogContext) {
                                                                  return Dialog(
                                                                    elevation:
                                                                    0,
                                                                    insetPadding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                    backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                    alignment: const AlignmentDirectional(
                                                                        0.0,
                                                                        0.0)
                                                                        .resolve(
                                                                        Directionality.of(context)),
                                                                    child:
                                                                    WebViewAware(
                                                                      child:
                                                                      GestureDetector(
                                                                        onTap: () => _model.unfocusNode.canRequestFocus
                                                                            ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                                            : FocusScope.of(context).unfocus(),
                                                                        child:
                                                                        ConnectTariffWidget(
                                                                          tariffName:
                                                                          getJsonField(
                                                                            tariffItem,
                                                                            r'''$.title''',
                                                                          ).toString(),
                                                                          tariffSum:
                                                                          getJsonField(
                                                                            tariffItem,
                                                                            r'''$.sum''',
                                                                          ).toString(),
                                                                          tariffId:
                                                                          getJsonField(
                                                                            tariffItem,
                                                                            r'''$.id''',
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ).then((value) =>
                                                                  setState(
                                                                          () {}));
                                                            },
                                                            text: 'Подключить',
                                                            options:
                                                            FFButtonOptions(
                                                              height: 40.0,
                                                              padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  24.0,
                                                                  0.0,
                                                                  24.0,
                                                                  0.0),
                                                              iconPadding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .primary,
                                                              textStyle:
                                                              FlutterFlowTheme.of(
                                                                  context)
                                                                  .titleSmall
                                                                  .override(
                                                                fontFamily:
                                                                'Readex Pro',
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              borderSide:
                                                              const BorderSide(
                                                                color: Colors
                                                                    .transparent,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  8.0),
                                                            ),
                                                          ),
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
                          ),
                      ],
                    ),
                  ),
                if (FFAppState().isLogged && !_model.isLoading && !FFAppState().isProvider && !FFAppState().isAdmin)
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 0.0),
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.white,
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
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(50.0),
                                        child: Image.asset(
                                          'assets/images/download-profile-user-round-orange-icon-symbol-png-11639594360ksf6tlhukf.png',
                                          width: 60.0,
                                          height: 60.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          getJsonField(
                                            FFAppState().accountInfo,
                                            r'''$.name''',
                                          ).toString(),
                                          style: const TextStyle(
                                            fontFamily: 'Atyp',
                                            color: Color(0xFF14181B),
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.w500,
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
                                                  FFAppState().accountInfo,
                                                  r'''$.surname''',
                                                ).toString(),
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily:
                                                  'Readex Pro',
                                                  color: Colors.black,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' ',
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily:
                                                  'Readex Pro',
                                                  color: Colors.black,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                              ),
                                              TextSpan(
                                                text: getJsonField(
                                                  FFAppState().accountInfo,
                                                  r'''$.patronymic''',
                                                ).toString(),
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily:
                                                  'Readex Pro',
                                                  color: Colors.black,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                              )
                                            ],
                                            style:
                                            FlutterFlowTheme.of(context)
                                                .bodyMedium,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0.0, 4.0, 0.0, 0.0),
                                          child: Text(
                                            getJsonField(
                                              FFAppState().accountInfo,
                                              r'''$.email''',
                                            ).toString(),
                                            style:
                                            FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                              fontFamily:
                                              'Plus Jakarta Sans',
                                              color:
                                              const Color(0xFF57636C),
                                              fontSize: 14.0,
                                              fontWeight:
                                              FontWeight.normal,
                                            ),
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
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 0.0, 0.0),
                          child: Text(
                            'Аккаунт',
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                              fontFamily: 'Plus Jakarta Sans',
                              color: const Color(0xFF57636C),
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        if (!FFAppState().isProvider)

                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                  return const DeliveryAddressesWidget();
                                }));
                              },
                              child: Container(
                                width: double.infinity,
                                height: 60.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 5.0,
                                      color: Color(0x3416202A),
                                      offset: Offset(0.0, 2.0),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(12.0),
                                  shape: BoxShape.rectangle,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.mapMarkerAlt,
                                        color: Color(0xFF57636C),
                                        size: 24.0,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                          child: Text('Адрес доставки',
                                            style:
                                            TextStyle(
                                              fontFamily: 'Gilroy',
                                              color:
                                              Color(0xFF14181B),
                                              fontSize: 16.0,
                                              fontWeight:
                                              FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                        AlignmentDirectional(0.9, 0.0),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0xFF57636C),
                                          size: 18.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                        if (!FFAppState().isProvider)
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                  return MyProfile();
                                }));
                              },
                              child: Container(
                                width: double.infinity,
                                height: 60.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 5.0,
                                      color: Color(0x3416202A),
                                      offset: Offset(0.0, 2.0),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(12.0),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Icon(
                                        Icons.person_2_outlined,
                                        color: Color(0xFF57636C),
                                        size: 24.0,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(
                                              12.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            'Мой профиль',
                                            style:
                                            FlutterFlowTheme.of(context)
                                                .bodyLarge
                                                .override(
                                              fontFamily:
                                              'Plus Jakarta Sans',
                                              color:
                                              const Color(0xFF14181B),
                                              fontSize: 16.0,
                                              fontWeight:
                                              FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Align(
                                        alignment:
                                        AlignmentDirectional(0.9, 0.0),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0xFF57636C),
                                          size: 18.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                        if (!FFAppState().isProvider)
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                  return const MyOrdersWidget();
                                }));
                              },
                              child: Container(
                                width: double.infinity,
                                height: 60.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 5.0,
                                      color: Color(0x3416202A),
                                      offset: Offset(0.0, 2.0),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(12.0),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Icon(
                                        Icons.shopping_cart_outlined,
                                        color: Color(0xFF57636C),
                                        size: 24.0,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            'Мои заказы',
                                            style:
                                            FlutterFlowTheme.of(context)
                                                .bodyLarge
                                                .override(
                                              fontFamily:
                                              'Plus Jakarta Sans',
                                              color:
                                              const Color(0xFF14181B),
                                              fontSize: 16.0,
                                              fontWeight:
                                              FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Align(
                                        alignment:
                                        AlignmentDirectional(0.9, 0.0),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0xFF57636C),
                                          size: 18.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (false)
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 0.0),
                            child: Container(
                              width: double.infinity,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0x3416202A),
                                    offset: Offset(0.0, 2.0),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(12.0),
                                shape: BoxShape.rectangle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Icon(
                                      Icons.account_circle_outlined,
                                      color: Color(0xFF57636C),
                                      size: 24.0,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          'Редактировать профиль',
                                          style:
                                          FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                            fontFamily:
                                            'Plus Jakarta Sans',
                                            color:
                                            const Color(0xFF14181B),
                                            fontSize: 16.0,
                                            fontWeight:
                                            FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Align(
                                      alignment:
                                      AlignmentDirectional(0.9, 0.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Color(0xFF57636C),
                                        size: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        if (false)
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 0.0),
                            child: Container(
                              width: double.infinity,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0x3416202A),
                                    offset: Offset(0.0, 2.0),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(12.0),
                                shape: BoxShape.rectangle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Icon(
                                      Icons.help_outline_rounded,
                                      color: Color(0xFF57636C),
                                      size: 24.0,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          'Support',
                                          style:
                                          FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                            fontFamily:
                                            'Plus Jakarta Sans',
                                            color:
                                            const Color(0xFF14181B),
                                            fontSize: 16.0,
                                            fontWeight:
                                            FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Align(
                                      alignment:
                                      AlignmentDirectional(0.9, 0.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Color(0xFF57636C),
                                        size: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        if (false)
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 0.0),
                            child: Container(
                              width: double.infinity,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0x3416202A),
                                    offset: Offset(0.0, 2.0),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(12.0),
                                shape: BoxShape.rectangle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Icon(
                                      Icons.privacy_tip_rounded,
                                      color: Color(0xFF57636C),
                                      size: 24.0,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          'Пользовательское соглашение',
                                          style:
                                          FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                            fontFamily:
                                            'Plus Jakarta Sans',
                                            color:
                                            const Color(0xFF14181B),
                                            fontSize: 16.0,
                                            fontWeight:
                                            FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Align(
                                      alignment:
                                      AlignmentDirectional(0.9, 0.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Color(0xFF57636C),
                                        size: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 12.0, 16.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              _model.actionExit =
                              await actions.deleteJwtTokenAction();
                              await actions.deleteAccessTokenAction();
                              await actions.deletePinCodeAction();
                              setState(() {
                                FFAppState().isLogged = false;
                                FFAppState().jwttoken = '';
                                FFAppState().accountInfo = null;
                                FFAppState().customerAddress = '';
                                FFAppState().addressid = 0;
                                FFAppState().isProvider = false;
                              });

                              setState(() {});
                            },
                            child: Container(
                              width: double.infinity,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0x3416202A),
                                    offset: Offset(0.0, 2.0),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(12.0),
                                shape: BoxShape.rectangle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Icon(
                                      Icons.exit_to_app,
                                      color: Color(0xFF57636C),
                                      size: 24.0,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          'Выйти из аккаунта',
                                          style:
                                          FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                            fontFamily:
                                            'Plus Jakarta Sans',
                                            color:
                                            const Color(0xFF14181B),
                                            fontSize: 16.0,
                                            fontWeight:
                                            FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Align(
                                      alignment:
                                      AlignmentDirectional(0.9, 0.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Color(0xFF57636C),
                                        size: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (false)
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 0.0),
                            child: Container(
                              width: double.infinity,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0x3416202A),
                                    offset: Offset(0.0, 2.0),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(12.0),
                                shape: BoxShape.rectangle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Icon(
                                      Icons.ios_share,
                                      color: Color(0xFF57636C),
                                      size: 24.0,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          'Invite Friends',
                                          style:
                                          FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                            fontFamily:
                                            'Plus Jakarta Sans',
                                            color:
                                            const Color(0xFF14181B),
                                            fontSize: 16.0,
                                            fontWeight:
                                            FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Color(0xFF57636C),
                                      size: 18.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                if (FFAppState().isLogged && !_model.isLoading && !FFAppState().isProvider && FFAppState().isAdmin)
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 0.0),
                            child: Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white,
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
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(50.0),
                                          child: Image.asset(
                                            'assets/images/download-profile-user-round-orange-icon-symbol-png-11639594360ksf6tlhukf.png',
                                            width: 60.0,
                                            height: 60.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 0.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            getJsonField(
                                              FFAppState().accountInfo,
                                              r'''$.name''',
                                            ).toString(),
                                            style: const TextStyle(
                                              fontFamily: 'Atyp',
                                              color: Color(0xFF14181B),
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.w500,
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
                                                    FFAppState().accountInfo,
                                                    r'''$.surname''',
                                                  ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'Readex Pro',
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' ',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'Readex Pro',
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: getJsonField(
                                                    FFAppState().accountInfo,
                                                    r'''$.patronymic''',
                                                  ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'Readex Pro',
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                )
                                              ],
                                              style:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 4.0, 0.0, 0.0),
                                            child: Text(
                                              getJsonField(
                                                FFAppState().accountInfo,
                                                r'''$.email''',
                                              ).toString(),
                                              style:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                fontFamily:
                                                'Plus Jakarta Sans',
                                                color:
                                                const Color(0xFF57636C),
                                                fontSize: 14.0,
                                                fontWeight:
                                                FontWeight.normal,
                                              ),
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
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 16.0, 0.0, 0.0),
                            child: Text(
                              'Аккаунт',
                              style: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: const Color(0xFF57636C),
                                fontSize: 16.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),

                          if (!FFAppState().isProvider && FFAppState().isAdmin)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                    return const AdminTariffPage();
                                  }));
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 5.0,
                                        color: Color(0x3416202A),
                                        offset: Offset(0.0, 2.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(12.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.moneyCheckDollar,
                                          color: Color(0xFF57636C),
                                          size: 24.0,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                            child: Text('Запросы тарифов',
                                              style:
                                              TextStyle(
                                                fontFamily: 'Gilroy',
                                                color:
                                                Color(0xFF14181B),
                                                fontSize: 16.0,
                                                fontWeight:
                                                FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional(0.9, 0.0),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Color(0xFF57636C),
                                            size: 18.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          if (!FFAppState().isProvider && FFAppState().isAdmin)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                    return const AdminProvidersPage();
                                  }));
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 5.0,
                                        color: Color(0x3416202A),
                                        offset: Offset(0.0, 2.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(12.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.briefcase,
                                          color: Color(0xFF57636C),
                                          size: 24.0,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                            child: Text('Поставщики',
                                              style:
                                              TextStyle(
                                                fontFamily: 'Gilroy',
                                                color:
                                                Color(0xFF14181B),
                                                fontSize: 16.0,
                                                fontWeight:
                                                FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional(0.9, 0.0),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Color(0xFF57636C),
                                            size: 18.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          if (!FFAppState().isProvider && FFAppState().isAdmin)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                    return const AdminRegionsPage();
                                  }));
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 5.0,
                                        color: Color(0x3416202A),
                                        offset: Offset(0.0, 2.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(12.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.building,
                                          color: Color(0xFF57636C),
                                          size: 24.0,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                            child: Text('Регионы',
                                              style:
                                              TextStyle(
                                                fontFamily: 'Gilroy',
                                                color:
                                                Color(0xFF14181B),
                                                fontSize: 16.0,
                                                fontWeight:
                                                FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional(0.9, 0.0),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Color(0xFF57636C),
                                            size: 18.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          if (!FFAppState().isProvider && FFAppState().isAdmin)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                    return const AdminContentPage();
                                  }));
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 5.0,
                                        color: Color(0x3416202A),
                                        offset: Offset(0.0, 2.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(12.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.layerGroup,
                                          color: Color(0xFF57636C),
                                          size: 24.0,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                            child: Text('Контент',
                                              style:
                                              TextStyle(
                                                fontFamily: 'Gilroy',
                                                color:
                                                Color(0xFF14181B),
                                                fontSize: 16.0,
                                                fontWeight:
                                                FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional(0.9, 0.0),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Color(0xFF57636C),
                                            size: 18.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          if (!FFAppState().isProvider && FFAppState().isAdmin)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                    return const AdminCitiesPage();
                                  }));
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 5.0,
                                        color: Color(0x3416202A),
                                        offset: Offset(0.0, 2.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(12.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.city,
                                          color: Color(0xFF57636C),
                                          size: 24.0,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                            child: Text('Города',
                                              style:
                                              TextStyle(
                                                fontFamily: 'Gilroy',
                                                color:
                                                Color(0xFF14181B),
                                                fontSize: 16.0,
                                                fontWeight:
                                                FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional(0.9, 0.0),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Color(0xFF57636C),
                                            size: 18.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          if (!FFAppState().isProvider && FFAppState().isAdmin)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                    return const AdminMagazinesPage();
                                  }));
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 5.0,
                                        color: Color(0x3416202A),
                                        offset: Offset(0.0, 2.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(12.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.shop,
                                          color: Color(0xFF57636C),
                                          size: 24.0,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                            child: Text('Магазины',
                                              style:
                                              TextStyle(
                                                fontFamily: 'Gilroy',
                                                color:
                                                Color(0xFF14181B),
                                                fontSize: 16.0,
                                                fontWeight:
                                                FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional(0.9, 0.0),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Color(0xFF57636C),
                                            size: 18.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          if (!FFAppState().isProvider && FFAppState().isAdmin)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                    return const AdminProductsPage();
                                  }));
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 5.0,
                                        color: Color(0x3416202A),
                                        offset: Offset(0.0, 2.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(12.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.boxesStacked,
                                          color: Color(0xFF57636C),
                                          size: 24.0,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                            child: Text('Товары',
                                              style:
                                              TextStyle(
                                                fontFamily: 'Gilroy',
                                                color:
                                                Color(0xFF14181B),
                                                fontSize: 16.0,
                                                fontWeight:
                                                FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional(0.9, 0.0),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Color(0xFF57636C),
                                            size: 18.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          if (!FFAppState().isProvider && FFAppState().isAdmin)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                    return const AdminOrdersPage();
                                  }));
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 5.0,
                                        color: Color(0x3416202A),
                                        offset: Offset(0.0, 2.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(12.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.layerGroup,
                                          color: Color(0xFF57636C),
                                          size: 24.0,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                            child: Text('Заказы',
                                              style:
                                              TextStyle(
                                                fontFamily: 'Gilroy',
                                                color:
                                                Color(0xFF14181B),
                                                fontSize: 16.0,
                                                fontWeight:
                                                FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional(0.9, 0.0),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Color(0xFF57636C),
                                            size: 18.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          if (!FFAppState().isProvider)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                    return MyProfile();
                                  }));
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 5.0,
                                        color: Color(0x3416202A),
                                        offset: Offset(0.0, 2.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(12.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.userTag,
                                          color: Color(0xFF57636C),
                                          size: 24.0,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(
                                                12.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'Мой профиль',
                                              style:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLarge
                                                  .override(
                                                fontFamily:
                                                'Plus Jakarta Sans',
                                                color:
                                                const Color(0xFF14181B),
                                                fontSize: 16.0,
                                                fontWeight:
                                                FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Align(
                                          alignment:
                                          AlignmentDirectional(0.9, 0.0),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Color(0xFF57636C),
                                            size: 18.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                _model.actionExit =
                                await actions.deleteJwtTokenAction();
                                await actions.deleteAccessTokenAction();
                                await actions.deletePinCodeAction();
                                setState(() {
                                  FFAppState().isLogged = false;
                                  FFAppState().jwttoken = '';
                                  FFAppState().accountInfo = null;
                                  FFAppState().customerAddress = '';
                                  FFAppState().addressid = 0;
                                  FFAppState().isProvider = false;
                                  FFAppState().isAdmin = false;
                                });

                                setState(() {});
                              },
                              child: Container(
                                width: double.infinity,
                                height: 60.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 5.0,
                                      color: Color(0x3416202A),
                                      offset: Offset(0.0, 2.0),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(12.0),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.rightFromBracket,
                                        color: Color(0xFF57636C),
                                        size: 24.0,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              12.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            'Выйти из аккаунта',
                                            style:
                                            FlutterFlowTheme.of(context)
                                                .bodyLarge
                                                .override(
                                              fontFamily:
                                              'Plus Jakarta Sans',
                                              color:
                                              const Color(0xFF14181B),
                                              fontSize: 16.0,
                                              fontWeight:
                                              FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Align(
                                        alignment:
                                        AlignmentDirectional(0.9, 0.0),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0xFF57636C),
                                          size: 18.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 20.0,)
                        ],
                      ),
                    ),
                  ),
                if (FFAppState().isLogged && !_model.isLoading && FFAppState().isProvider && _model.tariffEist)
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 20.0, top: 0),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/profile_bg.jpg',),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 3.0,
                                    color: Color(0x33000000),
                                    offset: Offset(0.0, 1.0),
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 80.0,
                                          height: 80.0,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(50.0),
                                              child: Image.asset(
                                                'assets/images/download-profile-user-round-orange-icon-symbol-png-11639594360ksf6tlhukf.png',
                                                width: 60.0,
                                                height: 60.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(width: 10.0,),

                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              getJsonField(
                                                FFAppState().accountInfo, r'''$.name''',
                                              ).toString().maybeHandleOverflow(maxChars: 20, replacement: '…',
                                              ),
                                              style: const TextStyle(
                                                fontFamily: 'Futura',
                                                color: Color(0xFF14181B),
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),

                                            const SizedBox(height: 5.0,),

                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                RichText(
                                                  textScaleFactor:
                                                  MediaQuery.of(context)
                                                      .textScaleFactor,
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: getJsonField(
                                                          FFAppState().accountInfo,
                                                          r'''$.surname''',
                                                        ).toString(),
                                                        style: const TextStyle(
                                                          fontFamily: 'Futura',
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 15.0
                                                        ),
                                                      ),
                                                      const TextSpan(
                                                        text: ' ',
                                                        style: TextStyle(
                                                          fontFamily: 'Gilroy',
                                                          color: Colors.black,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontSize: 15.0
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: getJsonField(
                                                          FFAppState().accountInfo,
                                                          r'''$.patronymic''',
                                                        ).toString(),
                                                        style: const TextStyle(
                                                          fontFamily: 'Futura',
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 15.0
                                                        ),
                                                      )
                                                    ],
                                                    style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium,
                                                  ),
                                                ),
                                                const SizedBox(width: 5.0,),
                                                const Icon(Icons.check_circle_sharp, color: Colors.green, size: 15.0,)
                                              ],
                                            ),
                                            FutureBuilder(
                                              future: fetchBalance(),
                                              builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                  return const Text("Баланс: 0 тг", style: TextStyle(
                                                    fontFamily: 'Futura'
                                                  ),);
                                                } else if (snapshot.hasError) {
                                                  return Center(child: Text('Error: ${snapshot.error}'));
                                                } else {
                                                  double balance = snapshot.data!['balance'];
                                                  return Text('Баланс: $balance тг', style: const TextStyle(
                                                      fontFamily: 'Futura',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15.0
                                                  ),);
                                                }
                                              },
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )

                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 16.0, 0.0, 0.0),
                              child: Text(
                                'Аккаунт',
                                style: TextStyle(
                                  fontFamily: 'Futura',
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            if (FFAppState().isProvider)
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                      return MyProfile();
                                    }));
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 5.0,
                                          color: Color(0x3416202A),
                                          offset: Offset(0.0, 2.0),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(12.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          const Icon(
                                            Icons.person_2_outlined,
                                            color: Color(0xFF57636C),
                                            size: 24.0,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  12.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'Мой профиль',
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLarge
                                                    .override(
                                                  fontFamily:
                                                  'Plus Jakarta Sans',
                                                  color:
                                                  const Color(0xFF14181B),
                                                  fontSize: 16.0,
                                                  fontWeight:
                                                  FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Align(
                                            alignment:
                                            AlignmentDirectional(0.9, 0.0),
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              color: Color(0xFF57636C),
                                              size: 18.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (FFAppState().isProvider)
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                      return CategoryWidget();
                                    }));
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 5.0,
                                          color: Color(0x3416202A),
                                          offset: Offset(0.0, 2.0),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(12.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          const Icon(
                                            Icons.manage_search_rounded,
                                            color: Color(0xFF57636C),
                                            size: 24.0,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'Категории',
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLarge
                                                    .override(
                                                  fontFamily:
                                                  'Plus Jakarta Sans',
                                                  color:
                                                  const Color(0xFF14181B),
                                                  fontSize: 16.0,
                                                  fontWeight:
                                                  FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Align(
                                            alignment:
                                            AlignmentDirectional(0.9, 0.0),
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              color: Color(0xFF57636C),
                                              size: 18.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (FFAppState().isProvider)
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                      return BrandsPageWidget();
                                    }));
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 5.0,
                                          color: Color(0x3416202A),
                                          offset: Offset(0.0, 2.0),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(12.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          const Icon(
                                            Icons.manage_search_rounded,
                                            color: Color(0xFF57636C),
                                            size: 24.0,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'Бренды',
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLarge
                                                    .override(
                                                  fontFamily:
                                                  'Plus Jakarta Sans',
                                                  color:
                                                  const Color(0xFF14181B),
                                                  fontSize: 16.0,
                                                  fontWeight:
                                                  FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Align(
                                            alignment:
                                            AlignmentDirectional(0.9, 0.0),
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              color: Color(0xFF57636C),
                                              size: 18.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (FFAppState().isProvider)
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                      return ProvidersOrdersWidget();
                                    }));
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 5.0,
                                          color: Color(0x3416202A),
                                          offset: Offset(0.0, 2.0),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(12.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          const Icon(
                                            Icons.shopping_cart_outlined,
                                            color: Color(0xFF57636C),
                                            size: 24.0,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  12.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'Заказы',
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLarge
                                                    .override(
                                                  fontFamily:
                                                  'Plus Jakarta Sans',
                                                  color:
                                                  const Color(0xFF14181B),
                                                  fontSize: 16.0,
                                                  fontWeight:
                                                  FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Align(
                                            alignment:
                                            AlignmentDirectional(0.9, 0.0),
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              color: Color(0xFF57636C),
                                              size: 18.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (FFAppState().isProvider)
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 12.0, 16.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                      return const ProvidersProductsWidget();
                                    }));
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 5.0,
                                          color: Color(0x3416202A),
                                          offset: Offset(0.0, 2.0),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(12.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.list_sharp,
                                            color: Color(0xFF57636C),
                                            size: 24.0,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'Мой товары',
                                                style: TextStyle(fontFamily: 'Gilroy',
                                                  color: Color(0xFF14181B),
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: AlignmentDirectional(0.9, 0.0),
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              color: Color(0xFF57636C),
                                              size: 18.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (FFAppState().isProvider)
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 12.0, 16.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                      return ProvidersPromotionsWidget();
                                    }));
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 5.0,
                                          color: Color(0x3416202A),
                                          offset: Offset(0.0, 2.0),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(12.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          const Icon(
                                            Icons.apps,
                                            color: Color(0xFF57636C),
                                            size: 24.0,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  12.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'Мои акции',
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLarge
                                                    .override(
                                                  fontFamily:
                                                  'Plus Jakarta Sans',
                                                  color:
                                                  const Color(0xFF14181B),
                                                  fontSize: 16.0,
                                                  fontWeight:
                                                  FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Align(
                                            alignment:
                                            AlignmentDirectional(0.9, 0.0),
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              color: Color(0xFF57636C),
                                              size: 18.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (FFAppState().isProvider)
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 12.0, 16.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {

                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                      return MyTariffWidget();
                                    }));

                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 5.0,
                                          color: Color(0x3416202A),
                                          offset: Offset(0.0, 2.0),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(12.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          const Icon(
                                            Icons.apps,
                                            color: Color(0xFF57636C),
                                            size: 24.0,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  12.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'Мои тарифы',
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLarge
                                                    .override(
                                                  fontFamily:
                                                  'Plus Jakarta Sans',
                                                  color:
                                                  const Color(0xFF14181B),
                                                  fontSize: 16.0,
                                                  fontWeight:
                                                  FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Align(
                                            alignment:
                                            AlignmentDirectional(0.9, 0.0),
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              color: Color(0xFF57636C),
                                              size: 18.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (FFAppState().isProvider)
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                      return ChangeCityWidget();
                                    }));
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 5.0,
                                          color: Color(0x3416202A),
                                          offset: Offset(0.0, 2.0),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(12.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          const Icon(
                                            Icons.location_city,
                                            color: Color(0xFF57636C),
                                            size: 24.0,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  12.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'Мои города',
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLarge
                                                    .override(
                                                  fontFamily:
                                                  'Plus Jakarta Sans',
                                                  color:
                                                  const Color(0xFF14181B),
                                                  fontSize: 16.0,
                                                  fontWeight:
                                                  FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Align(
                                            alignment:
                                            AlignmentDirectional(0.9, 0.0),
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              color: Color(0xFF57636C),
                                              size: 18.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (false)
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 12.0, 16.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 5.0,
                                        color: Color(0x3416202A),
                                        offset: Offset(0.0, 2.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(12.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const Icon(
                                          Icons.account_circle_outlined,
                                          color: Color(0xFF57636C),
                                          size: 24.0,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                12.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'Редактировать профиль',
                                              style:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLarge
                                                  .override(
                                                fontFamily:
                                                'Plus Jakarta Sans',
                                                color:
                                                const Color(0xFF14181B),
                                                fontSize: 16.0,
                                                fontWeight:
                                                FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Align(
                                          alignment:
                                          AlignmentDirectional(0.9, 0.0),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Color(0xFF57636C),
                                            size: 18.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            if (false)
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 12.0, 16.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 5.0,
                                        color: Color(0x3416202A),
                                        offset: Offset(0.0, 2.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(12.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const Icon(
                                          Icons.help_outline_rounded,
                                          color: Color(0xFF57636C),
                                          size: 24.0,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                12.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'Support',
                                              style:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLarge
                                                  .override(
                                                fontFamily:
                                                'Plus Jakarta Sans',
                                                color:
                                                const Color(0xFF14181B),
                                                fontSize: 16.0,
                                                fontWeight:
                                                FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Align(
                                          alignment:
                                          AlignmentDirectional(0.9, 0.0),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Color(0xFF57636C),
                                            size: 18.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            if (false)
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 12.0, 16.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 5.0,
                                        color: Color(0x3416202A),
                                        offset: Offset(0.0, 2.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(12.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const Icon(
                                          Icons.privacy_tip_rounded,
                                          color: Color(0xFF57636C),
                                          size: 24.0,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                12.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'Пользовательское соглашение',
                                              style:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLarge
                                                  .override(
                                                fontFamily:
                                                'Plus Jakarta Sans',
                                                color:
                                                const Color(0xFF14181B),
                                                fontSize: 16.0,
                                                fontWeight:
                                                FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Align(
                                          alignment:
                                          AlignmentDirectional(0.9, 0.0),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Color(0xFF57636C),
                                            size: 18.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16.0, 12.0, 16.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.actionExitProvider =
                                  await actions.deleteJwtTokenAction();
                                  await actions.deleteAccessTokenAction();
                                  await actions.deletePinCodeAction();
                                  setState(() {
                                    FFAppState().isLogged = false;
                                    FFAppState().jwttoken = '';
                                    FFAppState().accountInfo = null;
                                    FFAppState().customerAddress = '';
                                    FFAppState().addressid = 0;
                                    FFAppState().isProvider = false;
                                  });

                                  setState(() {});
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 5.0,
                                        color: Color(0x3416202A),
                                        offset: Offset(0.0, 2.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(12.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const Icon(
                                          Icons.exit_to_app,
                                          color: Color(0xFF57636C),
                                          size: 24.0,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                12.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'Выйти из аккаунта',
                                              style:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLarge
                                                  .override(
                                                fontFamily:
                                                'Plus Jakarta Sans',
                                                color:
                                                const Color(0xFF14181B),
                                                fontSize: 16.0,
                                                fontWeight:
                                                FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Align(
                                          alignment:
                                          AlignmentDirectional(0.9, 0.0),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Color(0xFF57636C),
                                            size: 18.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (false)
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 12.0, 16.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 5.0,
                                        color: Color(0x3416202A),
                                        offset: Offset(0.0, 2.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(12.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const Icon(
                                          Icons.ios_share,
                                          color: Color(0xFF57636C),
                                          size: 24.0,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                12.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'Invite Friends',
                                              style:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLarge
                                                  .override(
                                                fontFamily:
                                                'Plus Jakarta Sans',
                                                color:
                                                const Color(0xFF14181B),
                                                fontSize: 16.0,
                                                fontWeight:
                                                FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0xFF57636C),
                                          size: 18.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (!FFAppState().isLogged)
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 150.0, 0.0, 0.0),
                              child: Container(
                                width: 350.0,
                                height: 100.0,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'Вы не авторизованы, для совершения покупок войдите в свой аккаунт или зарегистрируйтесь!',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Readex Pro',
                                    color: const Color(0xFF14181B),
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20.0, 20.0, 20.0, 16.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                return LoginWidget();
                              }));
                            },
                            text: 'Войти',
                            options: FFButtonOptions(
                              width: 370.0,
                              height: 44.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: const Color(0xFFFCA522),
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                              elevation: 3.0,
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 16.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                return RegistrationPageWidget();
                              }));
                            },
                            text: 'Регистрация',
                            options: FFButtonOptions(
                              width: 370.0,
                              height: 44.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: const Color(0xFFFCA522),
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                              elevation: 3.0,
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (_model.isLoading && FFAppState().isLogged)
                  Expanded(
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context)
                            .secondaryBackground,
                      ),
                      child: Visibility(
                        visible: _model.isLoading && FFAppState().isLogged,
                        child: Padding(
                          padding: const EdgeInsets.all(130.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/Spinner-1s-283px.gif',
                              width: 200.0,
                              height: 200.0,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
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
