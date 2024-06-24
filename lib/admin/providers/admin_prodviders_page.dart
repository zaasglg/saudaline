import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pagination_flutter/pagination.dart';
import 'package:sauda_line/app_state.dart';
import 'package:sauda_line/flutter_flow/flutter_flow_theme.dart';
import 'package:sauda_line/flutter_flow/custom_functions.dart' as functions;

class AdminProvidersPage extends StatefulWidget {
  const AdminProvidersPage({Key? key}) : super(key: key);

  @override
  State<AdminProvidersPage> createState() => _AdminProvidersPageState();
}

class _AdminProvidersPageState extends State<AdminProvidersPage> {
  int selectedPage = 1;

  Future<dynamic> fetchRequestsList() async {
    final response = await http.get(
        Uri.parse('https://server.saudaline.kz/api/v1/provider/get-all-providers'),
        headers: { "Authorization": "Bearer ${FFAppState().jwttoken}" }
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
      backgroundColor: CupertinoColors.systemGrey6,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        title: const Text('Поставщики',
          style: TextStyle(
            fontFamily: 'Futura',
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: FutureBuilder<dynamic>(
          future: fetchRequestsList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!["list"].length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var provider = snapshot.data!["list"][index];

                        print(provider);

                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),

                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7.0)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Номер №${provider["id"]}", style: TextStyle(
                                  fontFamily: "Futura",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16
                              ),),

                              SizedBox(height: 10.0,),

                              Row(
                                children: [
                                  Text("Тип орг.: ", style: TextStyle(
                                      fontFamily: "Futura",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15
                                  ),),
                                  Flexible(
                                      child: Text(provider["businessType"]["name"], style: TextStyle(
                                        fontFamily: "Futura",
                                        fontSize: 15,
                                      ),)
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Названия: ", style: TextStyle(
                                      fontFamily: "Futura",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15
                                  ),),
                                  Flexible(
                                      child: Text(provider["name"], style: TextStyle(
                                        fontFamily: "Futura",
                                        fontSize: 15,
                                      ),)
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("БИН: ", style: TextStyle(
                                      fontFamily: "Futura",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15
                                  ),),
                                  Flexible(
                                      child: Text(provider["businessNumber"], style: TextStyle(
                                        fontFamily: "Futura",
                                        fontSize: 15,
                                      ),)
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Тел: ", style: TextStyle(
                                      fontFamily: "Futura",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15
                                  ),),
                                  Flexible(
                                      child: Text(provider["phone"], style: TextStyle(
                                        fontFamily: "Futura",
                                        fontSize: 15,
                                      ),)
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Город: ", style: TextStyle(
                                      fontFamily: "Futura",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15
                                  ),),
                                  Flexible(
                                      child: Text(provider["city"].length > 0 ? provider["city"][0]["name"] : "", style: TextStyle(
                                        fontFamily: "Futura",
                                        fontSize: 15,
                                      ),)
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Адрес: ", style: TextStyle(
                                      fontFamily: "Futura",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15
                                  ),),
                                  Flexible(
                                      child: Text(provider["address"] ?? "", style: TextStyle(
                                        fontFamily: "Futura",
                                        fontSize: 15,
                                      ),)
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Тариф: ", style: TextStyle(
                                      fontFamily: "Futura",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15
                                  ),),
                                  Flexible(
                                      child: Text(provider["tariff"] != null
                                          ? provider["tariff"]["title"]
                                          : "", style: TextStyle(
                                        fontFamily: "Futura",
                                        fontSize: 15,
                                      ),)
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Баланс: ", style: TextStyle(
                                      fontFamily: "Futura",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15
                                  ),),
                                  Flexible(
                                      child: Text("${provider["balance"] ?? 0} тг", style: TextStyle(
                                        fontFamily: "Futura",
                                        fontSize: 15,
                                      ),)
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Text("Дата регистрации: ", style: TextStyle(
                                      fontFamily: "Futura",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15
                                  ),),
                                  Flexible(
                                      child: Text(functions.formatDateWithoutTime(provider["createdDate"]) ?? "", style: TextStyle(
                                        fontFamily: "Futura",
                                        fontSize: 15,
                                      ),)
                                  ),
                                ],
                              ),


                            ],
                          ),
                        );
                      },
                    ),
                  ),

                ],
              );
            }
          },
        ),
      ),
    );
  }
}
