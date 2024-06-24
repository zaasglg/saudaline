import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sauda_line/customer/promotion/promotion_page_provider/promotion_page_provider_widget.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'promotion_product_discount_create_model.dart';
export 'promotion_product_discount_create_model.dart';

class PromotionProductDiscountCreateWidget extends StatefulWidget {
  const PromotionProductDiscountCreateWidget({
    super.key,
    required this.productId,
    required this.promotionId,
  });

  final dynamic productId;
  final int? promotionId;

  @override
  State<PromotionProductDiscountCreateWidget> createState() =>
      _PromotionProductDiscountCreateWidgetState();
}

class _PromotionProductDiscountCreateWidgetState
    extends State<PromotionProductDiscountCreateWidget> {
  late PromotionProductDiscountCreateModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PromotionProductDiscountCreateModel());

    _model.discountController ??= TextEditingController(text: '0');
    _model.discountFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 350.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 10.0),
                            child: Text(
                              'Добавить скидку на товар',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: const Color(0xFF14181B),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 0.0, 0.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      valueOrDefault<String>(
                                        getJsonField(
                                          widget.productId,
                                          r'''$.mainPhoto.url''',
                                        )?.toString(),
                                        'https://picsum.photos/seed/119/600',
                                      ),
                                      width: 100.0,
                                      height: 100.0,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      14.0, 12.0, 0.0, 0.0),
                                  child: Container(
                                    width: 40.0,
                                    height: 20.0,
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
                                          _model.discountController.text,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                color: Colors.white,
                                                fontSize: 12.0,
                                              ),
                                        ),
                                        Text(
                                          '%',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
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
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0, 20.0, 0.0, 10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 230.0,
                                    decoration: const BoxDecoration(),
                                    child: AutoSizeText(
                                      getJsonField(
                                        widget.productId,
                                        r'''$.title''',
                                      ).toString().maybeHandleOverflow(
                                            maxChars: 60,
                                            replacement: '…',
                                          ),
                                      maxLines: 2,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: const Color(0xFF14181B),
                                            fontSize: 14.0,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 5.0, 0.0, 0.0),
                                    child: RichText(
                                      textScaleFactor: MediaQuery.of(context)
                                          .textScaleFactor,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Цена: ',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                          TextSpan(
                                            text: getJsonField(widget.productId, r'''$.price''',).toString(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: ' т',
                                            style: TextStyle(),
                                          )
                                        ],
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 5.0, 0.0, 0.0),
                                    child: RichText(
                                      textScaleFactor: MediaQuery.of(context)
                                          .textScaleFactor,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Цена со скидкой: ',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                          TextSpan(
                                            text: functions
                                                .doubleToInt(getJsonField(
                                                      widget.productId,
                                                      r'''$.price''',
                                                    ) -
                                                    ((getJsonField(
                                                              widget.productId,
                                                              r'''$.price''',
                                                            ) /
                                                            100) *
                                                        int.parse(_model
                                                            .discountController
                                                            .text)))
                                                .toString(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: ' т',
                                            style: TextStyle(),
                                          )
                                        ],
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20.0, 20.0, 0.0, 0.0),
                          child: Text(
                            'Скидка на товар (в процентах):',
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20.0, 15.0, 20.0, 0.0),
                          child: TextFormField(
                            controller: _model.discountController,
                            focusNode: _model.discountFocusNode,
                            onChanged: (_) => EasyDebounce.debounce(
                              '_model.discountController',
                              const Duration(milliseconds: 2000),
                              () async {
                                setState(() {
                                  FFAppState().universalDiscountValue =
                                      int.parse(_model.discountController.text);
                                });
                              },
                            ),
                            obscureText: false,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFFCFCFCF),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).primary,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                              filled: true,
                            ),
                            style: FlutterFlowTheme.of(context).bodyMedium,
                            keyboardType: TextInputType.number,
                            validator: _model.discountControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 10.0, 10.0, 20.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        text: 'Назад',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 40.0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Outfit',
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
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          10.0, 10.0, 20.0, 20.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          print("wwd");

                          // print(getJsonField(widget.productId, r'''$.id''',));
                          // print(int.tryParse(_model.discountController.text));
                          // print(widget.promotionId);
                          // print(FFAppState().jwttoken);

                          _model.apiResultcAddDiscountToPromotion =
                          await PromotionGroup.addDiscountToProductCall.call(
                            productId: getJsonField(
                              widget.productId,
                              r'''$.id''',
                            ),
                            discount: int.tryParse(_model.discountController.text),
                            promotionId: widget.promotionId,
                            jwtToken: FFAppState().jwttoken,
                          );

                          print(_model.apiResultcAddDiscountToPromotion?.bodyText);
                          if ((_model.apiResultcAddDiscountToPromotion?.succeeded ?? true)) {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return WebViewAware(
                                  child: AlertDialog(
                                    title: const Text('Успешно обновлено'),
                                    content: const Text(
                                        'Скидка на продукт успешно обновлена'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: const Text('Oк'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );


                            // Navigator.of(context).popUntil((route) => route.isFirst);

                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return PromotionPageProviderWidget(
                                promotionId: int.tryParse(serializeParam(widget.promotionId, ParamType.int,) ?? '0'),
                              );
                            }));


                          } else {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return WebViewAware(
                                  child: AlertDialog(
                                    title: const Text('На этот товар уже действует скидка.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: const Text('Oк'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }

                          setState(() {});
                        },
                        text: 'Сохранить',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 40.0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(fontFamily: 'Outfit', color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w500,),
                          elevation: 3.0,
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
