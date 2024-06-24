import 'package:collection/collection.dart';

enum OperationEnums {
  REFILL,
  EXPENSE,
  REQUESTS,
}

enum TariffRequestStatus {
  PAID,
  UNPAID,
  CREATED,
}

enum OrderStatus {
  APPROVED,
  CANCELED,
  CLOSED,
  CREATED,
}

enum TariffStatus {
  CREATED,
  PAID,
  UNPAID
}


extension FFEnumExtensions<T extends Enum> on T {
  String serialize() => name;
}

extension FFEnumListExtensions<T extends Enum> on Iterable<T> {
  T? deserialize(String? value) =>
      firstWhereOrNull((e) => e.serialize() == value);
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (OperationEnums):
      return OperationEnums.values.deserialize(value) as T?;
    case (TariffRequestStatus):
      return TariffRequestStatus.values.deserialize(value) as T?;
    case (OrderStatus):
      return OrderStatus.values.deserialize(value) as T?;
    default:
      return null;
  }
}
