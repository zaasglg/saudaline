import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sauda_line/index.dart';
import 'package:sauda_line/main.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'connect_tariff_model.dart';
export 'connect_tariff_model.dart';

class ConnectTariffWidget extends StatefulWidget {
  const ConnectTariffWidget({
    super.key,
    required this.tariffName,
    required this.tariffSum,
    required this.tariffId,
  });

  final String? tariffName;
  final String? tariffSum;
  final int? tariffId;

  @override
  State<ConnectTariffWidget> createState() => _ConnectTariffWidgetState();
}

class _ConnectTariffWidgetState extends State<ConnectTariffWidget> {
  late ConnectTariffModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ConnectTariffModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      height: 400.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
            color: Color(0x3B1D2429),
            offset: Offset(0.0, -3.0),
          )
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
              child: Text(
                'Подключение тарифа',
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
                    text: 'Выбранный вами тариф: ',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          color: Color(0xFF14181B),
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  TextSpan(
                    text: valueOrDefault<String>(
                      widget.tariffName,
                      'Тариф не выбрана',
                    ),
                    style: TextStyle(
                      color: Color(0xFFFCA522),
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
                style: FlutterFlowTheme.of(context).bodyMedium,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
              child: RichText(
                textScaleFactor: MediaQuery.of(context).textScaleFactor,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Сумма к оплате: ',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFF14181B),
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                    TextSpan(
                      text: valueOrDefault<String>(
                        widget.tariffSum,
                        'Тариф не выбрана',
                      ),
                      style: TextStyle(
                        color: Color(0xFFFCA522),
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
              child: Text(
                'Введите номер, который зарегистрирован в Kaspi Bank, по этому номеру мы вышлем счет на оплату',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Readex Pro',
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ),
            TextFormField(
              controller: _model.textController,
              focusNode: _model.textFieldFocusNode,
              autofocus: true,
              obscureText: false,
              decoration: InputDecoration(
                labelStyle: FlutterFlowTheme.of(context).labelMedium,
                hintStyle: FlutterFlowTheme.of(context).labelMedium,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFFCA522),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primary,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).error,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).error,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              style: FlutterFlowTheme.of(context).bodyMedium,
              keyboardType: TextInputType.phone,
              validator: _model.textControllerValidator.asValidator(context),
              inputFormatters: [_model.textFieldMask],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: FFButtonWidget(
                onPressed: () async {
                  if (_model.textController.text.isNotEmpty) {
                    _model.apiResultcb9 = await TariffGroup.postTarifRequestCall.call(
                      jwtToken: FFAppState().jwttoken,
                      tariffId: widget.tariffId,
                      tel: _model.textController.text,
                    );
                    if ((_model.apiResultcb9?.succeeded ?? true)) {
                      await showDialog(
                        context: context,
                        builder: (alertDialogContext) {
                          return WebViewAware(
                            child: AlertDialog(
                              title: Text('Ваша заявка успешно отправлено!'),
                              content: Text(
                                  'В ближайшее время с вами свяжется наш менеджер, вы получите счет на оплату. После успешной оплаты вам будет доступен наш сервис'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext),
                                  child: Text('Oк'),
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
                              title: Text('Ошибка при запросе'),
                              content: Text('Повторите позже'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext),
                                  child: Text('Oк'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }

                    Navigator.pop(context);

                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return NavBarPage(currentPageName: "profile",);
                    }));

                    setState(() {});
                  }
                },
                text: 'Отправить заявку',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 60.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  textStyle: FlutterFlowTheme.of(context).bodyLarge,
                  elevation: 2.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: FFButtonWidget(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                text: 'Отмена',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 60.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Lexend Deca',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                      ),
                  elevation: 0.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 0.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
