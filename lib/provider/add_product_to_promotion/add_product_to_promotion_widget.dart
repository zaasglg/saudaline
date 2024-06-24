import 'package:flutter/cupertino.dart';
import 'package:sauda_line/index.dart';
import 'package:sauda_line/models/PromotionProduct.dart';

import '/backend/api_requests/api_calls.dart';
import '/customer/order/promotion_product_discount_create/promotion_product_discount_create_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'add_product_to_promotion_model.dart';
export 'add_product_to_promotion_model.dart';
import 'package:http/http.dart' as http;


class AddProductToPromotionWidget extends StatefulWidget {
  const AddProductToPromotionWidget({
    super.key,
    required this.promotionId,
  });

  final int? promotionId;

  @override
  State<AddProductToPromotionWidget> createState() => _AddProductToPromotionWidgetState();
}

class _AddProductToPromotionWidgetState extends State<AddProductToPromotionWidget> {
  late AddProductToPromotionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddProductToPromotionModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    final String url = 'https://server.saudaline.kz/api/v1/product/get-promotion-products-by-provider?providerId=22';

    // Your authorization token
    final String authToken = FFAppState().jwttoken;

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> productList = json['content'];
      return productList.cast<Map<String, dynamic>>().toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async{

          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return PromotionPageProviderWidget(promotionId: widget.promotionId);
          }));

          return false;
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: CupertinoColors.systemGrey6,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            automaticallyImplyLeading: false,
            title: RichText(
              textScaleFactor: MediaQuery.of(context).textScaleFactor,
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Товары',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                    ),
                  )
                ],
                style: FlutterFlowTheme.of(context).bodyMedium,
              ),
            ),
            actions: [],
            centerTitle: false,
            elevation: 0.0,
          ),
          body: SafeArea(
            top: true,
            child: FutureBuilder(
              future: fetchProducts(),
              builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {

                if (!snapshot.hasData) {
                  return CupertinoActivityIndicator();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> product = snapshot.data![index];
                      return Material(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          padding: const EdgeInsets.only(bottom: 15.0),
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1,
                                      color: Colors.black12
                                  )
                              )
                          ),
                          child: ListTile(
                            leading: SizedBox(
                              width: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: Image.network(
                                  product['mainPhoto']['url'],
                                  width: 100,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(product['id'].toString(), style: const TextStyle(
                                fontFamily: "Futura",
                                fontSize: 19
                            ),),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product['description'], style: const TextStyle(
                                    fontFamily: "Futura",
                                    fontSize: 15
                                ),),
                                Text("${product['price']} Тг", style: const TextStyle(
                                    fontFamily: "Futura",
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500
                                ),),
                              ],
                            ),
                            trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: const Color(0xffE8751A),
                              ),
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (dialogContext) {
                                    return Dialog(
                                      elevation: 0,
                                      insetPadding:
                                      EdgeInsets.zero,
                                      backgroundColor:
                                      Colors.transparent,
                                      alignment: const AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                      child: WebViewAware(
                                        child: GestureDetector(
                                          onTap: () => _model.unfocusNode.canRequestFocus
                                              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                              : FocusScope.of(context).unfocus(),
                                          child:
                                          PromotionProductDiscountCreateWidget(productId: product, promotionId: widget.promotionId!,),
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => setState(() {}));
                              },
                              child: const Text("Добавить"),
                            ),
                          ),
                        ),
                      );

                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
