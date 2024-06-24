import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pagination_flutter/pagination.dart';
import 'package:sauda_line/admin/cities/admin_city_create_page.dart';
import 'package:sauda_line/admin/regions/admin_regions_create_page.dart';
import 'package:sauda_line/app_state.dart';
import 'package:sauda_line/backend/api_requests/api_calls.dart';
import 'package:sauda_line/flutter_flow/custom_functions.dart' as funtions;
import 'package:sauda_line/flutter_flow/flutter_flow_theme.dart';
import 'package:sauda_line/flutter_flow/flutter_flow_util.dart';
import 'package:sauda_line/main.dart';
import 'package:sauda_line/provider/providers_products/providers_products_model.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class AdminRegionsPage extends StatefulWidget {
  const AdminRegionsPage({Key? key}) : super(key: key);

  @override
  State<AdminRegionsPage> createState() => _AdminRegionsPageState();
}

class _AdminRegionsPageState extends State<AdminRegionsPage> {
  late ProvidersProductsModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProvidersProductsModel());
  }

  int selectedPage = 1;

  Future<dynamic> fetchRequestsList() async {
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
    return WillPopScope(
      onWillPop: () async{

        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return NavBarPage(currentPageName: "profile",);
        }));

        return false;
      },
      child: Scaffold(
        backgroundColor: CupertinoColors.systemGrey6,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          title: const Text('Регионы',
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
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return AdminRegionCreatePage();
                  }));
                },
                icon: Icon(Icons.add)
            )
          ],
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
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var region = snapshot.data[index];

                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: ListTile(
                              title: Text(region["nameRu"].toString(), style: TextStyle(
                                fontFamily: "Futura",
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500
                              ),),
                              trailing: Container(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit_outlined, color: Colors.green,),
                                      onPressed: () async{
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                          return AdminRegionCreatePage(region: region,);
                                        }));
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete_outline, color: Colors.redAccent,),
                                      onPressed: () async{
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return WebViewAware(
                                              child: AlertDialog(
                                                title: const Text('Вы точно хотите удалить?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(alertDialogContext),
                                                    child: const Text('Отмена'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async{
                                                      var url = Uri.parse('https://server.saudaline.kz/api/v1/region/${region['id']}');

                                                      // Set headers
                                                      var headers = {
                                                        'Content-Type': 'application/json',
                                                        'Authorization': 'Bearer ${FFAppState().jwttoken}'
                                                      };

                                                      var response = await http.delete(url, headers: headers);

                                                      if (response.statusCode == 200) {

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

                                                        }

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
                                      },
                                    )
                                  ],
                                ),
                              ),
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
      ),
    );
  }
}
