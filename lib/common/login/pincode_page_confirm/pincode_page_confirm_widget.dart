import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sauda_line/index.dart';
import 'package:sauda_line/main.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'pincode_page_confirm_model.dart';
export 'pincode_page_confirm_model.dart';

class PincodePageConfirmWidget extends StatefulWidget {
  const PincodePageConfirmWidget({
    super.key,
    required this.pincode,
    this.currentPageName
  });

  final String? pincode;
  final String? currentPageName;

  @override
  State<PincodePageConfirmWidget> createState() =>
      _PincodePageConfirmWidgetState();
}

class _PincodePageConfirmWidgetState extends State<PincodePageConfirmWidget> {
  late PincodePageConfirmModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PincodePageConfirmModel());
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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          title: Text(
            'PIN-код',
            style: FlutterFlowTheme.of(context).bodyMedium,
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Повторите PIN-код',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily: 'Outfit',
                          fontSize: 18.0,
                        ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(44.0, 8.0, 44.0, 0.0),
                    child: Text(
                      'Этот код помогает сохранить вашу учетную запись в безопасности.',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodySmall,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                    child: PinCodeTextField(
                      autoDisposeControllers: false,
                      appContext: context,
                      length: 4,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).primary,
                              ),
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      enableActiveFill: false,
                      autoFocus: true,
                      enablePinAutofill: false,
                      errorTextSpace: 0.0,
                      showCursor: true,
                      cursorColor: FlutterFlowTheme.of(context).primary,
                      obscureText: false,
                      hintCharacter: '-',
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                        fieldHeight: 60.0,
                        fieldWidth: 60.0,
                        borderWidth: 2.0,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0),
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                        ),
                        shape: PinCodeFieldShape.box,
                        activeColor: FlutterFlowTheme.of(context).primary,
                        inactiveColor: FlutterFlowTheme.of(context).primaryBackground,
                        selectedColor: FlutterFlowTheme.of(context).secondaryText,
                        activeFillColor: FlutterFlowTheme.of(context).primary,
                        inactiveFillColor: FlutterFlowTheme.of(context).primaryBackground,
                        selectedFillColor: FlutterFlowTheme.of(context).secondaryText,
                      ),
                      controller: _model.pinCodeController,
                      onChanged: (_) {},
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: _model.pinCodeControllerValidator
                          .asValidator(context),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 44.0),
              child: FFButtonWidget(
                onPressed: () async {
                  if (_model.pinCodeController!.text == widget.pincode) {
                    _model.pinSaved = await actions.savePincode(
                      widget.pincode!,
                    );

                    if (_model.pinSaved!) {
                      // Navigator.pushReplacement(context, newRoute)<dynamic>(context,
                      //   MaterialPageRoute<dynamic>(
                      //     builder: (BuildContext context) => ProfileWidget(),
                      //   ), (route) => false
                      // );

                      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                      //   return const ProfileWidget();
                      // }));

                      if (widget.currentPageName == "cart") {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                          return ConfirmationOrderWidget();
                        }));
                      } else {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                          return NavBarPage(currentPageName: "profile");
                        }));
                      }

                      // context.pushNamed('Profile');
                    } else {
                      await showDialog(
                        context: context,
                        builder: (alertDialogContext) {
                          return WebViewAware(
                            child: AlertDialog(
                              title: Text('Ошибка'),
                              content: Text('Ошибка при сохранении PIN-кода'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(alertDialogContext),
                                  child: Text('Oк'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  } else {
                    await showDialog(
                      context: context,
                      builder: (alertDialogContext) {
                        return WebViewAware(
                          child: AlertDialog(
                            title: Text('Ошибка'),
                            content: Text('PIN-коды не совпадают'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(alertDialogContext),
                                child: Text('Oк'),
                              ),
                            ],
                          ),
                        );
                      },
                    );

                    // context.pushNamed('PincodePage');
                    // pushNewScreen(context, screen: PincodePageWidget());
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return const PincodePageWidget();
                    }));
                  }

                  setState(() {});
                },
                text: 'Подтвердить',
                options: FFButtonOptions(
                  width: 150.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primaryText,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Readex Pro',
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                  elevation: 2.0,
                  borderSide: BorderSide(
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
    );
  }
}
