import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pagination_flutter/pagination.dart';
import 'package:sauda_line/app_state.dart';
import 'package:sauda_line/backend/api_requests/api_calls.dart';
import 'package:sauda_line/flutter_flow/custom_functions.dart' as funtions;
import 'package:sauda_line/flutter_flow/flutter_flow_theme.dart';
import 'package:sauda_line/flutter_flow/flutter_flow_util.dart';
import 'package:sauda_line/provider/providers_products/providers_products_model.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class AdminProductsPage extends StatefulWidget {
  const AdminProductsPage({Key? key}) : super(key: key);

  @override
  State<AdminProductsPage> createState() => _AdminProductsPageState();
}

class _AdminProductsPageState extends State<AdminProductsPage> {
  late ProvidersProductsModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProvidersProductsModel());


    fetchProviders();
  }

  int selectedPage = 1;
  int? selectedCityId;
  int? selectedProviderId;

  bool isNullProvider = true;

  Future<dynamic> fetchRequestsList() async {
    final response = await http.get(
        Uri.parse('https://server.saudaline.kz/api/v1/product/get-all-products?userId=${ selectedProviderId ?? '' }'),
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

  Future<List<dynamic>> fetchProviders() async {
    final response = await http.get(Uri.parse('https://server.saudaline.kz/api/v1/provider/get-all-providers?page=0&pageSize=10&cityId=${selectedCityId ?? 1}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)["list"];

      print(data.length);

      if (data.length == 0) {
          isNullProvider = true;
      } else {
          isNullProvider = false;
      }

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
        title: const Text('Товары',
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
          builder: (context, products) {
            if (products.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      FutureBuilder<List<dynamic>>(
                        future: fetchCities(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const CupertinoActivityIndicator();
                          } else {

                            List<dynamic> cities = snapshot.data!;

                            return Container(
                              margin: const EdgeInsets.all(10.0),
                              height: 30.0,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
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
                                  hint: const Text('Город'),
                                  value: selectedCityId,
                                  padding: EdgeInsets.zero,
                                  onChanged: (int? newValue) {
                                    setState(() {
                                      selectedCityId = newValue;
                                      selectedProviderId = null;
                                    });
                                  },
                                  items: cities.map((city) {
                                    return DropdownMenuItem<int>(
                                      value: city['id'],
                                      child: Text(city['name'].toString(), style: const TextStyle(
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

                      if (selectedCityId != null) ...[
                        FutureBuilder<List<dynamic>>(
                          future: fetchProviders(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            } else {
                              List<dynamic> providers = snapshot.data!;

                              return Container(
                                margin: const EdgeInsets.all(10.0),
                                height: 30.0,
                                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
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
                                    hint: const Text('Поставщик'),
                                    value: selectedProviderId,
                                    padding: EdgeInsets.zero,
                                    onChanged: (int? newValue) {
                                      setState(() {
                                        selectedProviderId = newValue;
                                      });
                                    },
                                    items: providers.map((provider) {
                                      return DropdownMenuItem<int>(
                                        value: provider['userId'],
                                        child: Text(provider['name'].toString(), style: const TextStyle(
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
                      ]
                    ],
                  ),

                if (isNullProvider == true) ...[
                   Container(
                     height: MediaQuery.of(context).size.height / 1.5,
                     child: Center(child: Text("Пусто")),
                   )
                ] else ...[
                  Expanded(
                    child: ListView.builder(
                      itemCount: products.data["list"].length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var product = products.data["list"][index];

                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: ListTile(
                            leading: SizedBox(
                                width: 100,
                                child: Image.network(product["mainPhoto"] != null ? product["mainPhoto"]["url"].toString() : "https://saudaline.kz/images/logo.png", fit: BoxFit.cover, width: 100,)
                            ),
                            title: Text("${product["title"]}", style: const TextStyle(
                                fontFamily: "Futura"
                            ),),
                            subtitle: Text("Поставщик: ${product["provider"]["name"]}", style: const TextStyle(
                                fontFamily: "Futura"
                            ),),
                            trailing: IconButton(onPressed: () async{
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return WebViewAware(
                                    child: AlertDialog(
                                      title: const Text('Вы точно хотите удалить'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(alertDialogContext),
                                          child: const Text('Отмена'),
                                        ),
                                        TextButton(
                                          onPressed: () async{
                                            _model.apiResultcp2 = await ProductGroup.deleteProductByIdCall.call(
                                              productId: getJsonField(
                                                product, r'''$.id''',
                                              ),
                                              jwtToken: FFAppState().jwttoken,
                                            );

                                            if ((_model.apiResultcp2?.succeeded ?? true)) {
                                              await showDialog(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return WebViewAware(
                                                    child: AlertDialog(
                                                      title: const Text('Удалено успешно'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () => Navigator.pop(alertDialogContext),
                                                          child: const Text('Ok'),
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
                                                      title: const Text('Ошибка при удалении'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () => Navigator.pop(alertDialogContext),
                                                          child: const Text('Ok'),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            }

                                            Navigator.of(alertDialogContext).pop();
                                          },
                                          child: const Text('Удалить'),
                                        ),
                                      ],
                                    ),
                                  );
                                },);



                              setState(() {});


                            }, icon: const Icon(Icons.delete_outline, color: Colors.redAccent,), padding: EdgeInsets.zero,),
                          ),
                        );

                      },
                    ),
                  ),
                ],

                ]
              );
            }
          },
        ),
      ),
    );
  }
}
