import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'providers_info_model.dart';
export 'providers_info_model.dart';
import 'package:http/http.dart' as http;

class ProvidersInfoWidget extends StatefulWidget {
  const ProvidersInfoWidget({super.key});

  @override
  State<ProvidersInfoWidget> createState() => _ProvidersInfoWidgetState();
}

class _ProvidersInfoWidgetState extends State<ProvidersInfoWidget> {
  late ProvidersInfoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProvidersInfoModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<String> fetchContentAbout() async {
    final response = await http.get(Uri.parse('http://server.saudaline.kz/api/v1/content/get-content?type=TO_PROVIDERS'));

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

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: true,
          title: Text(
            'SaudaLine',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 4.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder<dynamic>(
                    future: fetchContentAbout(),
                    builder: (context, snapshot) {

                      if (!snapshot.hasData) {
                        return CupertinoActivityIndicator();
                      }

                      return Html(
                        data: """${snapshot.data}""",
                      );
                    }
                )
              ],
            ),
          ),
          // child: Padding(
          //   padding: EdgeInsetsDirectional.fromSTEB(10.0, 15.0, 10.0, 15.0),
          //   child: ListView(
          //     padding: EdgeInsets.zero,
          //     scrollDirection: Axis.vertical,
          //     children: [
          //       Padding(
          //         padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
          //         child: Text(
          //           'Поставщикам',
          //           textAlign: TextAlign.center,
          //           style: FlutterFlowTheme.of(context).bodyMedium.override(
          //                 fontFamily: 'Readex Pro',
          //                 fontSize: 16.0,
          //                 fontWeight: FontWeight.w600,
          //               ),
          //         ),
          //       ),
          //       Padding(
          //         padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
          //         child: Text(
          //           'Мы предоставляем возможность получать прямые заказы со всех торговых точек (магазин) вашего города в режиме online.',
          //           textAlign: TextAlign.center,
          //           style: FlutterFlowTheme.of(context).bodyMedium.override(
          //                 fontFamily: 'Readex Pro',
          //                 color: Color(0xFFFCA522),
          //                 fontSize: 16.0,
          //                 fontWeight: FontWeight.w600,
          //               ),
          //         ),
          //       ),
          //       Text(
          //         'База поставщиков в Казахстане «Saudaline.kz» создает все условия для того, чтобы магазины смогли напрямую сделать заказ у Вашей фирмы. Цены на товары доступны только целевым группам пользователей. Авторизованные фирмы располагают возможностью загружать сведения о предлагаемых товарах в общую базу производителей. Владельцы магазинов просматривают электронный каталог и принимают заявку и выбирают дату поставки товара. Фирма делает доставку указанный срок по (указанному адресу) точному расположению на карте города и принимают оплату.',
          //         textAlign: TextAlign.start,
          //         style: FlutterFlowTheme.of(context).bodyMedium.override(
          //               fontFamily: 'Readex Pro',
          //               color: Colors.black,
          //               fontSize: 16.0,
          //               fontWeight: FontWeight.w500,
          //               lineHeight: 1.5,
          //             ),
          //       ),
          //       Padding(
          //         padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
          //         child: Text(
          //           'Saudaline.kz - это в первую очередь уникальная торговая система, пользоваться которой совершенно безопасно.',
          //           textAlign: TextAlign.start,
          //           style: FlutterFlowTheme.of(context).bodyMedium.override(
          //                 fontFamily: 'Readex Pro',
          //                 color: Colors.black,
          //                 fontSize: 16.0,
          //                 fontWeight: FontWeight.w500,
          //                 lineHeight: 1.5,
          //               ),
          //         ),
          //       ),
          //       Padding(
          //         padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
          //         child: Text(
          //           '«Saudaline.kz» предоставляет следующие возможности:',
          //           textAlign: TextAlign.start,
          //           style: FlutterFlowTheme.of(context).bodyMedium.override(
          //                 fontFamily: 'Readex Pro',
          //                 color: Colors.black,
          //                 fontSize: 16.0,
          //                 fontWeight: FontWeight.w600,
          //                 lineHeight: 1.5,
          //               ),
          //         ),
          //       ),
          //       Padding(
          //         padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
          //         child: Row(
          //           mainAxisSize: MainAxisSize.max,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               '\t—',
          //               style: FlutterFlowTheme.of(context).bodyMedium.override(
          //                     fontFamily: 'Readex Pro',
          //                     color: Color(0xFFFCA522),
          //                   ),
          //             ),
          //             Padding(
          //               padding:
          //                   EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
          //               child: Container(
          //                 width: MediaQuery.sizeOf(context).width * 0.9,
          //                 height: 45.0,
          //                 decoration: BoxDecoration(),
          //                 child: Text(
          //                   'Сервис не взимает плату за пользование функционалом – он доступен бесплатно.',
          //                   style: FlutterFlowTheme.of(context)
          //                       .bodyMedium
          //                       .override(
          //                         fontFamily: 'Readex Pro',
          //                         fontSize: 16.0,
          //                       ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       Row(
          //         mainAxisSize: MainAxisSize.max,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             '\t—',
          //             style: FlutterFlowTheme.of(context).bodyMedium.override(
          //                   fontFamily: 'Readex Pro',
          //                   color: Color(0xFFFCA522),
          //                 ),
          //           ),
          //           Padding(
          //             padding:
          //                 EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
          //             child: Container(
          //               width: MediaQuery.sizeOf(context).width * 0.9,
          //               height: 68.0,
          //               decoration: BoxDecoration(),
          //               child: Text(
          //                 'Ассортимент магазинов. Услугами сервиса пользуются владельцы всех торговых точек (магазин) Вашего города. ',
          //                 style:
          //                     FlutterFlowTheme.of(context).bodyMedium.override(
          //                           fontFamily: 'Readex Pro',
          //                           fontSize: 16.0,
          //                         ),
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //       Padding(
          //         padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
          //         child: Text(
          //           'Условия приложения Saudaline.kz:',
          //           textAlign: TextAlign.start,
          //           style: FlutterFlowTheme.of(context).bodyMedium.override(
          //                 fontFamily: 'Readex Pro',
          //                 color: Colors.black,
          //                 fontSize: 16.0,
          //                 fontWeight: FontWeight.w600,
          //                 lineHeight: 1.5,
          //               ),
          //         ),
          //       ),
          //       Row(
          //         mainAxisSize: MainAxisSize.max,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             '\t—',
          //             style: FlutterFlowTheme.of(context).bodyMedium.override(
          //                   fontFamily: 'Readex Pro',
          //                   color: Color(0xFFFCA522),
          //                 ),
          //           ),
          //           Padding(
          //             padding:
          //                 EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
          //             child: Container(
          //               width: MediaQuery.sizeOf(context).width * 0.9,
          //               height: 105.0,
          //               decoration: BoxDecoration(),
          //               child: Column(
          //                 mainAxisSize: MainAxisSize.max,
          //                 children: [
          //                   Text(
          //                     'Вы плотите только за выбранный Вами тариф (5% от общего объема заказа). ',
          //                     style: FlutterFlowTheme.of(context)
          //                         .bodyMedium
          //                         .override(
          //                           fontFamily: 'Readex Pro',
          //                           fontSize: 16.0,
          //                         ),
          //                   ),
          //                   Text(
          //                     '(тоесть вы не плотите торговому представителю зарплату, проезд и %. С нами  Вы экономите.)',
          //                     style: FlutterFlowTheme.of(context)
          //                         .bodyMedium
          //                         .override(
          //                           fontFamily: 'Readex Pro',
          //                           fontSize: 15.0,
          //                           fontStyle: FontStyle.italic,
          //                         ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //       Row(
          //         mainAxisSize: MainAxisSize.max,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             '\t—',
          //             style: FlutterFlowTheme.of(context).bodyMedium.override(
          //                   fontFamily: 'Readex Pro',
          //                   color: Color(0xFFFCA522),
          //                 ),
          //           ),
          //           Padding(
          //             padding:
          //                 EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
          //             child: Container(
          //               width: MediaQuery.sizeOf(context).width * 0.9,
          //               height: 50.0,
          //               decoration: BoxDecoration(),
          //               child: Column(
          //                 mainAxisSize: MainAxisSize.max,
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     '-1 % скидка от цены каталога',
          //                     style: FlutterFlowTheme.of(context)
          //                         .bodyMedium
          //                         .override(
          //                           fontFamily: 'Readex Pro',
          //                           fontSize: 16.0,
          //                         ),
          //                   ),
          //                   Text(
          //                     '(для магазина)',
          //                     textAlign: TextAlign.start,
          //                     style: FlutterFlowTheme.of(context)
          //                         .bodyMedium
          //                         .override(
          //                           fontFamily: 'Readex Pro',
          //                           fontSize: 15.0,
          //                           fontStyle: FontStyle.italic,
          //                         ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //       Padding(
          //         padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
          //         child: Text(
          //           'Первый шаг, который нужно сделать на пути к успешности собственного бизнеса – это зарегистрироваться в базе прямых поставщиков. После регистрации вы получите индивидуальный логин и пароль от личного кабинета. Вы прикрепляете электронный каталог фирмы с ценами на каждый товар, по которым владельцы торговых точек смогут сделать заказ на нашем сайте.',
          //           textAlign: TextAlign.start,
          //           style: FlutterFlowTheme.of(context).bodyMedium.override(
          //                 fontFamily: 'Readex Pro',
          //                 color: Colors.black,
          //                 fontSize: 16.0,
          //                 fontWeight: FontWeight.w500,
          //                 lineHeight: 1.5,
          //               ),
          //         ),
          //       ),
          //       Padding(
          //         padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
          //         child: Text(
          //           'С Нами Вы сможете взять свой бизнес под контроль и сделать его успешным и прибыльным!',
          //           textAlign: TextAlign.center,
          //           style: FlutterFlowTheme.of(context).bodyMedium.override(
          //                 fontFamily: 'Readex Pro',
          //                 color: Color(0xFFFCA522),
          //                 fontSize: 16.0,
          //                 fontWeight: FontWeight.w600,
          //               ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
