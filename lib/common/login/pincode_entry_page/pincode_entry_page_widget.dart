import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sauda_line/index.dart';
import 'package:sauda_line/main.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'pincode_entry_page_model.dart';
export 'pincode_entry_page_model.dart';

class PincodeEntryPageWidget extends StatefulWidget {
  const PincodeEntryPageWidget({super.key});

  @override
  State<PincodeEntryPageWidget> createState() => _PincodeEntryPageWidgetState();
}

class _PincodeEntryPageWidgetState extends State<PincodeEntryPageWidget> {
  late PincodeEntryPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PincodeEntryPageModel());
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
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  width: double.infinity,
                  height: 140.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0),
                      topLeft: Radius.circular(0.0),
                      topRight: Radius.circular(0.0),
                    ),
                  ),
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/logo-black.3dd0c1b45c67d12b1064a6cd9bc8bca3.png',
                      width: 300.0,
                      height: 200.0,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Введите PIN-код',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'Outfit',
                        fontSize: 18.0,
                      ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                  child: PinCodeTextField(
                    autoDisposeControllers: false,
                    appContext: context,
                    length: 4,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
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
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0),
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      ),
                      shape: PinCodeFieldShape.box,
                      activeColor: FlutterFlowTheme.of(context).primary,
                      inactiveColor:
                          FlutterFlowTheme.of(context).primaryBackground,
                      selectedColor: FlutterFlowTheme.of(context).secondaryText,
                      activeFillColor: FlutterFlowTheme.of(context).primary,
                      inactiveFillColor:
                          FlutterFlowTheme.of(context).primaryBackground,
                      selectedFillColor:
                          FlutterFlowTheme.of(context).secondaryText,
                    ),
                    controller: _model.pinCodeController,
                    onChanged: (_) {},
                    onCompleted: (_) async {
                      _model.pinCode = await actions.getPinCode();
                      if (_model.pinCodeController!.text == _model.pinCode) {
                        _model.accesssToken = await actions.getAccessToken();
                        if (_model.accesssToken != null &&
                            _model.accesssToken != '') {
                          _model.apiResultjwtTokenResult =
                              await LoginAndRegistrationGroup
                                  .getJwtTokenByAccessTokenCall
                                  .call(
                            refreshToken: _model.accesssToken,
                          );
                          if ((_model.apiResultjwtTokenResult?.succeeded ?? true)) {
                            setState(() {
                              FFAppState().isLogged = true;
                              FFAppState().jwttoken = (_model
                                      .apiResultjwtTokenResult
                                      ?.getHeader('jwt-token') ??
                                  '');
                            });
                            _model.apiResultnUserInfo =
                                await LoginAndRegistrationGroup.getUserInfoCall.call(jwtToken: FFAppState().jwttoken,
                            );
                            if ((_model.apiResultnUserInfo?.succeeded ??
                                true)) {
                              setState(() {
                                FFAppState().accountInfo =
                                    (_model.apiResultnUserInfo?.jsonBody ?? '');
                              });
                              if (LoginAndRegistrationGroup.getUserInfoCall.roleId((_model.apiResultnUserInfo?.jsonBody ?? ''),) == 3) {
                                setState(() {
                                  FFAppState().isProvider = true;
                                });
                              } else if (LoginAndRegistrationGroup.getUserInfoCall.roleId((_model.apiResultnUserInfo?.jsonBody ?? ''),) == 4) {
                                FFAppState().isProvider = false;
                                FFAppState().isAdmin = true;
                              } else {
                                setState(() {
                                  FFAppState().isProvider = false;
                                });
                              }

                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                                return NavBarPage(currentPageName: "profile");
                              }));

                            } else {
                              setState(() {
                                FFAppState().accountInfo = null;
                              });
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return WebViewAware(
                                    child: AlertDialog(
                                      title: Text('Ошибка'),
                                      content: Text('Ошибка входа в систему'),
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

                              // context.pushNamed('Login');
                              pushNewScreen(context, screen: LoginWidget());
                            }
                          } else {
                            // context.pushNamed('Login');
                            pushNewScreen(context, screen: LoginWidget());
                          }
                        } else {
                          setState(() {
                            FFAppState().isLogged = false;
                            FFAppState().accountInfo = null;
                            FFAppState().jwttoken = '';
                            FFAppState().isProvider = false;
                          });

                          // context.pushNamed('Login');
                          pushNewScreen(context, screen: LoginWidget());
                        }
                      } else {
                        await showDialog(
                          context: context,
                          builder: (alertDialogContext) {
                            return WebViewAware(
                              child: AlertDialog(
                                title: Text('Ошибка'),
                                content: Text('Неправильный PIN код'),
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
                        setState(() {
                          FFAppState().isLogged = false;
                          FFAppState().accountInfo = null;
                          FFAppState().jwttoken = '';
                        });

                        context.pushNamed('Login');
                        // pushNewScreen(context, screen: LoginWidget());
                      }

                      setState(() {});
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: _model.pinCodeControllerValidator.asValidator(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
