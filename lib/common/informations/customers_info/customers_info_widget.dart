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
import 'customers_info_model.dart';
export 'customers_info_model.dart';
import 'package:http/http.dart' as http;

class CustomersInfoWidget extends StatefulWidget {
  const CustomersInfoWidget({super.key});

  @override
  State<CustomersInfoWidget> createState() => _CustomersInfoWidgetState();
}

class _CustomersInfoWidgetState extends State<CustomersInfoWidget> {
  late CustomersInfoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomersInfoModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<String> fetchContentAbout() async {
    final response = await http.get(Uri.parse('http://server.saudaline.kz/api/v1/content/get-content?type=TO_CUSTOMERS'));

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
          //           'Торговым точкам (магазин)',
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
          //           'Мы предоставляем бесплатный доступ к базе прямых поставщиков с ценами.',
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
          //         'Вы владелец магазина, торговой точки или сети магазинов? Если пользоваться сервисом «Saudaline.kz», покупать товары становится проще, быстрее, безопаснее. Предлагаем пройти простую и быструю регистрацию и получить доступ к базе фирм.\n\n«Saudaline.kz» предоставляет следующие возможности:',
          //         textAlign: TextAlign.start,
          //         style: FlutterFlowTheme.of(context).bodyMedium.override(
          //               fontFamily: 'Readex Pro',
          //               color: Colors.black,
          //               fontSize: 15.0,
          //               fontWeight: FontWeight.w500,
          //               lineHeight: 1.5,
          //             ),
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
          //               height: 155.0,
          //               decoration: BoxDecoration(),
          //               child: Text(
          //                 'Каталог поставщиков. Обширный список поставщиков с подробной\nинформацией о каждой компании. В том числе по ассортименту, ценам, зонам доставки, точному расположению на карте города. Указаны прямые цены от поставщиков, что значительно упрощает подбор предложения.',
          //                 style:
          //                     FlutterFlowTheme.of(context).bodyMedium.override(
          //                           fontFamily: 'Readex Pro',
          //                           fontSize: 15.0,
          //                         ),
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
          //               height: 40.0,
          //               decoration: BoxDecoration(),
          //               child: Text(
          //                 '-1% от нашей компаний за каждый заказ на нашем сайте.',
          //                 style:
          //                     FlutterFlowTheme.of(context).bodyMedium.override(
          //                           fontFamily: 'Readex Pro',
          //                           fontSize: 15.0,
          //                         ),
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
          //               height: 175.0,
          //               decoration: BoxDecoration(),
          //               child: Text(
          //                 'Список акций. Чтобы оптовая закупка продуктов проходила с минимальными затратами, для владельцев магазинов предлагается раздел с акциями. Здесь представлены специальные предложения поставщиков со скидками. Список акций регулярно обновляется и пополняется новыми, вы первыми узнаете о новых уникальных предложениях!',
          //                 style:
          //                     FlutterFlowTheme.of(context).bodyMedium.override(
          //                           fontFamily: 'Readex Pro',
          //                           fontSize: 15.0,
          //                         ),
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
          //               height: 100.0,
          //               decoration: BoxDecoration(),
          //               child: Text(
          //                 'Для того чтобы приобрести нужный товар, вам не придется работать с десятками торговыми представителями. Покупки можно совершать в любое время в круглосуточном режиме',
          //                 style:
          //                     FlutterFlowTheme.of(context).bodyMedium.override(
          //                           fontFamily: 'Readex Pro',
          //                           fontSize: 15.0,
          //                         ),
          //               ),
          //             ),
          //           ),
          //         ],
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
