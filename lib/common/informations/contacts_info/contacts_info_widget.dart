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
import 'contacts_info_model.dart';
export 'contacts_info_model.dart';
import 'package:http/http.dart' as http;

class ContactsInfoWidget extends StatefulWidget {
  const ContactsInfoWidget({super.key});

  @override
  State<ContactsInfoWidget> createState() => _ContactsInfoWidgetState();
}

class _ContactsInfoWidgetState extends State<ContactsInfoWidget> {
  late ContactsInfoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ContactsInfoModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<String> fetchContentAbout() async {
    final response = await http.get(Uri.parse('http://server.saudaline.kz/api/v1/content/get-content?type=CONTACTS'));

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
          //           'Контакты',
          //           style: FlutterFlowTheme.of(context).bodyMedium.override(
          //                 fontFamily: 'Readex Pro',
          //                 fontSize: 16.0,
          //                 fontWeight: FontWeight.w600,
          //               ),
          //         ),
          //       ),
          //       Padding(
          //         padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
          //         child: Row(
          //           mainAxisSize: MainAxisSize.max,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Padding(
          //               padding:
          //                   EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
          //               child: Text(
          //                 'Адрес:',
          //                 textAlign: TextAlign.start,
          //                 style:
          //                     FlutterFlowTheme.of(context).bodyMedium.override(
          //                           fontFamily: 'Readex Pro',
          //                           color: Colors.black,
          //                           fontSize: 15.0,
          //                           fontWeight: FontWeight.w600,
          //                         ),
          //               ),
          //             ),
          //             Padding(
          //               padding:
          //                   EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
          //               child: Text(
          //                 'г. Тараз, ул. Сулейманова 7',
          //                 style: FlutterFlowTheme.of(context).bodyMedium,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       Padding(
          //         padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
          //         child: Row(
          //           mainAxisSize: MainAxisSize.max,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Padding(
          //               padding:
          //                   EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
          //               child: Text(
          //                 'Тел.:',
          //                 textAlign: TextAlign.start,
          //                 style:
          //                     FlutterFlowTheme.of(context).bodyMedium.override(
          //                           fontFamily: 'Readex Pro',
          //                           color: Colors.black,
          //                           fontSize: 15.0,
          //                           fontWeight: FontWeight.w600,
          //                         ),
          //               ),
          //             ),
          //             Padding(
          //               padding:
          //                   EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
          //               child: Text(
          //                 '+7 (707) 695 54 97',
          //                 style: FlutterFlowTheme.of(context).bodyMedium,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       Row(
          //         mainAxisSize: MainAxisSize.max,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Padding(
          //             padding:
          //                 EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
          //             child: Text(
          //               'E-mail:',
          //               textAlign: TextAlign.start,
          //               style: FlutterFlowTheme.of(context).bodyMedium.override(
          //                     fontFamily: 'Readex Pro',
          //                     color: Colors.black,
          //                     fontSize: 15.0,
          //                     fontWeight: FontWeight.w600,
          //                   ),
          //             ),
          //           ),
          //           Padding(
          //             padding:
          //                 EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
          //             child: Text(
          //               'saudaline.kz@mail.ru',
          //               style: FlutterFlowTheme.of(context).bodyMedium,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
