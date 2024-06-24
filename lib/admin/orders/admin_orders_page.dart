import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pagination_flutter/pagination.dart';
import 'package:sauda_line/admin/orders/admin_orders_detail_page.dart';
import 'package:sauda_line/app_state.dart';
import 'package:sauda_line/flutter_flow/flutter_flow_theme.dart';
import 'package:sauda_line/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/backend/schema/enums/enums.dart';

class AdminOrdersPage extends StatefulWidget {
  const AdminOrdersPage({super.key});

  @override
  State<AdminOrdersPage> createState() => _AdminOrdersPageState();
}


class _AdminOrdersPageState extends State<AdminOrdersPage> {

  int selectedPage = 1;
  OrderStatus? orderStatus = OrderStatus.CREATED;
  int? selectedCityId;

  Future<dynamic> fetchRequestsList() async {
    final response = await http.get(
        Uri.parse('https://server.saudaline.kz/api/v1/orders/get-all-orders?page=$selectedPage&status=${orderStatus.toString().split('.')[1]}&pageSize=9999'),
        headers: { "Authorization": "Bearer ${FFAppState().jwttoken}" }
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<dynamic>> fetchCities() async {
    final response = await http.get(Uri.parse('https://server.saudaline.kz/api/v1/city/get-by-city-name'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load cities');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGrey6,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        title: const Text('Заказы',
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
              var orders = snapshot.data!["list"];

              var filterData = orders;
              if (selectedCityId != null) {
                filterData = orders.where((element) => element["city"]["id"] == selectedCityId).toList();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      orderStatus = OrderStatus.CREATED;
                                    });
                                  },
                                  text: 'Ожидающие',
                                  options: FFButtonOptions(
                                    height: 28.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                    color:
                                    orderStatus == OrderStatus.CREATED
                                        ? Color(0xFFFCA522)
                                        : Colors.white,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                      fontFamily: 'Readex Pro',
                                      color: orderStatus ==
                                          OrderStatus.CREATED
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
                                    orderStatus = OrderStatus.APPROVED;
                                  });
                                },
                                text: 'Принятые',
                                options: FFButtonOptions(
                                  height: 28.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color:
                                  orderStatus == OrderStatus.APPROVED
                                      ? Color(0xFFFCA522)
                                      : Colors.white,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                    fontFamily: 'Readex Pro',
                                    color: orderStatus ==
                                        OrderStatus.APPROVED
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
                                    orderStatus = OrderStatus.CANCELED;
                                  });
                                },
                                text: 'Непринятые',
                                options: FFButtonOptions(
                                  height: 28.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: orderStatus == OrderStatus.CANCELED
                                      ? Color(0xFFFCA522)
                                      : Colors.white,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                    fontFamily: 'Readex Pro',
                                    color: orderStatus ==
                                        OrderStatus.CANCELED
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
                                    orderStatus = OrderStatus.CLOSED;
                                  });
                                },
                                text: 'Отклонные ',
                                options: FFButtonOptions(
                                  height: 28.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: orderStatus == OrderStatus.CLOSED
                                      ? Color(0xFFFCA522)
                                      : Colors.white,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                    fontFamily: 'Readex Pro',
                                    color: orderStatus ==
                                        OrderStatus.CLOSED
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

                  Container(
                    child: FutureBuilder<List<dynamic>>(
                      future: fetchCities(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('No cities found'));
                        } else {

                          List<dynamic> cities = snapshot.data!;

                          return Container(
                            margin: const EdgeInsets.all(10.0),
                            height: 30.0,
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(100.0),
                                color: Colors.grey.withOpacity(0.2)
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                hint: Text('Город'),
                                value: selectedCityId,
                                padding: EdgeInsets.zero,
                                onChanged: (int? newValue) {
                                  setState(() {
                                    selectedCityId = newValue;
                                  });
                                },
                                items: cities.map((city) {
                                  return DropdownMenuItem<int>(
                                    value: city['id'],
                                    child: Text(city['name'], style: TextStyle(
                                        fontFamily: "Futura",
                                        fontSize: 13.0
                                    ),),
                                  );
                                }).toList(),
                              ),
                            ),
                          );

                        }
                      },
                    ),
                  ),


                  if (filterData.length > 0) ...[
                    Expanded(
                      child: ListView.builder(
                        itemCount: filterData.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var order = filterData[index];

                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),

                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7.0)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Номер №${order["id"]}", style: const TextStyle(
                                    fontFamily: "Futura",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16
                                ),),

                                const SizedBox(height: 10.0,),

                                Row(
                                  children: [
                                    const Text("Статус: ", style: TextStyle(
                                        fontFamily: "Futura",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15
                                    ),),
                                    Flexible(
                                        child: Text(functions.formatAdminStatus(order["status"]).toString(), style: const TextStyle(
                                          fontFamily: "Futura",
                                          fontSize: 15,
                                        ),)
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Дата: ", style: TextStyle(
                                        fontFamily: "Futura",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15
                                    ),),
                                    Flexible(
                                        child: Text(functions.formatDate(order["created"]).toString(), style: const TextStyle(
                                          fontFamily: "Futura",
                                          fontSize: 15,
                                        ),)
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Кол: ", style: TextStyle(
                                        fontFamily: "Futura",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15
                                    ),),
                                    Flexible(
                                        child: Text(order["totalQuantity"].toString(), style: const TextStyle(
                                          fontFamily: "Futura",
                                          fontSize: 15,
                                        ),)
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Цена: ", style: TextStyle(
                                        fontFamily: "Futura",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15
                                    ),),
                                    Flexible(
                                        child: Text(functions.minusOnePercent(order["totalAmountWithDiscount"]).toString(), style: const TextStyle(
                                          fontFamily: "Futura",
                                          fontSize: 15,
                                        ),)
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Поставщик: ", style: TextStyle(
                                        fontFamily: "Futura",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15
                                    ),),
                                    Flexible(
                                        child: Text(order["provider"]["name"], style: const TextStyle(
                                          fontFamily: "Futura",
                                          fontSize: 15,
                                        ),)
                                    ),
                                  ],
                                ),

                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                        return AdminOrdersDetailPage(
                                          orderId: order["id"],
                                        );
                                      }));
                                    },
                                    child: const Text("детали заказа", style: TextStyle(
                                        fontFamily: "Futura"
                                    ),)
                                )



                              ],
                            ),
                          );
                        },
                      ),
                    ),                    
                  ] else ...[
                    Expanded(
                      child: Center(
                        child: Text("Пусто"),
                      ),
                    )
                  ],
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
