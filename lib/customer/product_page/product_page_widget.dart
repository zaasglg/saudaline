import '../../main.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_count_controller.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'product_page_model.dart';
export 'product_page_model.dart';

class ProductPageWidget extends StatefulWidget {
  const ProductPageWidget({
    super.key,
    required this.id,
  });

  final int? id;

  @override
  State<ProductPageWidget> createState() => _ProductPageWidgetState();
}

class _ProductPageWidgetState extends State<ProductPageWidget>
    with TickerProviderStateMixin {
  late ProductPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProductPageModel());
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

    return FutureBuilder<ApiCallResponse>(
      future: GetProductByIdCall.call(
        id: widget.id,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        final productPageGetProductByIdResponse = snapshot.data!;

        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 400.0,
                          decoration: BoxDecoration(
                            color: const Color(0xFFDBE2E7),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Hero(
                                  tag: getJsonField(productPageGetProductByIdResponse.jsonBody, r'''$.mainPhoto''',) != null
                                      ? getJsonField(productPageGetProductByIdResponse.jsonBody, r'''$.mainPhoto.url''',).toString() : 'https://saudaline.kz/images/logo.png',
                                  transitionOnUserGestures: true,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(0.0),
                                    child: Image.network(
                                      getJsonField(productPageGetProductByIdResponse.jsonBody, r'''$.mainPhoto''',) != null
                                          ? getJsonField(productPageGetProductByIdResponse.jsonBody, r'''$.mainPhoto.url''',).toString() : 'https://saudaline.kz/images/logo.png',
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          if (false)
                                            Card(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              color: const Color(0x3A000000),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: FlutterFlowIconButton(
                                                borderColor: Colors.transparent,
                                                borderRadius: 30.0,
                                                buttonSize: 46.0,
                                                icon: const Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.white,
                                                  size: 24.0,
                                                ),
                                                onPressed: () {
                                                  print(
                                                      'IconButton pressed ...');
                                                },
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        if (getJsonField(
                                                  productPageGetProductByIdResponse
                                                      .jsonBody,
                                                  r'''$.discount''',
                                                ) !=
                                                null
                                            ? true
                                            : false)
                                          Container(
                                            width: 60.0,
                                            height: 30.0,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFCF1212),
                                              borderRadius: BorderRadius.circular(40.0),
                                            ),
                                            alignment: const AlignmentDirectional(0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  getJsonField(productPageGetProductByIdResponse.jsonBody, r'''$.discount''',).toString(),
                                                  style: FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Readex Pro',
                                                        color: Colors.white,
                                                        fontSize: 16.0,
                                                      ),
                                                ),
                                                Text(
                                                  '%',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color: Colors.white,
                                                        fontSize: 16.0,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 24.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: AutoSizeText(
                                  getJsonField(
                                    productPageGetProductByIdResponse.jsonBody,
                                    r'''$.title''',
                                  ).toString().maybeHandleOverflow(
                                        maxChars: 100,
                                        replacement: '…',
                                      ),
                                  maxLines: 2,
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                        fontFamily: 'Outfit',
                                        fontSize: 18.0,
                                      ),
                                  minFontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24.0, 4.0, 24.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                getJsonField(
                                  productPageGetProductByIdResponse.jsonBody,
                                  r'''$.category.title''',
                                ).toString(),
                                style: FlutterFlowTheme.of(context).labelMedium,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24.0, 4.0, 24.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                getJsonField(
                                  productPageGetProductByIdResponse.jsonBody,
                                  r'''$.discountprice''',
                                ).toString(),
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                      fontFamily: 'Outfit',
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                    ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  '₸',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        fontSize: 20.0,
                                      ),
                                ),
                              ),
                              if (getJsonField(
                                        productPageGetProductByIdResponse
                                            .jsonBody,
                                        r'''$.discount''',
                                      ) !=
                                      null
                                  ? true
                                  : false)
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    getJsonField(
                                      productPageGetProductByIdResponse
                                          .jsonBody,
                                      r'''$.price''',
                                    ).toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontSize: 20.0,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (false)
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24.0, 8.0, 24.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  getJsonField(
                                    productPageGetProductByIdResponse.jsonBody,
                                    r'''$.hits''',
                                  ).toString(),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                      ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    valueOrDefault<String>(
                                      functions.appStateToPrint(
                                          FFAppState().cardProducts.toList()),
                                      '0',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24.0, 8.0, 24.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 8.0, 0.0),
                                child: Text(
                                  'Поставщик:',
                                  style:
                                      FlutterFlowTheme.of(context).labelMedium,
                                ),
                              ),
                              Text(
                                getJsonField(
                                  productPageGetProductByIdResponse.jsonBody,
                                  r'''$.provider.name''',
                                ).toString(),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24.0, 8.0, 24.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 8.0, 0.0),
                                child: Text(
                                  'Торговая марка:',
                                  style:
                                      FlutterFlowTheme.of(context).labelMedium,
                                ),
                              ),
                              Text(
                                getJsonField(
                                  productPageGetProductByIdResponse.jsonBody,
                                  r'''$.brand.name''',
                                ).toString(),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24.0, 12.0, 24.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Описание',
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24.0, 4.0, 24.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Text(
                                  getJsonField(
                                    productPageGetProductByIdResponse.jsonBody,
                                    r'''$.description''',
                                  ).toString(),
                                  style:
                                      FlutterFlowTheme.of(context).labelMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (!FFAppState().isProvider)
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(0.0),
                      border: Border.all(
                        color: isDarkMode ? Colors.black : const Color(0xFFA6A6A6),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  height: 50.0,
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(color: FlutterFlowTheme.of(context).secondaryBackground,
                                    borderRadius: BorderRadius.circular(8.0),
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context).alternate,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: FlutterFlowCountController(
                                    decrementIconBuilder: (enabled) =>
                                        FaIcon(FontAwesomeIcons.minus, color: enabled
                                            ? FlutterFlowTheme.of(context).secondaryText
                                            : FlutterFlowTheme.of(context).alternate, size: 20.0,
                                        ),
                                    incrementIconBuilder: (enabled) =>
                                        FaIcon(FontAwesomeIcons.plus, color: enabled
                                            ? isDarkMode ? Colors.white :Colors.black
                                            : FlutterFlowTheme.of(context).alternate, size: 20.0,
                                        ),
                                    countBuilder: (count) => SizedBox(
                                      width: 50.0,
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          hintText: count.toString(),
                                          hintStyle: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        onChanged: (value) {

                                          setState(() {_model.countControllerValue = int.parse(value);});
                                          setState(() {
                                            FFAppState().basketProducts =
                                                functions.generatJsonProduct(
                                                    widget.id, _model.countControllerValue,
                                                    FFAppState().basketProducts.toList(),
                                                    getJsonField(productPageGetProductByIdResponse.jsonBody, r'''$.provider.id''',),
                                                    getJsonField(productPageGetProductByIdResponse.jsonBody, r'''$.provider.name''',).toString(),
                                                    getJsonField(productPageGetProductByIdResponse.jsonBody, r'''$.provider.logotype[:1].url''',).toString(),
                                                    GetProductByIdCall.price(productPageGetProductByIdResponse.jsonBody,),
                                                    GetProductByIdCall.productImage(productPageGetProductByIdResponse.jsonBody,),
                                                    GetProductByIdCall.productName(productPageGetProductByIdResponse.jsonBody,),
                                                    valueOrDefault<int>(GetProductByIdCall.discount(productPageGetProductByIdResponse.jsonBody,), 0,)
                                                )!
                                                    .toList()
                                                    .cast<dynamic>();

                                          });

                                        },
                                      ),
                                    ),
                                    count: _model.countControllerValue ??= valueOrDefault<int>(
                                      functions.getProductQuantity(widget.id, getJsonField(productPageGetProductByIdResponse.jsonBody, r'''$.provider.id''',), FFAppState().basketProducts.toList()), 1,
                                    ),
                                    updateCount: (count) async {
                                      setState(() => _model.countControllerValue = count);
                                      setState(() {
                                        FFAppState().basketProducts =
                                            functions
                                                .generatJsonProduct(
                                                widget.id, _model.countControllerValue,
                                                FFAppState().basketProducts.toList(),
                                                getJsonField(productPageGetProductByIdResponse.jsonBody, r'''$.provider.id''',),
                                                getJsonField(productPageGetProductByIdResponse.jsonBody, r'''$.provider.name''',).toString(),
                                                getJsonField(productPageGetProductByIdResponse.jsonBody, r'''$.provider.logotype[:1].url''',).toString(),
                                                GetProductByIdCall.price(productPageGetProductByIdResponse.jsonBody,),
                                                GetProductByIdCall.productImage(productPageGetProductByIdResponse.jsonBody,),
                                                GetProductByIdCall.productName(productPageGetProductByIdResponse.jsonBody,),
                                                valueOrDefault<int>(GetProductByIdCall.discount(productPageGetProductByIdResponse.jsonBody,), 0,)
                                            )!
                                                .toList()
                                                .cast<dynamic>();

                                      });
                                    },
                                    stepSize: 1,
                                    minimum: 1,
                                  ),
                                ),
                                if (!FFAppState().cardProducts.contains(getJsonField(productPageGetProductByIdResponse.jsonBody, r'''$.id''',)))
                                  FFButtonWidget(
                                    onPressed: () async {
                                      if (FFAppState().cardProducts.contains(widget.id)) {
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return WebViewAware(
                                              child: AlertDialog(
                                                title: const Text('Уже есть в корзине'),
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
                                        setState(() {
                                          FFAppState().addToCardProducts(widget.id!);
                                          FFAppState().addToCardProviders(getJsonField(productPageGetProductByIdResponse.jsonBody, r'''$.provider.id''',));
                                          FFAppState().basketProducts =
                                              functions
                                                  .generatJsonProduct(widget.id, valueOrDefault<int>(_model.countControllerValue, 1,), FFAppState().basketProducts.toList(),
                                                      getJsonField(productPageGetProductByIdResponse.jsonBody, r'''$.provider.id''',),
                                                      getJsonField(productPageGetProductByIdResponse.jsonBody, r'''$.provider.name''',).toString(),
                                                      GetProductByIdCall.providerLogo(productPageGetProductByIdResponse.jsonBody,),
                                                      GetProductByIdCall.price(productPageGetProductByIdResponse.jsonBody,),
                                                      GetProductByIdCall.productImage(productPageGetProductByIdResponse.jsonBody,),
                                                      GetProductByIdCall.productName(productPageGetProductByIdResponse.jsonBody,),
                                                      valueOrDefault<int>(GetProductByIdCall.discount(productPageGetProductByIdResponse.jsonBody,), 0,))!
                                                  .toList()
                                                  .cast<dynamic>();
                                        });
                                      }
                                    },
                                    text: 'В корзину',
                                    icon: const Icon(Icons.shopping_cart_outlined, size: 15.0,),
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 50.0,
                                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                      iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context).primary, textStyle: const TextStyle(
                                            fontFamily: 'Gilroy',
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                      elevation: 3.0,
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                if (FFAppState().cardProducts.contains(widget.id))
                                if (FFAppState().cardProducts.contains(getJsonField(productPageGetProductByIdResponse.jsonBody, r'''$.id''',)))
                                  FFButtonWidget(
                                    onPressed: () async {

                                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                                        return NavBarPage(currentPageName: "cart",);
                                      }));

                                      // setState(() {
                                      //   FFAppState().removeFromCardProducts(widget.id!);
                                      //   FFAppState().basketProducts =
                                      //       functions
                                      //           .deleteFromBasket(getJsonField(productPageGetProductByIdResponse.jsonBody, r'''$.provider.id''',), widget.id, FFAppState().basketProducts.toList())!
                                      //           .toList()
                                      //           .cast<dynamic>();
                                      // });
                                    },
                                    text: 'Перейти в корзину',
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 50.0,
                                      color: FlutterFlowTheme.of(context).primary,
                                      textStyle: const TextStyle(
                                                fontFamily: 'Gilroy',
                                                color: Colors.white,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                      elevation: 3.0,
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
