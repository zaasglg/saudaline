import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'about_us_model.dart';
export 'about_us_model.dart';
import 'package:http/http.dart' as http;

class AboutUsWidget extends StatefulWidget {
  const AboutUsWidget({super.key});

  @override
  State<AboutUsWidget> createState() => _AboutUsWidgetState();
}

class _AboutUsWidgetState extends State<AboutUsWidget> {
  late AboutUsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AboutUsModel());
  }


  Future<String> fetchContentAbout() async {
    final response = await http.get(Uri.parse('http://server.saudaline.kz/api/v1/content/get-content?type=ABOUT_COMPANY'));

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
  void dispose() {
    _model.dispose();

    super.dispose();
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
          //           'О компании',
          //           style: FlutterFlowTheme.of(context).bodyMedium.override(
          //                 fontFamily: 'Readex Pro',
          //                 fontSize: 18.0,
          //                 fontWeight: FontWeight.w600,
          //               ),
          //         ),
          //       ),
          //       RichText(
          //         textScaleFactor: MediaQuery.of(context).textScaleFactor,
          //         text: TextSpan(
          //           children: [
          //             TextSpan(
          //               text:
          //                   'Saudaline – это в первую очередь уникальная торговая система, пользоваться которой совершенно безопасно. Это связано с тем, что доступ к каталогу оптовых поставщиков, дистрибьюторов и владельцев торговых точек могут получить только бизнесмены, индивидуальные предприниматели и их официальные сотрудники, которые имеют допуск от руководства. На этапе регистрации, данные проверяются службой «MDB.kz».\nСервис пользуется большой востребованностью и обладает следующими достоинствами:\nУдобство работы. Пользоваться возможностями сервиса MDB.kz, можно не только с компьютера, но и с мобильного устройства, с которого доступен выход в Интернет. Это значит, что вы всегда сможете отследить появление новых поставщиков или заказов на поставку, и не упустить выгодный заказ.\nАссортимент. Нашим сервисом пользуются владельцы более 5000 торговых точек, а также свыше 500 проверенных поставщиков, дистрибьюторов и официальных производителей. Список поставщиков и торговых точек, регулярно расширяется, поэтому найти подходящий заказ становится проще и выгоднее.\nНет посредников. Сервис не взимает плату за пользование функционалом – он доступен бесплатно. Наши пользователи контактируют напрямую, располагая возможностью обсудить детали заказа внутри системы. Это выгодно отличает сервис от аналогов, которые берут плату за оказание услуг.\nЧестные цены. К заказам от магазинов и к предложениям от поставщиков прикладываются реальные цены. Обсудить подробные условия сотрудничества можно по контактным сведениям участника. Сервис не запрещает выкладывать номера телефонов, адреса электронной почты, а также почтовые адреса.\nМногочисленные владельцы магазинов, оптовые поставщики и производители уже ждут на сайте «MDB.kz». Воспользуйтесь функционалом сервиса, сделайте серьезный шаг на пути к тому, чтобы сделать бизнес более прибыльным и конкурентоспособным. Пройдите регистрацию и начните пользоваться сервисом!',
          //               style: TextStyle(),
          //             )
          //           ],
          //           style: FlutterFlowTheme.of(context).bodyMedium.override(
          //                 fontFamily: 'Readex Pro',
          //                 lineHeight: 2.0,
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
