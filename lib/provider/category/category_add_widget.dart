import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sauda_line/app_state.dart';
import 'package:sauda_line/backend/api_requests/api_calls.dart';
import 'package:sauda_line/flutter_flow/flutter_flow_theme.dart';
import 'package:sauda_line/flutter_flow/flutter_flow_util.dart';
import 'package:sauda_line/flutter_flow/flutter_flow_widgets.dart';
import 'package:sauda_line/flutter_flow/upload_data.dart';
import 'package:sauda_line/main.dart';
import 'package:http/http.dart' as http;
import 'package:sauda_line/provider/category/category_widget.dart';

class CategoryAddWidget extends StatefulWidget {

  final dynamic category;

  const CategoryAddWidget({Key? key, this.category}) : super(key: key);

  @override
  State<CategoryAddWidget> createState() => _CategoryAddWidgetState();
}

class _CategoryAddWidgetState extends State<CategoryAddWidget> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.category != null) {
      _titleController.text = widget.category["title"];
      _descriptionController.text = widget.category["description"];
    }
    
  }

  void create() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        automaticallyImplyLeading: true,
        title: Text(
          widget.category != null ? 'Изменить категорию' : 'Создать категорию',
          style: const TextStyle(
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

              TextFormField(
                controller: _titleController,
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
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Описание:',
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
                maxLines: 3,
                style: const TextStyle(
                    fontFamily: "Futura"
                ),
              ),

              const SizedBox(height: 20.0,),


              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () async{

                  Uri url;
                  if (widget.category != null) {
                    url = Uri.parse('https://server.saudaline.kz/api/v1/categories/update-category?categoryId=${widget.category["id"]}');
                  } else {
                    url = Uri.parse('https://server.saudaline.kz/api/v1/categories/create-category');
                  }

                  var jsonData = {
                    "provider": FFAppState().accountInfo['id'],
                    "title": _titleController.text,
                    "description": _descriptionController.text,
                    "photo": 0,
                    "isActive": true
                  };

                  var body = json.encode(jsonData);

                  var headers = {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer ${FFAppState().jwttoken}'
                  };

                  var response;

                  if (widget.category != null) {
                    response = await http.put(url, headers: headers, body: body);
                  } else {
                    response = await http.post(url, headers: headers, body: body);
                  }

                  if (response.statusCode == 200) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Успешно'),
                          content: const Text('Вы успешно изменили данные.'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                  return CategoryWidget();
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


