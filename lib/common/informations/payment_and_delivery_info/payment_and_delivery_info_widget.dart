import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'payment_and_delivery_info_model.dart';
export 'payment_and_delivery_info_model.dart';

class PaymentAndDeliveryInfoWidget extends StatefulWidget {
  const PaymentAndDeliveryInfoWidget({super.key});

  @override
  State<PaymentAndDeliveryInfoWidget> createState() =>
      _PaymentAndDeliveryInfoWidgetState();
}

class _PaymentAndDeliveryInfoWidgetState
    extends State<PaymentAndDeliveryInfoWidget> {
  late PaymentAndDeliveryInfoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaymentAndDeliveryInfoModel());
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
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: true,
          title: Text(
            'SaudaLine',
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
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10.0, 15.0, 10.0, 10.0),
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                  child: Text(
                    'Оплата и доставка',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'SaudaLine',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      TextSpan(
                        text:
                            '-  предоставляет удобный интерфейс для владельца магазина, поставщика и дистрибьютора. Зарегистрируйтесь на главной странице сервиса или в мобильном приложении – на этой уйдет не больше одной минуты. После регистрации Вы получите следующие возможности:\nБесплатный доступ к каталогу поставщиков с указанием точных цен на товары.\nПолучение прямых заказов от магазинов, для обеспечения стабильных продаж.\nПросмотр статистики по рынку сбыта и поиск потенциальных клиентов для бизнеса.\nВладельцы торговых точек получают возможность просматривать список поставщиков с ценами, условиями сотрудничества и другими параметрами, которые играют главную роль при выборе партнера.\nПоставщики могут просматривать список актуальных заказов от владельцев магазинов, и не тратить время на самостоятельный поиск магазинов. Сайт оптовиков «MDB.kz» сильно упрощает работу обеим сторонам.',
                        style: TextStyle(),
                      )
                    ],
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          fontSize: 15.0,
                          lineHeight: 2.0,
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
