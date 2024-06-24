import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';

bool? cardContainsProduct(
  List<dynamic> card,
  dynamic product,
) {
  return card.contains(product);
}

String? appStateToPrint(List<int>? ids) {
  return ids.toString();
}

String? idsToString(List<int>? ids) {
  if (ids != null) {
    return ids.join(', ');
  } else {
    return null;
  }
}

List<dynamic>? generatJsonProduct(
  int? productId,
  int? quantity,
  List<dynamic>? basket,
  int? providerId,
  String? providerName,
  String? providerImage,
  int? productSum,
  String? productImage,
  String? productName,
  int? discount,
) {
  Map<String, dynamic> goodsObject = {
    "productId": productId,
    "quantity": quantity,
    "productSum": productSum,
    "productName": productName,
    "productImage": productImage,
    "productDiscount": discount == 0 ? null : discount,
    "productSumWithDiscount":
        (productSum! - ((productSum! / 100) * discount!)).toInt(),
  };

  Map<String, dynamic> providerInfo = {
    "providerId": providerId,
    "providerName": providerName,
    "totalQuantity": quantity,
    "totalSum": discount == 0
        ? (productSum! * quantity!).toInt()
        : ((productSum! - ((productSum! / 100) * discount!)) * quantity!)
            .toInt(),
    "totalDiscount": ((productSum! / 100) * discount!).toInt(),
    "providerImage": providerImage,
    "goods": [],
  };

  providerInfo["goods"].add(goodsObject);

  if (basket == null) {
    basket = [];
  }

  // Find the provider in the basket
  var existingProvider = basket.firstWhere(
    (provider) =>
        provider is Map &&
        provider.containsKey('providerId') &&
        provider['providerId'] == providerId,
    orElse: () => null,
  );

  if (existingProvider != null) {
    var goodsList = existingProvider['goods'] ?? [];

    var foundGoods = false;

    // Find the product in the provider's goods
    for (var goodsItem in goodsList) {
      if (goodsItem is Map &&
          goodsItem['productId'] is int &&
          goodsItem['productId'] == productId) {
        existingProvider["totalSum"] -=
            goodsItem['productSumWithDiscount'] * goodsItem['quantity'];

        goodsItem['productDiscount'] = discount == 0 ? null : discount;
        goodsItem['productSumWithDiscount'] = (productSum! -
                ((productSum! / 100) * (discount == 0 ? 0 : discount)))
            .toInt();
        goodsItem['quantity'] = quantity; // Update quantity if product exists

        existingProvider["totalQuantity"] =
            (existingProvider["totalQuantity"] - goodsItem['quantity']) +
                quantity;

        existingProvider["totalSum"] +=
            goodsItem['productSumWithDiscount'] * goodsItem['quantity'];

        // existingProvider["totalSum"] =
        //     goodsItem['productSumWithDiscount'] * goodsItem['quantity'];
        // existingProvider["totalSum"] = existingProvider["totalSum"] +
        //     (discount == 0
        //         ? ((goodsItem['productSum'] * goodsItem['quantity'])).toInt()
        //         : ((productSum! - ((productSum! / 100) * discount!)) *
        //                 quantity!)
        //             .toInt());
        foundGoods = true;
        break;
      }
    }

    if (!foundGoods) {
      goodsObject['productDiscount'] = discount == 0 ? null : discount;
      goodsList.add(goodsObject); // Add new product to provider's goods

      existingProvider["totalQuantity"] =
          existingProvider["totalQuantity"] + quantity;
      existingProvider["totalSum"] = (existingProvider["totalSum"] +
              (discount == 0
                  ? (productSum! * quantity!)
                  : (productSum! - ((productSum! / 100) * discount!)) *
                      quantity!))
          .toInt();
    }

    // Calculate total discount for all goods of the existing provider
    existingProvider['totalDiscount'] = goodsList.fold(0, (sum, goodsItem) {
      var goodsDiscount = goodsItem['productDiscount'] ?? 0;
      return (sum +
              ((goodsItem['productSum'] * goodsItem['quantity']) / 100) *
                  goodsDiscount)
          .toInt();
    });
  } else {
    basket.add(providerInfo); // Add new provider along with product
  }

  return basket;
}

