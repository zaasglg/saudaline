import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sauda_line/customer/promotion/providers_promotions/providers_promotions_widget.dart';
import 'package:sauda_line/index.dart';

import '/backend/api_requests/api_calls.dart';
import '/customer/order/promotion_product_discount_change/promotion_product_discount_change_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'promotion_page_provider_model.dart';
export 'promotion_page_provider_model.dart';

class PromotionPageProviderWidget extends StatefulWidget {
  const PromotionPageProviderWidget({
    super.key,
    required this.promotionId,
  });

  final int? promotionId;

  @override
  State<PromotionPageProviderWidget> createState() =>
      _PromotionPageProviderWidgetState();
}

class _PromotionPageProviderWidgetState
    extends State<PromotionPageProviderWidget> {
  late PromotionPageProviderModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PromotionPageProviderModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<ApiCallResponse>(
      future: PromotionGroup.promotionByIdCall.call(
        promotionId: widget.promotionId,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
        final promotionPageProviderPromotionByIdResponse = snapshot.data!;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: WillPopScope(
            onWillPop: () async {

              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ProvidersPromotionsWidget();
              }));

              return false;
            },
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              appBar: AppBar(
                backgroundColor: FlutterFlowTheme.of(context).primary,
                automaticallyImplyLeading: false,
                leading: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30.0,
                  borderWidth: 1.0,
                  buttonSize: 60.0,
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
                title: const Text(
                  'Информация об акции',
                  style: TextStyle(
                        fontFamily: 'Futura',
                        color: Colors.white,
                        fontSize: 17.0,
                      ),
                ),
                actions: [],
                centerTitle: true,
                elevation: 2.0,
              ),
              body: SafeArea(
                top: true,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(10.0, 15.0, 10.0, 5.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 90.0,
                                      height: 90.0,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50.0),
                                          child: CachedNetworkImage(
                                            fadeInDuration: const Duration(milliseconds: 500),
                                            fadeOutDuration: const Duration(milliseconds: 500),
                                            imageUrl: valueOrDefault<String>(
                                              getJsonField(
                                                promotionPageProviderPromotionByIdResponse
                                                    .jsonBody,
                                                r'''$.photo[:1].url''',
                                              )?.toString(),
                                              'https://saudaline.kz/images/logo.png',
                                            ),
                                            width: 40.0,
                                            height: 60.0,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 0.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 230.0,
                                            decoration: const BoxDecoration(),
                                            child: AutoSizeText(
                                              getJsonField(promotionPageProviderPromotionByIdResponse.jsonBody, r'''$.title''',).toString().maybeHandleOverflow(maxChars: 100, replacement: '…',),
                                              maxLines: 2,
                                              style: const TextStyle(
                                                    fontFamily: 'Futura',
                                                    color: Color(0xFF14181B),
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                              minFontSize: 14.0,
                                            ),
                                          ),
                                          Container(
                                            width: 230.0,
                                            decoration: const BoxDecoration(),
                                            child: AutoSizeText(
                                              getJsonField(
                                                promotionPageProviderPromotionByIdResponse
                                                    .jsonBody,
                                                r'''$.subTitle''',
                                              ).toString().maybeHandleOverflow(
                                                    maxChars: 150,
                                                    replacement: '…',
                                                  ),
                                              maxLines: 4,
                                              style: const TextStyle(
                                                    fontFamily: 'Futura',
                                                    color: Color(0xFF14181B),
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                              minFontSize: 14.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 5.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          textScaleFactor: MediaQuery.of(context)
                                              .textScaleFactor,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Организатор:',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                              ),
                                              TextSpan(
                                                text: ' ',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                              ),
                                              TextSpan(
                                                text: getJsonField(
                                                  promotionPageProviderPromotionByIdResponse
                                                      .jsonBody,
                                                  r'''$.provider.name''',
                                                ).toString(),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                              )
                                            ],
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                          child: RichText(
                                            textScaleFactor: MediaQuery.of(context).textScaleFactor,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Статус:',
                                                  style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'Readex Pro',
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' ',
                                                  style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'Readex Pro',
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: promotionPageProviderPromotionByIdResponse.jsonBody["isActive"] == true ? "Активный" : "Не активный",
                                                  style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'Readex Pro',
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                )
                                              ],
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                          child: RichText(
                                            textScaleFactor: MediaQuery.of(context).textScaleFactor,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Дата начало:',
                                                  style:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                ),
                                                TextSpan(
                                                  text: ' ',
                                                  style:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                ),
                                                  TextSpan(
                                                    text: functions.formatDate(promotionPageProviderPromotionByIdResponse.jsonBody["startDate"]) ?? " ",
                                                    style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                      fontFamily:
                                                      'Readex Pro',
                                                      color: Colors.black,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                  )
                                              ],
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 2.0, 0.0, 0.0),
                                          child: RichText(
                                            textScaleFactor:
                                                MediaQuery.of(context)
                                                    .textScaleFactor,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Дата окончания:',
                                                  style:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                ),
                                                TextSpan(
                                                  text: ' ',
                                                  style:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                ),
                                                TextSpan(
                                                  text: valueOrDefault<String>(
                                                    functions
                                                        .formatDate(getJsonField(
                                                      promotionPageProviderPromotionByIdResponse
                                                          .jsonBody,
                                                      r'''$.finishDate''',
                                                    ).toString()),
                                                    '0',
                                                  ),
                                                  style:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                )
                                              ],
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 2.0, 0.0, 0.0),
                                          child: RichText(
                                            textScaleFactor:
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Город:',
                                                  style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'Readex Pro',
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' ',
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Readex Pro',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,),
                                                ),
                                                TextSpan(
                                                  text: valueOrDefault<String>(
                                                    getJsonField(promotionPageProviderPromotionByIdResponse.jsonBody, r'''$.city.name''',).toString(), '0',
                                                  ),
                                                  style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'Readex Pro',
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                )
                                              ],
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(

                            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 10.0, 16.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      _model.apiResultDeletePromotion = await PromotionGroup.deletePromotionByIdCall.call(promotionId: widget.promotionId, jwtToken: FFAppState().jwttoken,);

                                      if ((_model.apiResultDeletePromotion?.succeeded ?? true)) {
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return WebViewAware(
                                              child: AlertDialog(
                                                title: const Text('Успешно выполнено'),
                                                content:
                                                const Text('Акция успешно удалена!'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(
                                                        alertDialogContext),
                                                    child: const Text('Ок'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );

                                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                                          return const ProvidersPromotionsWidget();
                                        }));

                                      } else {
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return WebViewAware(
                                              child: AlertDialog(
                                                title: const Text('Ошибка операции'),
                                                content: const Text(
                                                    'Произошла ошибка при удалении акции.'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(
                                                        alertDialogContext),
                                                    child: const Text('Ок'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      }

                                      setState(() {});
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: CupertinoColors.destructiveRed
                                    ),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.delete),
                                        SizedBox(width: 5.0,),
                                        Text("Удалить", style: TextStyle(
                                            fontFamily: "Futura"
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 13.0,),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                        return PromotionEditPageWidget(promotionId: widget.promotionId);
                                      }));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: CupertinoColors.activeGreen
                                    ),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.edit),
                                        SizedBox(width: 5.0,),
                                        Text("Изменить", style: TextStyle(
                                            fontFamily: "Futura"
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.0),
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                  return AddProductToPromotionWidget(promotionId: widget.promotionId);
                                }));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: CupertinoColors.activeBlue
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add),
                                  SizedBox(width: 5.0,),
                                  Text('Добавить товар', style: TextStyle(
                                      fontFamily: "Futura"
                                  ),)
                                ],
                              ),
                            ),
                          ),

                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Divider(
                                thickness: 1.0,
                                color: Color(0xD2BFBFBF),
                              ),
                              Text(
                                'Товары, участвующие в акции',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: const Color(0xFF14181B),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter _setState) {
                          var product = PromotionGroup.promotionByIdCall.productsList(promotionPageProviderPromotionByIdResponse.jsonBody,)?.toList() ?? [];
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: product.length,
                            itemBuilder: (context, productIndex) {
                              final productItem = product[productIndex];
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 120.0,
                                        height: 120.0,
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  valueOrDefault<String>(
                                                    getJsonField(
                                                      productItem,
                                                      r'''$.product.mainPhoto.url''',
                                                    )?.toString(),
                                                    'https://saudaline.kz/images/logo.png',
                                                  ),
                                                  width: 120.0,
                                                  height: 150.0,
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                      20.0, 20.0, 0.0, 0.0),
                                              child: Container(
                                                width: 40.0,
                                                height: 20.0,
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFFCF1212),
                                                  borderRadius:
                                                      BorderRadius.circular(40.0),
                                                ),
                                                alignment: const AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      getJsonField(
                                                        productItem,
                                                        r'''$.discount''',
                                                      ).toString(),
                                                      style: FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            color: Colors.white,
                                                            fontSize: 12.0,
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
                                                            fontSize: 12.0,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 10.0, 10.0, 10.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: const AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: SelectionArea(
                                                    child: AutoSizeText(
                                                  getJsonField(
                                                    productItem,
                                                    r'''$.product.title''',
                                                  ).toString(),
                                                  textAlign: TextAlign.start,
                                                  maxLines: 2,
                                                  style:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                  minFontSize: 14.0,
                                                )),
                                              ),
                                              Align(
                                                alignment: const AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: SelectionArea(
                                                    child: AutoSizeText(
                                                  getJsonField(
                                                    productItem,
                                                    r'''$.product.price''',
                                                  ).toString(),
                                                  maxLines: 1,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Readex Pro',
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        decoration: TextDecoration
                                                            .lineThrough,
                                                      ),
                                                  minFontSize: 14.0,
                                                )),
                                              ),
                                              RichText(
                                                textScaleFactor:
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: getJsonField(
                                                        productItem,
                                                        r'''$.discountPrice''',
                                                      ).toString(),
                                                      style: FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                    const TextSpan(
                                                      text: ' тг',
                                                      style: TextStyle(),
                                                    )
                                                  ],
                                                  style:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 37.0,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Builder(
                                                  builder: (context) => InkWell(
                                                    splashColor: Colors.transparent,
                                                    focusColor: Colors.transparent,
                                                    hoverColor: Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    onTap: () async {
                                                      await showDialog(
                                                        context: context,
                                                        builder: (dialogContext) {
                                                          return Dialog(
                                                            elevation: 0,
                                                            insetPadding:
                                                                EdgeInsets.zero,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            alignment: const AlignmentDirectional(
                                                                    0.0, 0.0)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                            child: WebViewAware(
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () => _model
                                                                        .unfocusNode
                                                                        .canRequestFocus
                                                                    ? FocusScope.of(
                                                                            context)
                                                                        .requestFocus(
                                                                            _model
                                                                                .unfocusNode)
                                                                    : FocusScope.of(
                                                                            context)
                                                                        .unfocus(),
                                                                child:
                                                                    PromotionProductDiscountChangeWidget(
                                                                  productId:
                                                                      productItem,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ).then((value) =>
                                                          setState(() {}));
                                                    },
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        const Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      5.0,
                                                                      0.0),
                                                          child: Icon(
                                                            Icons.edit_sharp,
                                                            color:
                                                                Color(0xFF0FA131),
                                                            size: 18.0,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Изменить скидку',
                                                          style:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    color: const Color(
                                                                        0xFF0FA131),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 100.0,
                                                  child: VerticalDivider(
                                                    thickness: 1.0,
                                                    color: Color(0xCCC6C6C6),
                                                  ),
                                                ),
                                                InkWell(
                                                  splashColor: Colors.transparent,
                                                  focusColor: Colors.transparent,
                                                  hoverColor: Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    _model.apiResultyDeleteProductFromPromotion =
                                                        await PromotionGroup.deleteProductFromPromotionByIdCall.call(
                                                          productPromotionId: getJsonField(productItem, r'''$.id''',),
                                                          jwtToken: FFAppState().jwttoken,
                                                        );
                                                    if ((_model.apiResultyDeleteProductFromPromotion?.succeeded ?? true)) {
                                                      await showDialog(
                                                        context: context,
                                                        builder: (alertDialogContext) {
                                                          return WebViewAware(
                                                            child: AlertDialog(
                                                              title: const Text('Успешно выполнено'),
                                                              content: const Text('Товар из акции успешно удалена!'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () => Navigator.pop(alertDialogContext),
                                                                  child: const Text('Ок'),
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
                                                              title: const Text('Ошибка операции'),
                                                              content: const Text('Произошла ошибка при удалении товара из акции.'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () => Navigator.pop(alertDialogContext),
                                                                  child: const Text('Ок'),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    }

                                                  },
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    5.0,
                                                                    0.0),
                                                        child: Icon(
                                                          Icons.close_sharp,
                                                          color:
                                                              Color(0xFFC84319),
                                                          size: 18.0,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Убрать из акции',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Readex Pro',
                                                              color: const Color(
                                                                  0xFFC84319),
                                                              fontWeight:
                                                                  FontWeight.w500,
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
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 1.0,
                                    color: Color(0xCC939393),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
