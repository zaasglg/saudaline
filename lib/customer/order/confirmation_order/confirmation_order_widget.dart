import 'dart:convert';

import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sauda_line/custom_code/actions/custom_date_picker.dart';
import 'package:sauda_line/customer/address/select_address/select_address_widget.dart';
import 'package:sauda_line/customer/order/my_orders/my_orders_widget.dart';
import 'package:sauda_line/main.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'confirmation_order_model.dart';
export 'confirmation_order_model.dart';
import 'package:http/http.dart' as http;

class ConfirmationOrderWidget extends StatefulWidget {
  const ConfirmationOrderWidget({super.key});

  @override
  State<ConfirmationOrderWidget> createState() =>
      _ConfirmationOrderWidgetState();
}

class _ConfirmationOrderWidgetState extends State<ConfirmationOrderWidget> {
  late ConfirmationOrderModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _model = createModel(context, () => ConfirmationOrderModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return WillPopScope(
      onWillPop: () async {

        FFAppState().customerAddress = "";
        FFAppState().addressid = 0;

        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return NavBarPage(currentPageName: "cart",);
        }));

        return false;
      },
      child: GestureDetector(
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
              'Подтверждение заказа',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Readex Pro',
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            actions: [],
            centerTitle: true,
            elevation: 4.0,
          ),
          body: SafeArea(
            top: true,
            child: Column(

              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [

                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: Container(
                              width: double.infinity,
                              height: 25.0,
                              decoration: const BoxDecoration(),
                              alignment: const AlignmentDirectional(-1.0, -1.0),
                              child: Text(
                                'Адрес доставки',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 5.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                  return SelectAddressWidget();
                                }));

                                setState(() {});
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 320.0,
                                              height: 35.0,
                                              decoration: const BoxDecoration(),
                                              alignment: const AlignmentDirectional(-1.0, 0.0),
                                              child: AutoSizeText(
                                                valueOrDefault<String>(
                                                  FFAppState().customerAddress,
                                                  'Выберите адрес доставки',
                                                ),
                                                style: TextStyle(fontFamily: 'Readex Pro', fontSize: 16.0,),
                                                minFontSize: 14.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_right,
                                          color: FlutterFlowTheme.of(context).secondaryText,
                                          size: 24.0,
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 1.0,
                                      color: Color(0xCC9E9E9E),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Container(
                            width: double.infinity,
                            height: 25.0,
                            decoration: const BoxDecoration(),
                            alignment: const AlignmentDirectional(-1.0, -1.0),
                            child: Text(
                              'Дата и время доставки',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              _model.customDatePicker = await customDatePicker(context);
                              setState(() {});
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            width: 320.0,
                                            height: 30.0,
                                            decoration: const BoxDecoration(),
                                            alignment: const AlignmentDirectional(-1.0, 0.0),
                                            child: AutoSizeText(
                                              valueOrDefault<String>(
                                                dateTimeFormat('dd-MM-y', _model.customDatePicker),
                                                "Выберите дату",
                                              ),
                                              style: TextStyle(
                                                fontFamily: 'Futura',
                                                fontSize: 16.0,
                                              ),
                                              minFontSize: 14.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_right,
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                        size: 24.0,
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 1.0,
                                    color: Color(0xCC9E9E9E),
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
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(15.0, 10.0, 10.0, 10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 140.0,
                            height: 100.0,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Заказ на сумму',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: const Color(0xFF14181B),
                                      ),
                                ),
                                RichText(
                                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: valueOrDefault<String>(functions.getTotalSumWithDiscount(FFAppState().basketProducts.toList()), '0',),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color: FlutterFlowTheme.of(context).primary,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      TextSpan(
                                        text: '  ₸',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                        ),
                                      )
                                    ],
                                    style:
                                        FlutterFlowTheme.of(context).bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 190.0,
                            height: 50.0,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: FFButtonWidget(
                              onPressed: () async {

                                _model.apiResultq9w =
                                await OrderGroup.makeOrderCall.call(
                                  ordersJson: functions.cardToOrderRequest(FFAppState().basketProducts.toList()),
                                  jwtToken: FFAppState().jwttoken,
                                  addressId: FFAppState().addressid ?? 4,
                                  date: _model.customDatePicker?.toString() ?? DateFormat('dd-MM-y').format(DateTime.now()),
                                );
                                if ((_model.apiResultq9w?.succeeded ?? true)) {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return WebViewAware(
                                        child: AlertDialog(
                                          title: const Text('Заказ успешно оформлен'),
                                          content: const Text('Спасибо за заказ! Вы можете отслеживать свой заказ в личном кабинете'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: const Text('Ок'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                  setState(() {
                                    FFAppState().cardProducts = [];
                                    FFAppState().cardProviders = [];
                                    FFAppState().basketProducts = [];
                                    FFAppState().customerAddress = "";
                                    FFAppState().addressid = 0;

                                  });

                                  // context.pushNamed('myOrders');
                                  // pushNewScreen(context, screen: const MyOrdersWidget());
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                    return const MyOrdersWidget();
                                  }));
                                } else {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return WebViewAware(
                                        child: AlertDialog(
                                          title: const Text('Ошибка'),
                                          content: const Text("Выберите дата и время доставки"),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: const Text('Ok'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }

                                setState(() {});
                              },
                              text: 'Оформить',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 50.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: TextStyle(
                                      fontFamily: 'Gilroy',
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                elevation: 3.0,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                              ),
                            ),
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
    );
  }
}