List<dynamic>? deleteFromBasket(
  int? providerId,
  int? productId,
  List<dynamic>? basket,
) {
  if (basket == null) {
    return basket;
  }

  // Find the provider in the basket
  var existingProvider = basket.firstWhere(
    (provider) =>
        provider is Map &&
        provider.containsKey('providerId') &&
        provider['providerId'] == providerId,
    orElse: () => null,
  );

  if (existingProvider != null) {
    var goodsList = existingProvider['goods'] ?? [];
    // Find the product in the provider's goods
    for (var goodsItem in goodsList) {
      if (goodsItem is Map &&
          goodsItem['productId'] is int &&
          goodsItem['productId'] == productId) {
        existingProvider["totalQuantity"] =
            existingProvider["totalQuantity"] - goodsItem['quantity'];
        existingProvider["totalSum"] = existingProvider["totalSum"] -
            (goodsItem['productDiscount'] == null
                ? goodsItem['productSum'] * goodsItem['quantity']
                : (goodsItem['productSum'] -
                        ((goodsItem['productSum'] / 100) *
                            goodsItem['productDiscount'])) *
                    goodsItem['quantity']);

        existingProvider['totalDiscount'] = goodsItem['productDiscount'] != null
            ? existingProvider['totalDiscount'] -
                (((goodsItem["productSum"] / 100) *
                        goodsItem["productDiscount"]) *
                    goodsItem["quantity"])
            : existingProvider['totalDiscount'];
        goodsList.remove(goodsItem);
        break;
      }
    }
    if (goodsList.isEmpty) {
      basket.remove(existingProvider);
    }
  }

  return basket;
}

dynamic getTotals(List<dynamic>? basket) {
  int totalQuantity = 0;
  int totalSum = 0;
  int totalSumWithDiscount = 0;
  int totalDiscount = 0;

  for (var provider in basket!) {
    if (provider is Map && provider.containsKey('totalQuantity')) {
      totalQuantity += ((provider['totalQuantity'] as double).toInt());
    }

    if (provider is Map && provider.containsKey('totalDiscount')) {
      totalDiscount += ((provider['totalDiscount'] as double).toInt());
    }

    if (provider is Map && provider.containsKey('totalSum')) {
      totalSum = (((provider['totalDiscount'] as double).toInt())) == 0
          ? (totalSum + ((provider['totalSum'] as double).toInt()))
          : (totalSum +
              (((provider['totalSum'] as double).toInt()) + totalDiscount));
    }

    if (provider is Map && provider.containsKey('totalSum')) {
      totalSumWithDiscount =
          totalSumWithDiscount + ((provider['totalSum'] as double).toInt());
    }
  }

  int saudalineDiscount = (totalSumWithDiscount * 0.01).round();

  totalSumWithDiscount = (totalSumWithDiscount - saudalineDiscount).round();

  var result = {
    "totalQuantity": totalQuantity,
    "totalSum": totalSum,
    "totalSumWithDiscount": totalSumWithDiscount,
    "totalDiscount": totalDiscount,
    "saudalineDiscount": saudalineDiscount,
  };

  return result;
}

int? getProductQuantity(
  int? productId,
  int? providerId,
  List<dynamic>? basket,
) {
  if (basket == null) {
    return null; // Return null if basket is empty
  }

  for (var provider in basket) {
    if (provider is Map &&
        provider.containsKey('providerId') &&
        provider['providerId'] == providerId) {
      var goodsList = provider['goods'] ?? [];
      for (var goodsItem in goodsList) {
        if (goodsItem is Map &&
            goodsItem.containsKey('productId') &&
            goodsItem['productId'] == productId) {
          return (goodsItem['quantity'] as int);
        }
      }
    }
  }

  return null;
}

