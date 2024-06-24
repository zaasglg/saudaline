import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:sauda_line/app_state.dart';
import 'package:sauda_line/flutter_flow/flutter_flow_theme.dart';
import "package:http/http.dart" as http;

class AboutContentPage extends StatefulWidget {
  const AboutContentPage({Key? key, this.type}) : super(key: key);

  final String? type;

  @override
  State<AboutContentPage> createState() => _AboutContentPageState();
}

class _AboutContentPageState extends State<AboutContentPage> {

  TextEditingController _titleController = TextEditingController();

  QuillController _contentController = QuillController.basic();

  Future<dynamic> fetchAboutList() async {
    final response = await http.get(
        Uri.parse('https://server.saudaline.kz/api/v1/content?type=${widget.type}'),
        headers: { "Authorization": "Bearer ${FFAppState().jwttoken}" }
    );

    if (response.statusCode == 200) {

      setState(() {
        _titleController.text = jsonDecode(response.body)["titleRu"];
        _contentController.document = Document.fromJson(jsonDecode(jsonDecode(response.body)["valueRu"]));

      });

      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchAboutList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        title: const Text('SAUDALINE',
          style: TextStyle(
            fontFamily: 'Futura',
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        elevation: 0.0,
        actions: [
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Загаловка:',
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

              SizedBox(height: 20.0,),

              Container(
                height: 400,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2.0,
                    color: Color(0xFFCFCFCF)
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.withOpacity(.2)
                ),
                child: QuillProvider(
                  configurations: QuillConfigurations(
                      controller: _contentController
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: QuillToolbar.basic(),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0))
                        ),
                      ),
                      Expanded(
                        child: QuillEditor.basic(
                          padding: EdgeInsets.all(15.0),
                          readOnly: false,
                        ),
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20.0,),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {

                      var jsonData = {
                        "titleRu": _titleController.text,
                        "titleKz": _titleController.text,
                        "titleEn": _titleController.text,
                        "valueKz": jsonEncode(_contentController.document.toDelta().toJson()).toString(),
                        "valueRu": jsonEncode(_contentController.document.toDelta().toJson()).toString(),
                        "valueEn": jsonEncode(_contentController.document.toDelta().toJson()).toString()
                      };

                      var body = json.encode(jsonData);

                      var headers = {
                        'Content-Type': 'application/json',
                        'Authorization': 'Bearer ${FFAppState().jwttoken}'
                      };

                      var response = await http.patch(
                          Uri.parse('https://server.saudaline.kz/api/v1/content?type=${widget.type}'),
                          headers: headers, body: body
                      );

                      if (response.statusCode == 200) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Успешно'),
                              content: const Text('Запрос выполнен успешно.'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );

                      } else {
                        print('Failed to send data. Error code: ${response.statusCode}');
                      }

                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15.0)
                    ),
                    child: const Text("Сохранить")
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
