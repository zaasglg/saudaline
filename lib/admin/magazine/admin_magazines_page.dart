import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pagination_flutter/pagination.dart';
import 'package:sauda_line/app_state.dart';
import 'package:sauda_line/flutter_flow/flutter_flow_theme.dart';
import 'package:sauda_line/flutter_flow/custom_functions.dart' as functions;

class AdminMagazinesPage extends StatefulWidget {
  const AdminMagazinesPage({Key? key}) : super(key: key);

  @override
  State<AdminMagazinesPage> createState() => _AdminMagazinesPageState();
}

class _AdminMagazinesPageState extends State<AdminMagazinesPage> {
  int selectedPage = 1;

  Future<dynamic> fetchRequestsList() async {
    final response = await http.get(
        Uri.parse('https://server.saudaline.kz/api/v1/customer/'),
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
        title: const Text('Магазины',
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
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var customer = snapshot.data![index];
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
                              Text("Номер №${customer["id"]}", style: TextStyle(
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
                                      child: Text(customer["businessType"]["name"], style: TextStyle(
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
                                      child: Text(customer["name"], style: TextStyle(
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
                                      child: Text(customer["businessNumber"], style: TextStyle(
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
                                      child: Text(customer["phone"], style: TextStyle(
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
                                      child: Text(customer["city"] != null ? customer["city"]["name"] : "", style: TextStyle(
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
                                      child: Text(customer["address"] ?? "", style: TextStyle(
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
                                      child: Text(functions.formatDateWithoutTime(customer["createdDate"]) ?? "", style: TextStyle(
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
