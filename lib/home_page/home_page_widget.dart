import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sauda_line/common/city/city_selection_pega/city_selection_pega_widget.dart';
import 'package:sauda_line/common/informations/about_us/about_us_widget.dart';
import 'package:sauda_line/common/informations/customers_info/customers_info_widget.dart';
import 'package:sauda_line/common/informations/providers_info/providers_info_widget.dart';
import 'package:sauda_line/index.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '../models/Product.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:smooth_page_indicator/smooth_page_indicator.dart' as smooth_page_indicator;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlparser;

class HomePageWidget extends StatefulWidget {
  final VoidCallback? changeIsHomePage;
  const HomePageWidget({super.key, this.changeIsHomePage});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<List<Product>> futureProducts;


  // search
  TextEditingController _searchController = TextEditingController();
  List<Product> _products = [];

  Timer? _timer;

  Future<String> fetchContentEmail() async {
    final response = await http.get(Uri.parse('http://server.saudaline.kz/api/v1/content/get-content?type=EMAIL'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      final converter = QuillDeltaToHtmlConverter(
        List.castFrom(Document.fromJson(jsonDecode(data["valueRu"])).toDelta().toJson()),
        ConverterOptions.forEmail(),
      );

      final html = converter.convert();

      return html;
    } else {
      throw Exception('Failed to load content');
    }
  }

  Future<String> fetchContentTel() async {
    final response = await http.get(Uri.parse('http://server.saudaline.kz/api/v1/content/get-content?type=TEL'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      final converter = QuillDeltaToHtmlConverter(
        List.castFrom(Document.fromJson(jsonDecode(data["valueRu"])).toDelta().toJson()),
        ConverterOptions.forEmail(),
      );

      final html = converter.convert();

      return html;
    } else {
      throw Exception('Failed to load content');
    }
  }


  Future<List<Product>> fetchProducts(String article) async {
    final response = await http.get(
      Uri.parse('https://server.saudaline.kz/api/v1/product/get-all-by-article/$article?page=0&pageSize=30'),
    );

    if (response.statusCode == 200) {
      List<Product> products = [];
      final data = jsonDecode(response.body);
      for (var item in data['content']) {
        products.add(Product.fromJson(item));
      }
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  void _showProductList(String article) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder<List<Product>>(
          future: fetchProducts(article),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Dialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          snapshot.data!.isNotEmpty ? 'Товары' : 'Товар не найден',
                          style: TextStyle(
                            fontFamily: "Futura",
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: snapshot.data!.map((product) {
                            return ListTile(
                              title: Text(product.title, style: const TextStyle(
                                fontFamily: "Atyp",
                                fontWeight: FontWeight.bold
                              ),),
                              subtitle: Text(product.description, style: const TextStyle(
                                fontFamily: "Avenir"
                              ),),
                              trailing: Text('${product.price.toStringAsFixed(2)} ₸'),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                  return ProductPageWidget(id: product.id);
                                }));
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Закрыть', style: TextStyle(
                            fontFamily: "Futura",
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

  void _showExitConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Выйти из приложения?"),
          content: const Text("Вы уверены, что хотите выйти из приложения?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Отменить"),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: const Text("Выход"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {

    super.initState();
    
    _model = createModel(context, () => HomePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.cityName = await actions.getCityName();
      _model.cityId = await actions.getCityId();
      setState(() {
        FFAppState().cityId = _model.cityId!;
        FFAppState().cityName = _model.cityName!;
      });
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async {
          _showExitConfirmationDialog(context);
          return false;
        },
        child: Scaffold(
          key: scaffoldKey,
          drawer: Drawer(
            elevation: 16.0,
            child: WebViewAware(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10.0, 40.0, 10.0, 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/logo-saudaline-min.png',
                          width: double.infinity,
                          height: 100.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                      child: Text(
                        'Ваш город:',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 16.0,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {

                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            return const CitySelectionPegaWidget();
                          }));
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 10.0),
                              child: Text(
                                FFAppState().cityName,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: const Color(0xFF08558E),
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 0.0, 0.0),
                              child: Icon(
                                Icons.location_on,
                                color: Color(0xFF048028),
                                size: 24.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListView(
                      padding: EdgeInsets.zero,
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {

                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return AboutUsWidget();
                            }));

                          },
                          child: ListTile(
                            title: Text(
                              'О компании',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 20.0,
                            ),
                            tileColor:
                                FlutterFlowTheme.of(context).secondaryBackground,
                            dense: false,
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return ProvidersInfoWidget();
                            }));
                          },
                          child: ListTile(
                            title: Text(
                              'Поставщикам',
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    fontFamily: 'Outfit',
                                    fontSize: 18.0,
                                  ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 20.0,
                            ),
                            tileColor:
                                FlutterFlowTheme.of(context).secondaryBackground,
                            dense: false,
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {

                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return CustomersInfoWidget();
                            }));

                          },
                          child: ListTile(
                            title: Text(
                              'Торговым точкам',
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    fontFamily: 'Outfit',
                                    fontSize: 18.0,
                                  ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 20.0,
                            ),
                            tileColor:
                                FlutterFlowTheme.of(context).secondaryBackground,
                            dense: false,
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {

                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return ContactsInfoWidget();
                            }));

                          },
                          child: ListTile(
                            title: Text(
                              'Контакты',
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    fontFamily: 'Outfit',
                                    fontSize: 18.0,
                                  ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 20.0,
                            ),
                            tileColor:
                                FlutterFlowTheme.of(context).secondaryBackground,
                            dense: false,
                          ),
                        ),
                      ],
                    ),
                    FutureBuilder(
                        future: fetchContentEmail(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const CupertinoActivityIndicator();
                          }

                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).secondaryBackground,
                            ),
                            alignment: const AlignmentDirectional(-1.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Html(
                                  data: """${snapshot.data}""",
                                )
                              ],
                            ),
                          );
                        }
                    ),
                    FutureBuilder(
                        future: fetchContentTel(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const CupertinoActivityIndicator();
                          }

                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).secondaryBackground,
                            ),
                            alignment: const AlignmentDirectional(-1.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Html(
                                  data: """${snapshot.data}""",
                                )
                              ],
                            ),
                          );
                        }
                    ),
                  ],
                ),
              ),
            ),
          ),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(160.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: const BoxDecoration(
                color: Color(0xffE8751A),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Builder(
                            builder: (context) => CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: const Icon(Icons.menu, color: Colors.white,),
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                }
                            ),
                        ),

                        const Spacer(),

                        const Text("SAUDALINE.KZ", style: TextStyle(
                          fontFamily: "Gilroy",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),),

                        const Spacer(),
                        const Spacer(),


                      ],
                    ),

                    Container(
                      margin: const EdgeInsets.only(top: 35.0),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100.0)
                              ),
                              child: TextField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                                  hintText: 'Быстрый поиск',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff222222),
                                      fontFamily: "Futura",
                                  ),
                                  icon: const Icon(Icons.search)
                                ),
                                textAlignVertical: TextAlignVertical.center,
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                    return const SearchPageWidget();
                                  }));
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0,),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(100))
                            ),
                            child: CupertinoButton(
                              padding: const EdgeInsets.all(10.0),
                              onPressed: () async {
                                var res = await Navigator.push(context,
                                    MaterialPageRoute(
                                      builder: (context) => const SimpleBarcodeScannerPage(
                                        cancelButtonText: "Назад",
                                      ),
                                    ));

                                setState(() async {
                                    _showProductList(res);
                                });

                              },
                              child: Image.asset("assets/images/barcode.png", height: 30.0, color: Colors.black87,),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Container(
            color: isDarkMode ? Color(0xff1d2428) : Colors.white,
            child: SafeArea(
              top: true,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                child: ListView(
                  padding: EdgeInsets.zero,
                  primary: false,
                  scrollDirection: Axis.vertical,
                  children: [
                    const SizedBox(height: 10.0,),

                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('Категорий товаров', style: TextStyle(
                                        fontFamily: 'Futura',
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                            ),

                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                // context.pushNamed('Catalog');
                                pushNewScreen(context, screen: const CatalogWidget());
                                widget.changeIsHomePage!();
                              },
                              child: const Text(
                                'Все',
                                style: TextStyle(
                                  fontFamily: 'Futura',
                                  color: CupertinoColors.label
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      width: double.infinity,
                      height: 140.0,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                        child: FutureBuilder<ApiCallResponse>(
                          future: ProvidersCategoryCall.call(),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                ),
                              );
                            }
                            final listViewProvidersCategoryResponse = snapshot.data!;
                            return Builder(
                              builder: (context) {
                                final providerCategory = getJsonField(listViewProvidersCategoryResponse.jsonBody, r'''$[:]''',).toList().take(5).toList();
                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: providerCategory.length,
                                  itemBuilder: (context, providerCategoryIndex) {
                                    final providerCategoryItem = providerCategory[providerCategoryIndex];
                                    return Container(
                                      margin: const EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {

                                          // pushNewScreen(context, screen: CategoryProvidersWidget(
                                          //   categoryTitle: serializeParam(getJsonField(providerCategoryItem, r'''$.nameRu''',).toString(), ParamType.String,),
                                          //   categoryId: int.tryParse(serializeParam(getJsonField(providerCategoryItem, r'''$.id''',), ParamType.int,) ?? '0'),
                                          // ));

                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                            return CategoryProvidersWidget(
                                              categoryTitle: serializeParam(getJsonField(providerCategoryItem, r'''$.nameRu''',).toString(), ParamType.String,),
                                              categoryId: int.tryParse(serializeParam(getJsonField(providerCategoryItem, r'''$.id''',), ParamType.int,) ?? '0'),
                                            );
                                          }));


                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 80.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                              ),
                                              child: Image.network(
                                                getJsonField(
                                                  providerCategoryItem,
                                                  r'''$.photo[:1].url''',
                                                ).toString(),
                                                fit: BoxFit.cover,
                                              ),
                                            ),

                                            SizedBox(height: 10.0,),

                                            Container(
                                              decoration: const BoxDecoration(),
                                              child: Center(
                                                child: Text(
                                                  getJsonField(providerCategoryItem, r'''$.nameRu''',)
                                                      .toString()
                                                      .toUpperCase()
                                                      .maybeHandleOverflow(maxChars: 20, replacement: '…',),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      color: isDarkMode ? Colors.white : Colors.black87,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "Futura",
                                                      fontSize: 13.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        // context.pushNamed('CitySelectionPega');
                        pushNewScreen(context, screen: const CitySelectionPegaWidget());

                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {

                          return const CitySelectionPegaWidget();
                        })).then((value) {
                          setState(() {
                            // Call setState to refresh the page.
                          });
                        });
                        widget.changeIsHomePage!();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: StreamBuilder<Object>(
                          stream: null,
                          builder: (context, snapshot) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [


                                Container(
                                  margin: const EdgeInsets.only(top: 5.0),
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: isDarkMode ? Colors.white54 : Colors.black12,
                                        width: 1
                                      )
                                    )
                                  ),
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Text(FFAppState().cityName, style: TextStyle(
                                        fontFamily: 'Futura', color: isDarkMode ? Colors.white : Colors.black,
                                        fontSize: 18.0, fontWeight: FontWeight.w400,), textAlign: TextAlign.start,
                                      ),

                                      const Spacer(),


                                      const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: CupertinoColors.systemGrey,)
                                    ],
                                  )
                                ),
                              ],
                            );
                          }
                        ),
                      ),
                    ),

                    FutureBuilder<ApiCallResponse>(
                      future: GetAllActivePromotionsCall.call(
                        cityId: FFAppState().cityId,
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        final pageViewGetAllActivePromotionsResponse = snapshot.data!;
                        return Builder(
                          builder: (context) {
                            final promotion = GetAllActivePromotionsCall.promotionList(pageViewGetAllActivePromotionsResponse.jsonBody,)?.toList() ?? [];
                            List<Color> gradientColors = [
                              Colors.blue,
                              Colors.green,
                              Colors.red,
                              Colors.orange,
                              // Add more colors as needed
                            ];
                            if (promotion.length > 0) {
                              return Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                child: Container(
                                  width: 100.0,
                                  height: 200.0,
                                  decoration: const BoxDecoration(),
                                  child: Align(
                                    alignment: const AlignmentDirectional(0.0, 0.0),
                                    child: Stack(
                                      children: [
                                        CarouselSlider(
                                          options: CarouselOptions(
                                            height: 200.0,
                                            autoPlay: true,
                                            viewportFraction: 1,
                                            autoPlayAnimationDuration: Duration(seconds: 2),
                                            autoPlayInterval: Duration(seconds: 6),
                                            scrollDirection: Axis.horizontal,
                                          ),
                                          items: promotion.map((i) {
                                            return Builder(
                                              builder: (BuildContext context) {
                                                return Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                    decoration: BoxDecoration(
                                                      color: isDarkMode ? Colors.black38 : CupertinoColors.systemGrey6,
                                                      borderRadius: BorderRadius.circular(10.0),
                                                      border: Border.all(
                                                          width: 2,
                                                          color: isDarkMode ? Colors.black : CupertinoColors.systemGrey6
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Flexible(
                                                                child: Text("${i['title']}", style: TextStyle(
                                                                    fontSize: 16.0,
                                                                    fontFamily: "Futura",
                                                                    fontWeight: FontWeight.w700,
                                                                    color: isDarkMode ? Colors.white : Colors.black87),
                                                                  textAlign: TextAlign.start,
                                                                ),
                                                              ),
                                                              Flexible(
                                                                child: Text("${i['subTitle']}", style: TextStyle(
                                                                    fontSize: 14.0,
                                                                    fontFamily: "Futura",
                                                                    fontWeight: FontWeight.w400,
                                                                    color: isDarkMode ? Colors.white : Colors.black54),
                                                                  textAlign: TextAlign.start,
                                                                ),
                                                              ),
                                                              TextButton(
                                                                  style: ButtonStyle(
                                                                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                                                                  ),
                                                                  child: const Text("Перейти", style: TextStyle(
                                                                      fontFamily: "Gilroy",
                                                                      fontWeight: FontWeight.w600,
                                                                      color: Colors.black87,

                                                                  )),
                                                                  onPressed: () {
                                                                    context.pushNamed('PromotionPage', queryParameters: {'promotionId': serializeParam(i['id'], ParamType.int,),}.withoutNulls,);
                                                                  }
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 10.0,),
                                                        Container(
                                                          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
                                                          child: Image.network(i['photo'][0]['url'].toString(),
                                                            width: 120.0,
                                                            height: 110.0,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                );
                                              },
                                            );
                                          }).toList(),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }

                            return Container();
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 20.0,),

                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color(0x00FFFFFF),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Популярные товары', style: TextStyle(
                                        fontFamily: 'Atyp',
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 40.0),
                          child: FutureBuilder<ApiCallResponse>(
                            future: GetPopularProductsCall.call(cityId: FFAppState().cityId,),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              final gridViewGetPopularProductsResponse = snapshot.data!;
                              return Builder(
                                builder: (context) {
                                  final product = getJsonField(gridViewGetPopularProductsResponse.jsonBody, r'''$''',).toList().take(6).toList();
                                  return GridView.builder(
                                    padding: EdgeInsets.zero,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10.0,
                                      mainAxisSpacing: 10.0,
                                      childAspectRatio: 0.7,
                                    ),
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: product.length,
                                    itemBuilder: (context, productIndex) {
                                      final productItem = product[productIndex];
                                      return Visibility(
                                        visible: getJsonField(gridViewGetPopularProductsResponse.jsonBody, r'''$[:1].id''',) != null,
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                              return ProductPageWidget(
                                                id: int.tryParse(serializeParam(getJsonField(productItem, r'''$.id''',), ParamType.int,) ?? '0'),
                                              );
                                            }));

                                            if (!FFAppState()
                                                .lastViewed
                                                .containsMap(getJsonField(
                                                  productItem,
                                                  r'''$''',
                                                ))) {
                                              setState(() {
                                                FFAppState()
                                                    .addToLastViewed(getJsonField(
                                                  productItem,
                                                  r'''$''',
                                                ));
                                              });
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: isDarkMode ? Colors.black38 : CupertinoColors.systemGrey6
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(8.0),
                                                      child: Image.network(
                                                        valueOrDefault<String>(getJsonField(productItem, r'''$.mainPhoto.url''',)?.toString(), 'https://saudaline.kz/images/logo.png',),
                                                        width: double.infinity,
                                                        height: 100.0,
                                                        fit: BoxFit.fitWidth,
                                                      ),
                                                    ),
                                                    if (getJsonField(productItem, r'''$.discount''',) != null ? true : false)
                                                      Align(
                                                        alignment: const AlignmentDirectional(1.0, 1.0),
                                                        child: Padding(
                                                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 75.0, 8.0, 0.0),
                                                          child: Container(
                                                            width: 40.0,
                                                            height: 20.0,
                                                            decoration: BoxDecoration(color: const Color(0xFFCF1212),
                                                              borderRadius: BorderRadius.circular(40.0),
                                                            ),
                                                            alignment: const AlignmentDirectional(0.0, 0.0),
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.max,
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Text(
                                                                  getJsonField(productItem, r'''$.discount''',).toString(),
                                                                  style: const TextStyle(fontFamily: 'Gilroy', color: Colors.white,),
                                                                ),
                                                                const Text('%',
                                                                  style: TextStyle(
                                                                        fontFamily: 'Gilroy',
                                                                        color: Colors.white,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),

                                                Spacer(),

                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                  child: Text(
                                                    getJsonField(productItem, r'''$.title''',)
                                                        .toString()
                                                        .maybeHandleOverflow(
                                                          maxChars: 50,
                                                          replacement: '…',
                                                        ),
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(fontFamily: 'Atyp', fontWeight: FontWeight.w800, fontSize: 15.0),
                                                  ),
                                                ),
                                                const SizedBox(height: 10.0,),
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(2.0, 0.0, 0.0, 0.0),
                                                  child: AutoSizeText(
                                                    getJsonField(
                                                      productItem,
                                                      r'''$.category.title''',
                                                    )
                                                        .toString()
                                                        .maybeHandleOverflow(
                                                          maxChars: 15,
                                                          replacement: '…',
                                                        ),
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                          fontFamily: 'Atyp',
                                                          color: Color(0xFF626262),
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.w200,
                                                        ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                              2.0, 2.0, 0.0, 0.0),
                                                      child: Text(
                                                        getJsonField(
                                                          productItem,
                                                          r'''$.discountprice''',
                                                        ).toString(),
                                                        textAlign: TextAlign.start,
                                                        style: const TextStyle(
                                                              fontFamily: 'Atyp',
                                                              fontWeight: FontWeight.w800, fontSize: 20.0
                                                            ),
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 0.0, 0.0),
                                                      child: Text('₸'),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),


                    if (FFAppState().lastViewed.length > 0)
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Opacity(
                            opacity: 0.3,
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 5.0),
                              child: Container(
                                width: double.infinity,
                                height: 2.0,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFA2A2A2),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              'Вы недавно посмотрели',
                              style: TextStyle(
                                    fontFamily: 'Futura',
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          if (FFAppState().lastViewed.length.toString() != null && FFAppState().lastViewed.length.toString() != ''
                              ? true
                              : false)
                            Container(
                              width: double.infinity,
                              height: 220.0,
                              decoration: const BoxDecoration(
                                color: Color(0x00FFFFFF),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5.0, 5.0, 0.0, 5.0),
                                child: Builder(
                                  builder: (context) {
                                    final viewedProduct = FFAppState().lastViewed.take(5).toList().take(5).toList();

                                    return ListView.separated(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: viewedProduct.length,
                                      reverse: false,
                                      separatorBuilder: (_, __) => const SizedBox(width: 13.0),
                                      itemBuilder: (context, viewedProductIndex) {
                                        final viewedProductItem = viewedProduct[viewedProductIndex];
                                        return InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                              return ProductPageWidget(
                                                id: int.tryParse(serializeParam(getJsonField(viewedProductItem, r'''$.id''',), ParamType.int,) ?? '0'),
                                              );
                                            }));
                                          },
                                          child: Container(
                                            width: 100.0,
                                            height: 500.0,
                                            constraints: const BoxConstraints(
                                              minHeight: 200.0,
                                              maxHeight: 500.0,
                                            ),
                                            decoration: const BoxDecoration(),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8.0),
                                                  child: Image.network(
                                                    valueOrDefault<String>(
                                                      getJsonField(
                                                        viewedProductItem,
                                                        r'''$.mainPhoto.url''',
                                                      )?.toString(),
                                                      'https://images.unsplash.com/photo-1589217157232-464b505b197f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw0fHxhcHBsZXxlbnwwfHx8fDE2OTEzMjYzNzB8MA&ixlib=rb-4.0.3&q=80&w=1080',
                                                    ),
                                                    width: double.infinity,
                                                    height: 100.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional.fromSTEB(2.0, 5.0, 0.0, 0.0),
                                                  child: Text(
                                                    getJsonField(
                                                      viewedProductItem,
                                                      r'''$.title''',
                                                    ).toString().maybeHandleOverflow(
                                                          maxChars: 19,
                                                          replacement: '…',
                                                        ),
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                          fontFamily: 'Futura',
                                                          fontWeight: FontWeight.w500,
                                                          height: 1.0
                                                        ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional.fromSTEB(
                                                          2.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    getJsonField(
                                                      viewedProductItem,
                                                      r'''$.category.title''',
                                                    ).toString().maybeHandleOverflow(
                                                          maxChars: 14,
                                                          replacement: '…',
                                                        ),
                                                    textAlign: TextAlign.start,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Readex Pro',
                                                          color: const Color(0xFF626262),
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional.fromSTEB(
                                                          2.0, 2.0, 0.0, 0.0),
                                                  child: Text(
                                                    getJsonField(
                                                      viewedProductItem,
                                                      r'''$.discountprice''',
                                                    ).toString(),
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                          fontFamily: 'Futura',
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          )

        ),
      ),
    );
  }
}
