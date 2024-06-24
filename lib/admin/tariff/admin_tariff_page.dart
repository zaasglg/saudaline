import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pagination_flutter/pagination.dart';
import 'package:sauda_line/app_state.dart';
import 'package:sauda_line/backend/schema/enums/enums.dart';
import 'package:sauda_line/flutter_flow/flutter_flow_theme.dart';
import 'package:sauda_line/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;

class AdminTariffPage extends StatefulWidget {
  const AdminTariffPage({Key? key}) : super(key: key);

  @override
  State<AdminTariffPage> createState() => _AdminTariffPageState();
}

class _AdminTariffPageState extends State<AdminTariffPage> {
  int selectedPage = 1;
  TariffStatus tariffStatus = TariffStatus.CREATED;

  Future<dynamic> fetchRequestsList() async {
    final response = await http.get(
        Uri.parse('https://server.saudaline.kz/api/v1/tariff-request/get-all?pageSize=999&status=${tariffStatus.toString().split('.')[1]}'),
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
        title: const Text('Запросы тарифов',
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
              print(snapshot.data);
              return Column(
                children: [

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15.0, 8.0, 8.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    setState(() {
                                      tariffStatus = TariffStatus.CREATED;
                                    });
                                  },
                                  text: 'Ожидающие',
                                  options: FFButtonOptions(
                                    height: 28.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                    color: tariffStatus == TariffStatus.CREATED
                                        ? Color(0xFFFCA522)
                                        : Colors.white,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                      fontFamily: 'Readex Pro',
                                      color: tariffStatus == TariffStatus.CREATED
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 14.0,
                                    ),
                                    borderSide: BorderSide(
                                      color: Color(0xFFFCA522),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(0.0),
                                      bottomRight: Radius.circular(0.0),
                                      topLeft: Radius.circular(0.0),
                                      topRight: Radius.circular(0.0),
                                    ),
                                  ),
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  setState(() {
                                    tariffStatus = TariffStatus.PAID;
                                  });
                                },
                                text: 'Оплаченные',
                                options: FFButtonOptions(
                                  height: 28.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color:
                                  tariffStatus == TariffStatus.PAID
                                      ? Color(0xFFFCA522)
                                      : Colors.white,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                    fontFamily: 'Readex Pro',
                                    color: tariffStatus == TariffStatus.PAID
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 14.0,
                                  ),
                                  borderSide: BorderSide(
                                    color: Color(0xFFFCA522),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(0.0),
                                    bottomRight: Radius.circular(0.0),
                                    topLeft: Radius.circular(0.0),
                                    topRight: Radius.circular(0.0),
                                  ),
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  setState(() {
                                    tariffStatus = TariffStatus.UNPAID;
                                  });
                                },
                                text: 'Непринятые',
                                options: FFButtonOptions(
                                  height: 28.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: tariffStatus == TariffStatus.UNPAID
                                      ? Color(0xFFFCA522)
                                      : Colors.white,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                    fontFamily: 'Readex Pro',
                                    color: tariffStatus == TariffStatus.UNPAID
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 14.0,
                                  ),
                                  borderSide: BorderSide(
                                    color: Color(0xFFFCA522),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(0.0),
                                    bottomRight: Radius.circular(0.0),
                                    topLeft: Radius.circular(0.0),
                                    topRight: Radius.circular(0.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!["list"].length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var request = snapshot.data!["list"][index];

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
                              Text("Номер №${request["id"]}", style: TextStyle(
                                fontFamily: "Futura",
                                fontWeight: FontWeight.w500,
                                fontSize: 16
                              ),),

                              SizedBox(height: 10.0,),

                              Row(
                                children: [
                                  Text("Поставщик: ", style: TextStyle(
                                      fontFamily: "Futura",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15
                                  ),),
                                  Flexible(
                                    child: Text(request["provider"]["name"], style: TextStyle(
                                        fontFamily: "Futura",
                                        fontSize: 15,
                                    ),)
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Телефон номер: ", style: TextStyle(
                                      fontFamily: "Futura",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15
                                  ),),
                                  Flexible(
                                      child: Text(request["tel"], style: TextStyle(
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
                                      child: Text(request["tariff"]["title"], style: TextStyle(
                                        fontFamily: "Futura",
                                        fontSize: 15,
                                      ),)
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Сумма: ", style: TextStyle(
                                      fontFamily: "Futura",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15
                                  ),),
                                  Flexible(
                                      child: Text("${request["sum"]} тг", style: TextStyle(
                                        fontFamily: "Futura",
                                        fontSize: 15,
                                      ),)
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Время: ", style: TextStyle(
                                      fontFamily: "Futura",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15
                                  ),),
                                  Flexible(
                                      child: Text(functions.formatDate(request["created"]).toString(), style: TextStyle(
                                        fontFamily: "Futura",
                                        fontSize: 15,
                                      ),)
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Статус: ", style: TextStyle(
                                      fontFamily: "Futura",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15
                                  ),),
                                  Flexible(
                                      child: Text(functions.formatAdminTariffResuestStatus(request["status"]).toString(), style: TextStyle(
                                        fontFamily: "Futura",
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: functions.formatAdminTarifRequestStatusColor(request["status"])
                                      ),)
                                  ),
                                ],
                              ),

                              SizedBox(height: 20.0,),

                              Column(
                                children: [

                                  if (request["status"] == "CREATED") ...[
                                    Container(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green
                                          ),
                                          onPressed: () async {

                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text('Предупреждение'),
                                                  content: SingleChildScrollView(
                                                    child: ListBody(
                                                      children: <Widget>[
                                                        Text('Вы точно хотите подтвердить платеж?'),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: Text('Да'),
                                                      onPressed: () async {


                                                        var response = await http.patch(Uri.parse('https://server.saudaline.kz/api/v1/tariff-request/set-paid?tariffRequestId=${request['id']}'),
                                                            headers: {
                                                              'Content-Type': 'application/json',
                                                              'Authorization': 'Bearer ${FFAppState().jwttoken}'
                                                            }
                                                        );

                                                        if (response.statusCode == 200) {

                                                          setState(() {});

                                                        } else {
                                                          print('Failed to send data. Error code: ${response.statusCode}');
                                                        }

                                                        print(response.body);
                                                        setState(() {});

                                                        Navigator.of(context).pop();

                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text('Отмена'),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [

                                              Text("Подтвердить платеж", style: TextStyle(
                                                  fontFamily: "Futura",
                                                  fontSize: 16
                                              ),),
                                              SizedBox(width: 5.0,),
                                              Icon(Icons.check),
                                            ],
                                          )
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text('Предупреждение'),
                                                  content: SingleChildScrollView(
                                                    child: ListBody(
                                                      children: <Widget>[
                                                        Text('Вы точно хотите отменить?'),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: Text('Да'),
                                                      onPressed: () async {


                                                        var response = await http.patch(Uri.parse('https://server.saudaline.kz/api/v1/tariff-request/set-unpaid?tariffRequestId=${request['id']}'),
                                                            headers: {
                                                              'Content-Type': 'application/json',
                                                              'Authorization': 'Bearer ${FFAppState().jwttoken}'
                                                            }
                                                        );

                                                        if (response.statusCode == 200) {

                                                          setState(() {});

                                                        } else {
                                                          print('Failed to send data. Error code: ${response.statusCode}');
                                                        }

                                                        Navigator.of(context).pop();

                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text('Отмена'),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.redAccent
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("Оплата не произведен", style: TextStyle(
                                                  fontFamily: "Futura",
                                                  fontSize: 16
                                              )),
                                              SizedBox(width: 5.0,),
                                              Icon(Icons.close)
                                            ],
                                          )
                                      ),
                                    )
                                  ]
                                ],
                              )

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
