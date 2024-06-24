import '/flutter_flow/flutter_flow_count_controller.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'counter_basket_model.dart';
export 'counter_basket_model.dart';

class CounterBasketWidget extends StatefulWidget {
  const CounterBasketWidget({
    super.key,
    this.product,
    required this.providerId,
    required this.providerName,
    required this.providerLogotype,
  });

  final dynamic product;
  final int? providerId;
  final String? providerName;
  final String? providerLogotype;

  @override
  State<CounterBasketWidget> createState() => _CounterBasketWidgetState();
}

class _CounterBasketWidgetState extends State<CounterBasketWidget> {
  late CounterBasketModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CounterBasketModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.35,
        height: 35.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: Color(0xFFE0E3E7),
            width: 1.0,
          ),
        ),
        child: FlutterFlowCountController(
          decrementIconBuilder: (enabled) => FaIcon(
            FontAwesomeIcons.minus,
            color: enabled
                ? FlutterFlowTheme.of(context).secondaryText
                : FlutterFlowTheme.of(context).alternate,
            size: 20.0,
          ),
          incrementIconBuilder: (enabled) => FaIcon(
            FontAwesomeIcons.plus,
            color: enabled ? Colors.black : FlutterFlowTheme.of(context).alternate,
            size: 20.0,
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
                FFAppState().update(() {
                  FFAppState().basketProducts = functions
                      .generatJsonProduct(
                      getJsonField(
                        widget.product,
                        r'''$.productId''',
                      ),
                      _model.countControllerValue,
                      FFAppState().basketProducts.toList(),
                      widget.providerId,
                      widget.providerName,
                      widget.providerLogotype,
                      getJsonField(
                        widget.product,
                        r'''$.productSum''',
                      ),
                      getJsonField(
                        widget.product,
                        r'''$.productImage''',
                      ).toString(),
                      getJsonField(
                        widget.product,
                        r'''$.productName''',
                      ).toString(),
                      valueOrDefault<int>(
                        getJsonField(
                          widget.product,
                          r'''$.productDiscount''',
                        ),
                        0,
                      ))!
                      .toList()
                      .cast<dynamic>();
                });
                // setState(() {
                //   FFAppState().basketProducts =
                //       functions.generatJsonProduct(
                //           widget.id, _model.countControllerValue,
                //           FFAppState().basketProducts.toList(),
                //           getJsonField(productPageGetProductByIdResponse.jsonBody, r'''$.provider.id''',),
                //           getJsonField(productPageGetProductByIdResponse.jsonBody, r'''$.provider.name''',).toString(),
                //           getJsonField(productPageGetProductByIdResponse.jsonBody, r'''$.provider.logotype[:1].url''',).toString(),
                //           GetProductByIdCall.price(productPageGetProductByIdResponse.jsonBody,),
                //           GetProductByIdCall.productImage(productPageGetProductByIdResponse.jsonBody,),
                //           GetProductByIdCall.productName(productPageGetProductByIdResponse.jsonBody,),
                //           valueOrDefault<int>(GetProductByIdCall.discount(productPageGetProductByIdResponse.jsonBody,), 0,)
                //       )!
                //           .toList()
                //           .cast<dynamic>();
                //
                // });

              },
            ),
          ),
          count: _model.countControllerValue ??= valueOrDefault<int>(functions.getProductQuantity(getJsonField(widget.product, r'''$.productId''',), widget.providerId, FFAppState().basketProducts.toList()), 1,),
          updateCount: (count) async {
            setState(() => _model.countControllerValue = count);
            FFAppState().update(() {
              FFAppState().basketProducts = functions
                  .generatJsonProduct(
                      getJsonField(
                        widget.product,
                        r'''$.productId''',
                      ),
                      _model.countControllerValue,
                      FFAppState().basketProducts.toList(),
                      widget.providerId,
                      widget.providerName,
                      widget.providerLogotype,
                      getJsonField(
                        widget.product,
                        r'''$.productSum''',
                      ),
                      getJsonField(
                        widget.product,
                        r'''$.productImage''',
                      ).toString(),
                      getJsonField(
                        widget.product,
                        r'''$.productName''',
                      ).toString(),
                      valueOrDefault<int>(
                        getJsonField(
                          widget.product,
                          r'''$.productDiscount''',
                        ),
                        0,
                      ))!
                  .toList()
                  .cast<dynamic>();
            });
          },
          stepSize: 1,
          minimum: 1,
        ),
      ),
    );
  }
}
