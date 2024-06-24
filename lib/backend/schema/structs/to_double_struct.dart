// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ToDoubleStruct extends BaseStruct {
  ToDoubleStruct({
    double? toDouble,
  }) : _toDouble = toDouble;

  // "toDouble" field.
  double? _toDouble;
  double get toDouble => _toDouble ?? 0.0;
  set toDouble(double? val) => _toDouble = val;
  void incrementToDouble(double amount) => _toDouble = toDouble + amount;
  bool hasToDouble() => _toDouble != null;

  static ToDoubleStruct fromMap(Map<String, dynamic> data) => ToDoubleStruct(
        toDouble: castToType<double>(data['toDouble']),
      );

  static ToDoubleStruct? maybeFromMap(dynamic data) =>
      data is Map ? ToDoubleStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'toDouble': _toDouble,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'toDouble': serializeParam(
          _toDouble,
          ParamType.double,
        ),
      }.withoutNulls;

  static ToDoubleStruct fromSerializableMap(Map<String, dynamic> data) =>
      ToDoubleStruct(
        toDouble: deserializeParam(
          data['toDouble'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'ToDoubleStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ToDoubleStruct && toDouble == other.toDouble;
  }

  @override
  int get hashCode => const ListEquality().hash([toDouble]);
}

ToDoubleStruct createToDoubleStruct({
  double? toDouble,
}) =>
    ToDoubleStruct(
      toDouble: toDouble,
    );
