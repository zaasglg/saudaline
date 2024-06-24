import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sauda_line/flutter_flow/flutter_flow_theme.dart';
import 'package:http/http.dart' as http;
import 'package:sauda_line/flutter_flow/flutter_flow_util.dart';
import 'package:sauda_line/main.dart';
import 'package:sauda_line/provider/category/category_add_widget.dart';


class CategoryWidget extends StatefulWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {

  late ScrollController _scrollController;
  late bool _isVisible;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _isVisible = true;
    _scrollController.addListener(() {
      setState(() {
        // Check if the user has reached the bottom of the scrollable widget
        _isVisible = !(_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent);
      });
    });
  }


  Future<List<dynamic>> fetchCategoryList() async {
    final response = await http.get(Uri.parse('https://server.saudaline.kz/api/v1/categories/get-all'));
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
          title: const Text('Категории',
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
        body: FutureBuilder<List<dynamic>>(
          future: fetchCategoryList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                reverse: true,
                itemBuilder: (context, index) {
                  var category = snapshot.data![index];
                  return Material(
                    child: ListTile(
                      title: Text(category['title'], style: const TextStyle(
                          fontFamily: "Futura",
                          fontSize: 19,
                          fontWeight: FontWeight.w500

                      ),),
                      subtitle: Text(category['description'], style: const TextStyle(
                        fontFamily: "Futura",
                        fontSize: 15,

                      ),),
                      trailing: Container(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(onPressed: () async{
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                return CategoryAddWidget(category: category,);
                              }));
                            }, icon: Icon(Icons.edit)),
                            IconButton(onPressed: () async {

                              var url = Uri.parse('http://server.saudaline.kz/api/v1/categories/get-products-count-by-category/${category["id"]}');

                              // Set headers
                              var headers = {
                                'Content-Type': 'application/json',
                                'Authorization': 'Bearer ${FFAppState().jwttoken}'
                              };

                              var response = await http.get(url, headers: headers);


                              if (response.statusCode == 200) {

                                if (int.parse(response.body) > 0) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Предупреждение'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Text('У этой категории есть ${response.body} товаров. Если вы удалите категорий товары тоже будет удалены'),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('Удалить'),
                                            onPressed: () async {

                                              delete(category["id"]);

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
                                } else {

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Предупреждение'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Text('Вы хотите удалить эту категорию?'),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('Удалить'),
                                            onPressed: () async {

                                              delete(category["id"]);

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

                                }

                              } else {
                                print('Failed to send data. Error code: ${response.statusCode}');
                              }

                            }, icon: Icon(Icons.delete)),
                          ],
                        ),
                      ),
                      onTap: () {

                      },
                    ),
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: _isVisible
            ? FloatingActionButton(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return CategoryAddWidget();
            }));
          },
          child: Icon(Icons.add),
        )
            : null,
      ),
    );
  }

  void delete(int categoryId) async{
    var url = Uri.parse('https://server.saudaline.kz/api/v1/categories/delete-category?id=${categoryId}');

    // Set headers
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${FFAppState().jwttoken}'
    };

    var response = await http.delete(url, headers: headers);

    print(response.body.toString());

    if (response.statusCode == 200) {

      setState(() {

      });

    } else {
      print('Failed to send data. Error code: ${response.statusCode}');
    }
  }
}
