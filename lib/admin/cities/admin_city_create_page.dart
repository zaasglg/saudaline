import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sauda_line/admin/cities/admin_cities_page.dart';
import 'package:sauda_line/app_state.dart';
import 'package:sauda_line/provider/brands/brands_page_widget.dart';

import '../../flutter_flow/flutter_flow_theme.dart';

class AdminCityCreatePage extends StatefulWidget {
  final dynamic city;
  const AdminCityCreatePage({Key? key, this.city}) : super(key: key);

  @override
  State<AdminCityCreatePage> createState() => _AdminCityCreatePageState();
}

class _AdminCityCreatePageState extends State<AdminCityCreatePage> {

  TextEditingController _nameController = TextEditingController();


  dynamic selectedRegion;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.city != null) {
      _nameController.text = widget.city["name"];
      selectedRegion = widget.city["region"];
    }

  }


  Future<List<dynamic>> fetchRequestsList() async {
    final response = await http.get(
      Uri.parse('https://server.saudaline.kz/api/v1/region/get-all'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        automaticallyImplyLeading: true,
        title: Text(
          widget.city != null ? 'Изменить город' : 'Создать город',
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
                controller: _nameController,
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

              FutureBuilder<List<dynamic>>(
                  future: fetchRequestsList(),
                  builder: (context, snapshot) {

                    if (!snapshot.hasData) {
                     return const CupertinoActivityIndicator();
                    } else {
                      List<dynamic> regions = snapshot.data!;
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFCFCFCF),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey.withOpacity(.2)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<dynamic>(
                            hint: Text(selectedRegion == null ? "Выберите регион" : selectedRegion["nameRu"]),
                            items: regions.map<DropdownMenuItem<dynamic>>((dynamic region) {
                              return DropdownMenuItem<dynamic>(
                                value: region,
                                child: Text(region['nameRu']),
                              );
                            }).toList(),
                            onChanged: (dynamic newValue) {
                              setState(() {
                                selectedRegion = newValue;
                              });
                            },
                          ),
                        ),
                      );
                    }

                  }
              ),

              const SizedBox(height: 20.0,),

              // ==============================


              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () async {

                  Uri url;
                  if (widget.city != null) {
                    url = Uri.parse('https://server.saudaline.kz/api/v1/city/${widget.city["id"]}');
                  } else {
                    url = Uri.parse('https://server.saudaline.kz/api/v1/city');
                  }

                  var jsonData = {
                    "name": _nameController.text,
                    "region": selectedRegion["id"]
                  };

                  var body = json.encode(jsonData);

                  var headers = {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer ${FFAppState().jwttoken}'
                  };

                  var response = await http.post(url, headers: headers, body: body);

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
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                  return AdminCitiesPage();
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
