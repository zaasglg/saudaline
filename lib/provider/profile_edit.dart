import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sauda_line/app_state.dart';
import 'package:sauda_line/flutter_flow/flutter_flow_theme.dart';
import 'package:sauda_line/flutter_flow/flutter_flow_util.dart';
import 'package:sauda_line/main.dart';
import 'package:sauda_line/svg_icons.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {

  TextEditingController _nameController = TextEditingController(text: getJsonField(FFAppState().accountInfo, r'''$.name''',).toString());
  TextEditingController _surnameController = TextEditingController(text: getJsonField(FFAppState().accountInfo, r'''$.surname''',).toString());
  TextEditingController _patronymicController = TextEditingController(text: getJsonField(FFAppState().accountInfo, r'''$.patronymic''',).toString());
  TextEditingController _emailController = TextEditingController(text: getJsonField(FFAppState().accountInfo, r'''$.email''',).toString());
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController(text: getJsonField(FFAppState().accountInfo, r'''$.phoneNumber''',).toString());

  final phoneNumberMask = MaskTextInputFormatter(mask: '+# (###) ###-##-##');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        automaticallyImplyLeading: true,
        title: const Text(
          'Редактировать профиль',
          style: TextStyle(
            fontFamily: 'Futura',
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 4.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ==============================

              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Название организации:',
                  labelStyle: TextStyle(
                      fontFamily: "Futura",
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87.withOpacity(0.5)
                  ),
                  hintStyle: FlutterFlowTheme.of(context).labelMedium,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFCFCFCF),
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
                  filled: true,
                ),
                style: const TextStyle(
                    fontFamily: "Futura"
                ),
              ),

              const SizedBox(height: 20.0,),

              TextFormField(
                controller: _surnameController,
                decoration: InputDecoration(
                  labelText: 'Фамилия:',
                  labelStyle: TextStyle(
                      fontFamily: "Futura",
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87.withOpacity(0.5)
                  ),
                  hintStyle: FlutterFlowTheme.of(context).labelMedium,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFCFCFCF),
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
                  filled: true,
                ),
                style: const TextStyle(
                    fontFamily: "Futura"
                ),
              ),

              const SizedBox(height: 20.0,),

              // ==============================

              TextFormField(
                controller: _patronymicController,
                decoration: InputDecoration(
                  labelText: 'Имя:',
                  labelStyle: TextStyle(
                      fontFamily: "Futura",
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87.withOpacity(0.5)
                  ),
                  hintStyle: FlutterFlowTheme.of(context).labelMedium,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFCFCFCF),
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
                  filled: true,
                ),
                style: const TextStyle(
                    fontFamily: "Futura"
                ),
              ),

              const SizedBox(height: 20.0,),

              // ==============================

              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Почта:',
                  labelStyle: TextStyle(
                      fontFamily: "Futura",
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87.withOpacity(0.5)
                  ),
                  hintStyle: FlutterFlowTheme.of(context).labelMedium,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFCFCFCF),
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
                  filled: true,
                ),
                style: const TextStyle(
                    fontFamily: "Futura"
                ),
              ),

              const SizedBox(height: 20.0,),


              // ==============================

              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Пароль:',
                  labelStyle: TextStyle(
                      fontFamily: "Futura",
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87.withOpacity(0.5)
                  ),
                  hintStyle: FlutterFlowTheme.of(context).labelMedium,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFCFCFCF),
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
                  filled: true,
                ),
                style: const TextStyle(
                    fontFamily: "Futura"
                ),
              ),

              const SizedBox(height: 20.0,),


              // ==============================


              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Номер телефона:',
                  labelStyle: TextStyle(
                      fontFamily: "Futura",
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87.withOpacity(0.5)
                  ),
                  hintStyle: FlutterFlowTheme.of(context).labelMedium,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFCFCFCF),
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
                  filled: true,
                ),
                maxLines: null,
                keyboardType: TextInputType.phone,
                inputFormatters: [phoneNumberMask],
                style: const TextStyle(
                  fontFamily: "Futura"
                ),
              ),

              const SizedBox(height: 20.0,),


              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () async{
                  var url = Uri.parse('https://server.saudaline.kz/api/v1/account-info/update-account-info');

                  // Your JSON data
                  var jsonData = {
                    'name': _nameController.text,
                    'surname': _surnameController.text,
                    'patronymic': _patronymicController.text,
                    'email': _emailController.text,
                    'password': _passwordController.text,
                    'phoneNumber': _phoneNumberController.text
                  };

                  // Encode JSON data
                  var body = json.encode(jsonData);

                  // Set headers
                  var headers = {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer ${FFAppState().jwttoken}'
                  };

                  // Send POST request
                  var response = await http.post(url, headers: headers, body: body);

                  // Check response
                  if (response.statusCode == 200) {
                    setState(() {
                      FFAppState().accountInfo = response.body;
                    });

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Успешно'),
                          content: Text('Вы успешно изменили данные.'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                  return NavBarPage(currentPageName: "profile",);
                                }));
                              },
                            ),
                          ],
                        );
                      },
                    );

                  } else {
                    print('Failed to send data. Error code: ${response.statusCode}');
                  }
                }, style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffE8751A),
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)))
                ), child: const Text("Сохранить", style: TextStyle(
                  fontFamily: "Futura",
                  fontSize: 15.0,
                ),),),
              )

            ],
          ),
        ),
      ),
    );
  }
}