List<dynamic>? cardToOrderRequest(List<dynamic>? basket) {
  if (basket == null) {
    return []; // Return an empty list if basket is null
  }

  List<Map<String, dynamic>> convertedList = [];

  for (var provider in basket) {
    if (provider is Map &&
        provider.containsKey('providerId') &&
        provider.containsKey('totalQuantity') &&
        provider.containsKey('totalSum') &&
        provider.containsKey('goods')) {
      var providerId = provider['providerId'];
      var totalQuantity = provider['totalQuantity'];
      var totalSum = provider['totalSum'];
      var goodsList = provider['goods'] ?? [];

      List<Map<String, dynamic>> goodsJSON = [];

      for (var goodsItem in goodsList) {
        if (goodsItem is Map &&
            goodsItem.containsKey('productId') &&
            goodsItem.containsKey('quantity') &&
            goodsItem.containsKey('productSumWithDiscount')) {
          var productId = goodsItem['productId'];
          var quantity = goodsItem['quantity'];
          var price = goodsItem['productSumWithDiscount'];

          Map<String, dynamic> goodsItemJSON = {
            'id': productId,
            'cartQuantity': quantity,
            'price': price,
          };

          goodsJSON.add(goodsItemJSON);
        }
      }

      Map<String, dynamic> providerJSON = {
        'id': providerId,
        'cartQuantity': totalQuantity,
        'cartTotalAmount': totalSum,
        'goods': goodsJSON,
      };

      convertedList.add(providerJSON);
    }
  }

  return convertedList;
}

String? formatTariffResuestStatus(String? status) {
  switch (status) {
    case 'NEW':
      return 'Заявка отправлена';
    case 'UNPAID':
      return 'неоплаченный';
    case 'PAID':
      return 'оплаченный';
    default:
      return 'Ошибка';
  }
}

String? formatTarifRequestStatusColor(String? status) {
  switch (status) {
    case 'NEW':
      return '#096dd9';
    case 'PAID':
      return '#389e0d';
    case 'UNPAID':
      return '#d46b08';
    default:
      return '#d46b08';
  }
}

String? formatAdminTariffResuestStatus(String? status) {
  switch (status) {
    case 'CREATED':
      return 'заявка создана';
    case 'UNPAID':
      return 'неоплаченный';
    case 'PAID':
      return 'оплаченный';
    default:
      return 'Ошибка';
  }
}

Color formatAdminTarifRequestStatusColor(String? status) {
  switch (status) {
    case 'CREATED':
      return Color(0xff096dd9);
    case 'PAID':
      return Color(0xff389e0d);
    case 'UNPAID':
      return Color(0xffd46b08);
    default:
      return Color(0xffd46b08);
  }
}


String? generateLatLng(String? input) {
  List<String> parts = input!.split(' ');
  if (parts.length != 2) {
    throw Exception('Invalid coordinates format');
  }

  double latitude = double.tryParse(parts[0]) ?? 0;
  double longitude = double.tryParse(parts[1]) ?? 0;

  return '[$latitude, $longitude]';
}

String? generateMapScript(String? center) {
  return '''
    <script src="https://api-maps.yandex.ru/v3/?apikey=4f48692c-e2fb-4576-93cd-e9ed51c55534&lang=ru_RU"></script>
<script>
    let map;
    main();
    async function main() {
    await ymaps3.ready;  // Ensure the ymaps3 library is ready

    map = new ymaps3.YMap(document.getElementById('map'), {
        location: {
            center: $center,  // Replace with your desired coordinates
            zoom: 17,                        // Set the initial zoom level
        }
    });

    map.addChild(new ymaps3.YMapDefaultSchemeLayer());
    map.addChild(new ymaps3.YMapDefaultFeaturesLayer({zIndex: 1800}));

    const {YMapDefaultMarker} = await ymaps3.import('@yandex/ymaps3-markers@0.0.1');
    map.addChild(new YMapDefaultMarker({
        coordinates: $center,
        title: 'Адрес доставки!',
        color: 'orange'
    }));

    
    }
   
</script>
<div id="map" style="width:350px; height: 284px">
 </div>
    ''';
}

