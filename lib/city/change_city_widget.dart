import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sauda_line/app_state.dart';
import 'package:sauda_line/flutter_flow/flutter_flow_icon_button.dart';
import 'package:sauda_line/flutter_flow/flutter_flow_theme.dart';
import 'package:http/http.dart' as http;

class ChangeCityWidget extends StatefulWidget {
  const ChangeCityWidget({Key? key}) : super(key: key);

  @override
  State<ChangeCityWidget> createState() => _ChangeCityWidgetState();
}

class _ChangeCityWidgetState extends State<ChangeCityWidget> {


  late Future<List<dynamic>> futureCities;
  List<dynamic>? cities;

  @override
  void initState() {
    super.initState();
    futureCities = fetchCities();
  }

  Future<List<dynamic>> fetchCities() async {
    final response = await http.get(Uri.parse('https://server.saudaline.kz/api/v1/provider/get-by-userid?id=${FFAppState().accountInfo["id"]}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['city'];
    } else {
      throw Exception('Failed to load cities');
    }
  }

  Future<List<dynamic>> fetchAddCities() async {
    final response = await http.get(Uri.parse('http://server.saudaline.kz/api/v1/city/get-by-city-name'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load cities');
    }
  }


  void deleteCity(int index) {
    setState(() {
      cities?.removeAt(index);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          borderWidth: 1.0,
          buttonSize: 60.0,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Мои города',
          style: FlutterFlowTheme.of(context).headlineMedium.override(
            fontFamily: 'Outfit',
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
        actions: [
          IconButton(onPressed: () {

          }, icon: IconButton(
            icon: Icon(Icons.add_circle_rounded),
            onPressed: () {
              _showCityModal(context);
            },
          ))
        ],
        centerTitle: true,
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                child: Text("Города который я поставляю товар", style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Futura",
                    fontWeight: FontWeight.w500
                ), textAlign: TextAlign.left,),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: FutureBuilder<List<dynamic>>(
                    future: futureCities,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No cities found'));
                      } else {
                        cities ??= snapshot.data!;
                        return ListView.separated(
                          itemCount: cities!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final city = cities![index];
                            final region = city['region'];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(city['name']),
                              subtitle: Text(region['nameRu']),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => deleteCity(index),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: Colors.grey.withOpacity(0.6),
                              thickness: 1,
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () async {

              List<int> citiesData = [];

              cities!.forEach((element) {
                citiesData.add(element["id"] as int);
              });


              String jsonData = jsonEncode(citiesData);

              final response = await http.post(
                Uri.parse('https://server.saudaline.kz/api/v1/admin/change-city'),
                headers: {
                  'Content-Type': 'application/json',
                  'Accept': '*/*',
                  'Authorization': 'Bearer ${FFAppState().jwttoken}'
                },
                body: jsonData,
              );

              if (response.statusCode == 200) {
                print("hello world");
              } else {
                throw Exception('Failed to load data');
              }

            },
            child: Text('Сохранить'),
            style: ElevatedButton.styleFrom(
                backgroundColor: FlutterFlowTheme.of(context).primary,
                padding: EdgeInsets.symmetric(vertical: 15.0)
            ),
          ),
        ),
      ),
    );
  }


  void _showCityModal(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 500,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: FutureBuilder<List<dynamic>>(
                    future: fetchAddCities(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No cities found'));
                      } else {
                        List<dynamic> citiesAdd = snapshot.data!;

                        return ListView.builder(
                          itemCount: citiesAdd.length,
                          itemBuilder: (context, index) {
                            var city = citiesAdd[index];

                            bool _has = false;

                            for (var element in cities!) {
                              if (element["id"] == city["id"]) {
                                _has = true;
                              }
                            }

                            if (_has) {
                              return Container();
                            }

                            return ListTile(
                              onTap: () {
                                setState(() {
                                  cities!.add(city);
                                });

                                Navigator.of(context).pop();
                              },
                              title: Text(city['name']),
                              subtitle: Text(city['region']['nameRu']),
                              trailing: Icon(Icons.add),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
