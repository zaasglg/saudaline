import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sauda_line/app_state.dart';
import 'package:sauda_line/flutter_flow/flutter_flow_theme.dart';
import 'package:sauda_line/main.dart';
import 'package:sauda_line/provider/brands/brands_create_page.dart';

class BrandsPageWidget extends StatefulWidget {
  const BrandsPageWidget({Key? key}) : super(key: key);

  @override
  State<BrandsPageWidget> createState() => _BrandsPageWidgetState();
}

class _BrandsPageWidgetState extends State<BrandsPageWidget> {

  Future<List<dynamic>> fetchBrandList() async {
    final response = await http.get(
        Uri.parse('https://server.saudaline.kz/api/v1/brands/get-all'),
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return NavBarPage(currentPageName: "profile",);
        }));

        return false;
      },
      child: Scaffold(
        backgroundColor: CupertinoColors.systemGrey6,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          title: const Text('Бренды',
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
                    return BrandsCreatePage();
                  }));
                },
                icon: Icon(Icons.add)
            )
          ],
        ),
        body: SafeArea(
          child: FutureBuilder<List<dynamic>>(
            future: fetchBrandList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var brand = snapshot.data![index];

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                        padding: EdgeInsets.symmetric(vertical: 10.0),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7.0)
                        ),
                        child: ListTile(
                          // leading: Container(
                          //   width: 100.0,
                          //   height: 50.0,
                          //   child: Column(
                          //     children: [
                          //       if (brand["logo"].length > 0) ...[
                          //         Image.network(brand["logo"][0]["url"], width: 100,height: 50, fit: BoxFit.cover,)
                          //       ]
                          //       else ...[
                          //         SizedBox(width: 100,)
                          //       ]
                          //     ],
                          //   ),
                          // ),
                          title: Text(brand['name'], style: const TextStyle(
                              fontFamily: "Futura",
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                          ),),

                          trailing: Container(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                    return BrandsCreatePage(brand: brand,);
                                  }));
                                }, icon: const Icon(Icons.edit_outlined), color: Colors.green,),
                                IconButton(
                                    onPressed: () async {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Предупреждение'),
                                            content: const SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  Text('Вы хотите удалить эту категорию?'),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('Удалить'),
                                                onPressed: () async {

                                                  var url = Uri.parse('https://server.saudaline.kz/api/v1/brands/${brand['id']}');

                                                  // Set headers
                                                  var headers = {
                                                    'Content-Type': 'application/json',
                                                    'Authorization': 'Bearer ${FFAppState().jwttoken}'
                                                  };

                                                  var response = await http.delete(url, headers: headers);

                                                  if (response.statusCode == 200) {

                                                    setState(() {});

                                                    Navigator.of(context).pop();

                                                  } else {
                                                    print('Failed to send data. Error code: ${response.statusCode}');
                                                  }

                                                },
                                              ),
                                              TextButton(
                                                child: const Text('Отмена'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent,)
                                ),
                              ],
                            ),
                          ),
                          onTap: () {

                          },
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
