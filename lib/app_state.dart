import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import 'backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  bool _isProvider = false;
  bool get isProvider => _isProvider;
  set isProvider(bool _value) {
    _isProvider = _value;
  }

  bool _isAdmin = false;
  bool get isAdmin => _isAdmin;
  set isAdmin(bool _value) {
    _isAdmin = _value;
  }

  String _typeBusiness = 'Магазин';
  String get typeBusiness => _typeBusiness;
  set typeBusiness(String _value) {
    _typeBusiness = _value;
  }

  List<dynamic> _lastViewed = [];
  List<dynamic> get lastViewed => _lastViewed;
  set lastViewed(List<dynamic> _value) {
    _lastViewed = _value;
  }

  void addToLastViewed(dynamic _value) {
    _lastViewed.add(_value);
  }

  void removeFromLastViewed(dynamic _value) {
    _lastViewed.remove(_value);
  }

  void removeAtIndexFromLastViewed(int _index) {
    _lastViewed.removeAt(_index);
  }

  void updateLastViewedAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _lastViewed[_index] = updateFn(_lastViewed[_index]);
  }

  void insertAtIndexInLastViewed(int _index, dynamic _value) {
    _lastViewed.insert(_index, _value);
  }

  List<int> _cardProducts = [];
  List<int> get cardProducts => _cardProducts;
  set cardProducts(List<int> _value) {
    _cardProducts = _value;
  }

  void addToCardProducts(int _value) {
    _cardProducts.add(_value);
  }

  // List _lastViewedProducts = [];
  // List get lastViewedProducts => _lastViewedProducts;
  // set lastViewedProducts(List _value) {
  //   _lastViewedProducts = _value;
  // }
  //
  // void addToLastViewedProducts(_value) {
  //   _lastViewedProducts.add(_value);
  // }

  void removeFromCardProducts(int _value) {
    _cardProducts.remove(_value);
  }

  void removeAtIndexFromCardProducts(int _index) {
    _cardProducts.removeAt(_index);
  }

  void updateCardProductsAtIndex(
    int _index,
    int Function(int) updateFn,
  ) {
    _cardProducts[_index] = updateFn(_cardProducts[_index]);
  }

  void insertAtIndexInCardProducts(int _index, int _value) {
    _cardProducts.insert(_index, _value);
  }

  List<int> _cardProviders = [];
  List<int> get cardProviders => _cardProviders;
  set cardProviders(List<int> _value) {
    _cardProviders = _value;
  }

  void addToCardProviders(int _value) {
    _cardProviders.add(_value);
  }

  void removeFromCardProviders(int _value) {
    _cardProviders.remove(_value);
  }

  void removeAtIndexFromCardProviders(int _index) {
    _cardProviders.removeAt(_index);
  }

  void updateCardProvidersAtIndex(
    int _index,
    int Function(int) updateFn,
  ) {
    _cardProviders[_index] = updateFn(_cardProviders[_index]);
  }

  void insertAtIndexInCardProviders(int _index, int _value) {
    _cardProviders.insert(_index, _value);
  }

  List<dynamic> _basketProducts = [];
  List<dynamic> get basketProducts => _basketProducts;
  set basketProducts(List<dynamic> _value) {
    _basketProducts = _value;
  }

  void addToBasketProducts(dynamic _value) {
    _basketProducts.add(_value);
  }

  void removeFromBasketProducts(dynamic _value) {
    _basketProducts.remove(_value);
  }

  void removeAtIndexFromBasketProducts(int _index) {
    _basketProducts.removeAt(_index);
  }

  void updateBasketProductsAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _basketProducts[_index] = updateFn(_basketProducts[_index]);
  }

  void insertAtIndexInBasketProducts(int _index, dynamic _value) {
    _basketProducts.insert(_index, _value);
  }

  bool _isLogged = false;
  bool get isLogged => _isLogged;
  set isLogged(bool _value) {
    _isLogged = _value;
  }

  String _jwttoken = '';
  String get jwttoken => _jwttoken;
  set jwttoken(String _value) {
    _jwttoken = _value;
  }

  dynamic _accountInfo;
  dynamic get accountInfo => _accountInfo;
  set accountInfo(dynamic _value) {
    _accountInfo = _value;
  }

  List<dynamic> _findedMapAddress = [];
  List<dynamic> get findedMapAddress => _findedMapAddress;
  set findedMapAddress(List<dynamic> _value) {
    _findedMapAddress = _value;
  }

  void addToFindedMapAddress(dynamic _value) {
    _findedMapAddress.add(_value);
  }

  void removeFromFindedMapAddress(dynamic _value) {
    _findedMapAddress.remove(_value);
  }

  void removeAtIndexFromFindedMapAddress(int _index) {
    _findedMapAddress.removeAt(_index);
  }

  void updateFindedMapAddressAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _findedMapAddress[_index] = updateFn(_findedMapAddress[_index]);
  }

  void insertAtIndexInFindedMapAddress(int _index, dynamic _value) {
    _findedMapAddress.insert(_index, _value);
  }

  String _customerAddress = '';
  String get customerAddress => _customerAddress;
  set customerAddress(String _value) {
    _customerAddress = _value;
  }

  String _LonLng = '';
  String get LonLng => _LonLng;
  set LonLng(String _value) {
    _LonLng = _value;
  }

  int _cityId = 1;
  int get cityId => _cityId;
  set cityId(int _value) {
    _cityId = _value;
  }

  String _cityName = 'Тараз';
  String get cityName => _cityName;
  set cityName(String _value) {
    _cityName = _value;
  }

  int _addressid = 0;
  int get addressid => _addressid;
  set addressid(int _value) {
    _addressid = _value;
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool _value) {
    _loading = _value;
  }

  int _universalDiscountValue = 0;
  int get universalDiscountValue => _universalDiscountValue;
  set universalDiscountValue(int _value) {
    _universalDiscountValue = _value;
  }
}