double? getLongitude(String? lonlat) {
  RegExp regex = RegExp(r'\[([\d.]+),');
  Match? match = regex.firstMatch(lonlat!);
  if (match != null && match.groupCount >= 1) {
    return double.parse(match.group(1)!);
  }
  return 0.0;
}

double? getlatitude(String? longlat) {
  RegExp regex = RegExp(r'\[(?:[\d.]+, )([\d.]+)\]');
  Match? match = regex.firstMatch(longlat!);
  if (match != null && match.groupCount >= 1) {
    return double.parse(match.group(1)!);
  }
  return 0.0;
}

String? getTotalQuantity(List<dynamic>? basket) {
  var totalQuantity = 0;
  for (var provider in basket!) {
    if (provider is Map && provider.containsKey('totalQuantity')) {
      totalQuantity += provider['totalQuantity'] as int;
    }
  }

  return totalQuantity.toString();
}

String? getTotalSumWithDiscount(List<dynamic>? basket) {
  var totalSumWithDiscount = 0;

  for (var provider in basket!) {
    if (provider is Map && provider.containsKey('totalSum')) {
      totalSumWithDiscount =
          totalSumWithDiscount + (provider['totalSum'] as int);
    }
  }

  var saudalineDiscount = (totalSumWithDiscount * 0.01).round();
  totalSumWithDiscount = (totalSumWithDiscount - saudalineDiscount);
  return totalSumWithDiscount.toString();
}

String? getSaudaLineDiscount(List<dynamic>? basket) {
  var totalSumWithDiscount = 0;

  for (var provider in basket!) {
    if (provider is Map && provider.containsKey('totalSum')) {
      totalSumWithDiscount =
          totalSumWithDiscount + (provider['totalSum'] as int);
    }
  }

  var saudalineDiscount = (totalSumWithDiscount * 0.01).round();

  return saudalineDiscount.toString();
}

String? getTotalSum(List<dynamic>? basket) {
  var totalSum = 0;
  var totalDiscount = 0;

  for (var provider in basket!) {
    if (provider is Map && provider.containsKey('totalDiscount')) {
      totalDiscount += (provider['totalDiscount'] as int);
    }

    if (provider is Map && provider.containsKey('totalSum')) {
      totalSum = ((provider['totalDiscount'] as int) == 0
          ? (totalSum + (provider['totalSum'] as int))
          : (totalSum + ((provider['totalSum'] as int) + totalDiscount)));
    }
  }

  return totalSum.toString();
}

String? getTotalDiscount(List<dynamic>? basket) {
  if (basket == null) {
    return "0";
  }
  var totalDiscount = 0;

  for (var provider in basket) {
    if (provider is Map && provider.containsKey('totalDiscount')) {
      totalDiscount += (provider['totalDiscount'] as int);
    }
  }
  return totalDiscount.toString();
}

dynamic returnJsonZero() {
  final jsonZero = {
    'value': 0,
  };

  return jsonZero;
}

String? formatDate(String? date) {
  // final dateTime = DateTime.parse(date!);
  // final formattedDate = '${dateTime.day.toString().padLeft(2, '0')}.'
  //     '${dateTime.month.toString().padLeft(2, '0')}.'
  //     '${dateTime.year.toString()} '
  //     '${dateTime.hour.toString().padLeft(2, '0')}:'
  //     '${dateTime.minute.toString().padLeft(2, '0')}';
  // return formattedDate;
  if (date == null) {
    return null;
  }

  DateTime? dateTime;

  if (date.contains('.')) {
    final inputFormat = DateFormat("yyyy-MM-ddT");
    dateTime = inputFormat.parse(date);
  } else {
    final inputFormat = DateFormat("yyyy-MM-ddT");
    dateTime = inputFormat.parse(date);
  }

  final outputFormat = DateFormat('dd.MM.yyyy');
  final formattedDate = outputFormat.format(dateTime);

  return formattedDate;
}


