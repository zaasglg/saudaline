import 'package:sauda_line/main.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

import 'registration_page_model.dart';
export 'registration_page_model.dart';

class RegistrationPageWidget extends StatefulWidget {
  const RegistrationPageWidget({super.key});

  @override
  State<RegistrationPageWidget> createState() => _RegistrationPageWidgetState();
}

class _RegistrationPageWidgetState extends State<RegistrationPageWidget> {
  late RegistrationPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RegistrationPageModel());

    _model.businessNameTextController ??= TextEditingController();
    _model.businessNameFocusNode ??= FocusNode();

    _model.businessNumberTextController ??= TextEditingController();
    _model.businessNumberFocusNode ??= FocusNode();

    _model.addressTextController ??= TextEditingController();
    _model.addressFocusNode ??= FocusNode();

    _model.nameTextController ??= TextEditingController();
    _model.nameFocusNode ??= FocusNode();

    _model.surnameTextController ??= TextEditingController();
    _model.surnameFocusNode ??= FocusNode();

    _model.emailTextController ??= TextEditingController();
    _model.emailFocusNode ??= FocusNode();

    _model.phoneNumberTextController ??= TextEditingController();
    _model.phoneNumberFocusNode ??= FocusNode();

    _model.loginTextController ??= TextEditingController();
    _model.loginFocusNode ??= FocusNode();

    _model.passwordTextController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: FlutterFlowTheme.of(context).primary,
            size: 30,
          ),
          onPressed: () async {
            context.pop();
          },
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        top: true,
        child: Form(
          key: _model.formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
              child: ListView(
                padding: EdgeInsets.zero,
                primary: false,
                scrollDirection: Axis.vertical,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Регистрация',
                          style:
                          FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily: 'Readex Pro',
                            fontSize: 18,
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Данные организации',
                          style:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            fontSize: 16,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              setState(() {
                                FFAppState().isProvider = false;
                                FFAppState().typeBusiness = 'Магазин';
                              });
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              height: 70,
                              decoration: BoxDecoration(
                                color: FFAppState().isProvider
                                    ? Color(0x9B7E7E7E)
                                    : Color(0xC06C5DF6),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_basket,
                                    color: () {
                                      if (FFAppState().isProvider) {
                                        return Colors.white;
                                      } else if (Theme.of(context).brightness ==
                                          Brightness.dark) {
                                        return Colors.white;
                                      } else {
                                        return Colors.white;
                                      }
                                    }(),
                                    size: 24,
                                  ),
                                  Text(
                                    'Магазин',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Readex Pro',
                                      color: () {
                                        if (FFAppState().isProvider) {
                                          return Colors.white;
                                        } else if (Theme.of(context)
                                            .brightness ==
                                            Brightness.dark) {
                                          return Colors.white;
                                        } else {
                                          return Colors.white;
                                        }
                                      } (),
                                      fontSize: 18,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              setState(() {
                                FFAppState().isProvider = true;
                                FFAppState().typeBusiness = 'Поставщик';
                              });
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              height: 70,
                              decoration: BoxDecoration(
                                color: FFAppState().isProvider
                                    ? Color(0xC06C5DF6)
                                    : Color(0x9B7E7E7E),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_cart_sharp,
                                    color: () {
                                      if (FFAppState().isProvider) {
                                        return Colors.white;
                                      } else if (Theme.of(context).brightness ==
                                          Brightness.dark) {
                                        return Colors.white;
                                      } else {
                                        return Colors.white;
                                      }
                                    }(),
                                    size: 24,
                                  ),
                                  Text(
                                    'Поставщик',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Readex Pro',
                                      color: () {
                                        if (FFAppState().isProvider) {
                                          return Colors.white;
                                        } else if (Theme.of(context)
                                            .brightness ==
                                            Brightness.dark) {
                                          return Colors.white;
                                        } else {
                                          return Colors.white;
                                        }
                                      }(),
                                      fontSize: 18,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
                    child: TextFormField(
                      controller: _model.businessNameTextController,
                      focusNode: _model.businessNameFocusNode,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Название организации:',
                        labelStyle:
                        FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0,
                        ),
                        hintText: 'Название организации:',
                        hintStyle:
                        FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Readex Pro',
                          fontSize: 14,
                          letterSpacing: 0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFC6C6C6),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF0B7FD1),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFC6C6C6),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFC6C6C6),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor:
                        FlutterFlowTheme.of(context).secondaryBackground,
                        contentPadding:
                        EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0,
                      ),
                      maxLines: null,
                      validator: _model.businessNameTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
                    child: TextFormField(
                      controller: _model.businessNumberTextController,
                      focusNode: _model.businessNumberFocusNode,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'ИИН/БИН:',
                        labelStyle:
                        FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0,
                        ),
                        hintText: 'ИИН/БИН:',
                        hintStyle:
                        FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Readex Pro',
                          fontSize: 14,
                          letterSpacing: 0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFC6C6C6),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF0B7FD1),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFC6C6C6),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFC6C6C6),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor:
                        FlutterFlowTheme.of(context).secondaryBackground,
                        contentPadding:
                        EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0,
                      ),
                      maxLines: null,
                      validator: _model.businessNameTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                  if (FFAppState().isProvider)
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 12),
                      child: FutureBuilder<ApiCallResponse>(
                        future: GetAllProviderCategoryCall.call(),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    FlutterFlowTheme.of(context).primary,
                                  ),
                                ),
                              ),
                            );
                          }
                          final providerCategoryGetAllProviderCategoryResponse =
                          snapshot.data!;
                          return FlutterFlowDropDown<String>(
                            controller:
                            _model.providerCategoryValueController ??=
                                FormFieldController<String>(
                                  _model.providerCategoryValue ??=
                                  'Категория поставщика',
                                ),
                            options: (getJsonField(providerCategoryGetAllProviderCategoryResponse.jsonBody, r'''$[:].nameRu''', true,) as List)
                                .map<String>((s) => s.toString())
                                .toList()!,
                            onChanged: (val) => setState(() => _model.providerCategoryValue = val),
                            width: double.infinity,
                            height: 56,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Roboto',
                              letterSpacing: 0,
                            ),
                            hintText: 'Выберите категорию',
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 15,
                            ),
                            fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                            elevation: 2,
                            borderColor: Color(0xFFC6C6C6),
                            borderWidth: 2,
                            borderRadius: 8,
                            margin: EdgeInsetsDirectional.fromSTEB(20, 4, 12, 4),
                            hidesUnderline: true,
                            isSearchable: false,
                            isMultiSelect: false,
                          );
                        },
                      ),
                    ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 20, 0),
                          child: Text(
                            'Форма:',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Readex Pro',
                              letterSpacing: 0,
                            ),
                          ),
                        ),
                        FlutterFlowRadioButton(
                          options: ['ИП', 'ТОО'].toList(),
                          onChanged: (val) => setState(() {}),
                          controller: _model.formBusinessValueController ??=
                              FormFieldController<String>(null),
                          optionHeight: 32,
                          textStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0,
                          ),
                          selectedTextStyle:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0,
                          ),
                          textPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                          buttonPosition: RadioButtonPosition.left,
                          direction: Axis.horizontal,
                          radioButtonColor:
                          FlutterFlowTheme.of(context).primary,
                          inactiveRadioButtonColor:
                          FlutterFlowTheme.of(context).secondaryText,
                          toggleable: false,
                          horizontalAlignment: WrapAlignment.start,
                          verticalAlignment: WrapCrossAlignment.start,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
                    child: TextFormField(
                      controller: _model.emailTextController,
                      focusNode: _model.emailFocusNode,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Электронная почта:',
                        labelStyle:
                        FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0,
                        ),
                        hintText: 'Электронная почта:',
                        hintStyle:
                        FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Readex Pro',
                          fontSize: 14,
                          letterSpacing: 0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFC6C6C6),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF0B7FD1),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFC6C6C6),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFC6C6C6),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor:
                        FlutterFlowTheme.of(context).secondaryBackground,
                        contentPadding:
                        EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0,
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.emailAddress,
                      validator: _model.emailTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
                    child: TextFormField(
                      controller: _model.phoneNumberTextController,
                      focusNode: _model.phoneNumberFocusNode,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Номер телефона:',
                        labelStyle:
                        FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0,
                        ),
                        hintStyle:
                        FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Readex Pro',
                          fontSize: 14,
                          letterSpacing: 0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFC6C6C6),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF0B7FD1),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFC6C6C6),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFC6C6C6),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor:
                        FlutterFlowTheme.of(context).secondaryBackground,
                        contentPadding:
                        EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0,
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.phone,
                      validator: _model.phoneNumberTextControllerValidator
                          .asValidator(context),
                      inputFormatters: [_model.phoneNumberMask],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Данные авторизации',
                          style:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            fontSize: 16,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
                    child: TextFormField(
                      controller: _model.loginTextController,
                      focusNode: _model.loginFocusNode,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Логин: ',
                        labelStyle:
                        FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0,
                        ),
                        hintStyle:
                        FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Readex Pro',
                          fontSize: 14,
                          letterSpacing: 0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFC6C6C6),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF0B7FD1),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFC6C6C6),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFC6C6C6),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor:
                        FlutterFlowTheme.of(context).secondaryBackground,
                        contentPadding:
                        EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0,
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.name,
                      validator: _model.loginTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
                    child: TextFormField(
                      controller: _model.passwordTextController,
                      focusNode: _model.passwordFocusNode,
                      obscureText: !_model.passwordVisibility,
                      decoration: InputDecoration(
                        labelText: 'Пароль: ',
                        labelStyle:
                        FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0,
                        ),
                        hintStyle:
                        FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Readex Pro',
                          fontSize: 14,
                          letterSpacing: 0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFC6C6C6),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF0B7FD1),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFC6C6C6),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFC6C6C6),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor:
                        FlutterFlowTheme.of(context).secondaryBackground,
                        contentPadding:
                        EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                        suffixIcon: InkWell(
                          onTap: () => setState(
                                () => _model.passwordVisibility =
                            !_model.passwordVisibility,
                          ),
                          focusNode: FocusNode(skipTraversal: true),
                          child: Icon(
                            _model.passwordVisibility
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Color(0xFF757575),
                            size: 22,
                          ),
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0,
                      ),
                      keyboardType: TextInputType.name,
                      validator: _model.passwordTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 0.05),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () async {

                          if (_model.formKey.currentState == null ||
                              !_model.formKey.currentState!.validate()) {
                            return;
                          }
                          if (_model.formBusinessValue == null) {
                            return;
                          }

                          _model.apiResult5od = await RegistrationSaudalineCall.call(
                            businessName: _model.businessNameTextController.text,
                            businessNumber: _model.businessNumberTextController.text,
                            email: _model.emailTextController.text,
                            formBusiness: ['ИП', 'ТОО'].indexOf(_model.formBusinessValue.toString()).toString(),
                            userType: FFAppState().isProvider ? "PROVIDER" : "CUSTOMER",
                            password: _model.passwordTextController.text,
                            phoneNumber: _model.phoneNumberTextController.text,
                            providerCategory: FFAppState().isProvider
                                ? _model.providerCategoryValue
                                : '0',
                          );

                          print(_model.apiResult5od?.jsonBody);

                          if ((_model.apiResult5od?.succeeded ?? true)) {

                            _model.apiResultx2j = await LoginAndRegistrationGroup
                                .sendVerificationMailCall.call(email: _model.emailTextController.text,);

                            if ((_model.apiResultx2j?.succeeded ?? true)) {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return WebViewAware(
                                    child: AlertDialog(
                                      title:
                                      Text('Вы успешно зарегистрировались'),
                                      content: Text('Теперь подтвердите свой адрес электронной почты, после подтверждения ваша учетная запись будет активна. Для подтверждения электронной почты перейдите по ссылке, отправленной на ваш адрес электронной почты.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(alertDialogContext),
                                          child: Text('Ок'),
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
                                      title: Text('Ошибка запроса'),
                                      content: Text('Попробуй позже'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
                                          child: Text('Ок'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }


                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return NavBarPage(currentPageName: "profile",);
                            }));
                          } else {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return WebViewAware(
                                  child: AlertDialog(
                                    title: Text('Ошибка запроса'),
                                    content: Text('Попробуй позже'),
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

                          setState(() {});
                        },
                        text: 'Завершить регистрацию',
                        options: FFButtonOptions(
                          width: 354,
                          height: 50,
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                            fontFamily: 'Readex Pro',
                            color:
                            FlutterFlowTheme.of(context).primaryBtnText,
                            letterSpacing: 0,
                          ),
                          elevation: 2,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
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
