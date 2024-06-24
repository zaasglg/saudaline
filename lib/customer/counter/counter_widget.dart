import '/flutter_flow/flutter_flow_count_controller.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'counter_model.dart';
export 'counter_model.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({
    super.key,
    this.product,
  });

  final dynamic product;

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  late CounterModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CounterModel());
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
            size: 16.0,
          ),
          incrementIconBuilder: (enabled) => FaIcon(
            FontAwesomeIcons.plus,
            color:
                enabled ? Colors.black : FlutterFlowTheme.of(context).alternate,
            size: 16.0,
          ),
          countBuilder: (count) => Text(
            count.toString(),
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'Outfit',
                  color: Color(0xFF14181B),
                  fontSize: 16.0,
                ),
          ),
          count: _model.countControllerValue ??= valueOrDefault<int>(
            functions.getProductQuantity(
                getJsonField(
                  widget.product,
                  r'''$.id''',
                ),
                getJsonField(
                  widget.product,
                  r'''$.provider.id''',
                ),
                FFAppState().basketProducts.toList()),
            1,
          ),
          updateCount: (count) async {
            setState(() => _model.countControllerValue = count);
            _model.updatePage(() {
              FFAppState().basketProducts = functions
                  .generatJsonProduct(
                      getJsonField(
                        widget.product,
                        r'''$.id''',
                      ),
                      _model.countControllerValue,
                      FFAppState().basketProducts.toList(),
                      getJsonField(
                        widget.product,
                        r'''$.provider.id''',
                      ),
                      getJsonField(
                        widget.product,
                        r'''$.provider.name''',
                      ).toString(),
                      getJsonField(
                        widget.product,
                        r'''$.provider.logotype[:1].url''',
                      ).toString(),
                      getJsonField(
                        widget.product,
                        r'''$.price''',
                      ),
                      getJsonField(
                        widget.product,
                        r'''$.mainPhoto.url''',
                      ).toString(),
                      getJsonField(
                        widget.product,
                        r'''$.title''',
                      ).toString(),
                      valueOrDefault<int>(
                        getJsonField(
                          widget.product,
                          r'''$.discount''',
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