String? formatDateWithoutTime(String? date) {
  if (date == null) {
    return null;
  }

  DateTime? dateTime;

  if (date.contains('.')) {
    final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.S");
    dateTime = inputFormat.parse(date);
  } else {
    final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    dateTime = inputFormat.parse(date);
  }

  final outputFormat = DateFormat('dd.MM.yyyy');
  final formattedDate = outputFormat.format(dateTime);

  return formattedDate;
}


String? formatStatus(String? status) {
  switch (status) {
    case 'CREATED':
      return 'Ожидается подтверждение';
    case 'APPROVED':
      return 'Поставщик принял заказ';
    case 'CANCELED':
      return 'Поставщик отменил заказ';
    case 'CLOSED':
      return 'Вы отменили заказ';
    default:
      return 'Ошибка';
  }
}

int? doubleToInt(double? value) {
  if (value is double) {
    return value.round();
  } else {
    return value;
  }
}

String? deleteSpaces(String? word) {
  final result = word!.replaceAll(' ', '');

  return result;
}

String? returnROLEPROVIDERString() {
  return "ROLE_PROVIDER";
}

List<int> intToList(List<int> intList) {
  return intList.toList();
}

dynamic generateProductDetails(
  String title,
  String description,
  String? brand,
  bool? mainPhotoExist,
  String? mainPhotoUid,
  String? category,
  int? price,
  int? provider,
) {
  Map<String, dynamic> productDetails = {
    "title": title
        .replaceAll('"', r'\"')
        .replaceAll('«', r'\«')
        .replaceAll('»', r'\»'),
    "mainPhotoExist": mainPhotoExist ?? false,
    "mainPhotoUid": mainPhotoUid ?? '',
    "description": description
        .replaceAll('"', r'\"')
        .replaceAll('«', r'\«')
        .replaceAll('»', r'\»'),
  };

  if (brand != null) {
    productDetails["brand"] = brand;
  }

  if (category != null) {
    productDetails["category"] = category;
  }

  if (price != null) {
    productDetails["price"] = price;
  }

  if (provider != null) {
    productDetails["provider"] = provider;
  }

  return productDetails;
}

String? formatStatusColor(String? status) {
  switch (status) {
    case 'CREATED':
      return '#096dd9';
    case 'APPROVED':
      return '#389e0d';
    case 'CANCELED':
      return '#d46b08';
    case 'CLOSED':
      return '#d46b08';
    default:
      return '#d46b08';
  }
}

bool orderStatusBtn(String? status) {
  switch (status) {
    case 'CREATED':
      return true;
    case 'APPROVED':
      return false;
    case 'CANCELED':
      return false;
    case 'CLOSED':
      return false;
    default:
      return false;
  }
}

String? formatStatusProvider(String? status) {
  switch (status) {
    case 'CREATED':
      return 'Ожидает вашего подтверждения';
    case 'APPROVED':
      return 'Вы приняли заказ';
    case 'CANCELED':
      return 'Вы не приняли заказ';
    case 'CLOSED':
      return 'Заказчик отменил заказ';
    default:
      return 'Ошибка';
  }
}

String? formatAdminStatus(String? status) {
  switch (status) {
    case 'CREATED':
      return 'Ожидает подтверждения поставщика.';
    case 'APPROVED':
      return 'Поставщик принял заказ';
    case 'CANCELED':
      return 'Поставщик не приняли заказ';
    case 'CLOSED':
      return 'Заказчик отменил заказ';
    default:
      return 'Ошибка';
  }
}


double minusOnePercent(double sum) {
  return sum - (sum * 1 / 100);
}
