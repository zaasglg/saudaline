import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start ProviderAPi Group Code

class ProviderAPiGroup {
  static String baseUrl = 'https://server.saudaline.kz/api/v1';
  static Map<String, String> headers = {};
  static ProviderByIdCall providerByIdCall = ProviderByIdCall();
  static ProviderCategoriesCall providerCategoriesCall =
      ProviderCategoriesCall();
  static ProviderProductsCall providerProductsCall = ProviderProductsCall();
  static ProvidersByCategoryCall providersByCategoryCall =
      ProvidersByCategoryCall();
  static GetProviderByPrincipalCall getProviderByPrincipalCall =
      GetProviderByPrincipalCall();
  static GetProviderInfoByPrincipalToMobileCall
      getProviderInfoByPrincipalToMobileCall =
      GetProviderInfoByPrincipalToMobileCall();
}

class ProviderByIdCall {
  Future<ApiCallResponse> call({
    int? providerId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Provider By Id',
      apiUrl: '${ProviderAPiGroup.baseUrl}/provider/get-by-id',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'providerId': providerId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.name''',
      ));
  String? phone(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.phone''',
      ));
  String? logotype(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.logotype[:1].url''',
      ));
}

class ProviderCategoriesCall {
  Future<ApiCallResponse> call({
    int? providerId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Provider Categories',
      apiUrl: '${ProviderAPiGroup.baseUrl}/categories/get-by-provider-id',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'providerId': providerId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class ProviderProductsCall {
  Future<ApiCallResponse> call({
    int? providerId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Provider Products',
      apiUrl: '${ProviderAPiGroup.baseUrl}/product/get-by-provider',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'providerId': providerId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class ProvidersByCategoryCall {
  Future<ApiCallResponse> call({
    int? providerCatId,
    int? cityId = 1,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Providers By Category',
      apiUrl:
          '${ProviderAPiGroup.baseUrl}/provider/get-provider-by-category-id',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'providerCatId': providerCatId,
        'cityId': cityId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetProviderByPrincipalCall {
  Future<ApiCallResponse> call({
    String? jwtToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Provider By Principal',
      apiUrl: '${ProviderAPiGroup.baseUrl}/provider/get-provider-by-principal',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  dynamic balance(dynamic response) => getJsonField(
        response,
        r'''$.balance''',
      );
}

class GetProviderInfoByPrincipalToMobileCall {
  Future<ApiCallResponse> call({
    String? jwtToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Provider Info By Principal To mobile',
      apiUrl: '${ProviderAPiGroup.baseUrl}/provider/get-provider-by-principal',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

/// End ProviderAPi Group Code

/// Start Catalog Group Code

class CatalogGroup {
  static String baseUrl = 'https://server.saudaline.kz/api/v1';
  static Map<String, String> headers = {};
  static CityByNameCall cityByNameCall = CityByNameCall();
  static GetAllBrandsNamesCall getAllBrandsNamesCall = GetAllBrandsNamesCall();
}

class CityByNameCall {
  Future<ApiCallResponse> call({
    String? cityName = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'CityByName',
      apiUrl: '${CatalogGroup.baseUrl}/city/get-by-city-name',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'cityName': cityName,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  List? citiesList(dynamic response) => getJsonField(
        response,
        r'''$[:]''',
        true,
      ) as List?;
}

class GetAllBrandsNamesCall {
  Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetAllBrandsNames',
      apiUrl: '${CatalogGroup.baseUrl}/brands/get-all-names',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${FFAppState().jwttoken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? brandsList(dynamic response) => (getJsonField(
        response,
        r'''$''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

/// End Catalog Group Code

/// Start Login and Registration Group Code

class LoginAndRegistrationGroup {
  static String baseUrl = 'https://server.saudaline.kz/api/v1';
  static Map<String, String> headers = {};
  static LoginAPICall loginAPICall = LoginAPICall();
  static CheckTokenCall checkTokenCall = CheckTokenCall();
  static GetUserInfoCall getUserInfoCall = GetUserInfoCall();
  static PasswordRecoveryCall passwordRecoveryCall = PasswordRecoveryCall();
  static SendVerificationMailCall sendVerificationMailCall = SendVerificationMailCall();
  static GetJwtTokenByAccessTokenCall getJwtTokenByAccessTokenCall = GetJwtTokenByAccessTokenCall();
}

class LoginAPICall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? password = '',
  }) async {
    final ffApiRequestBody = '''
{
"login":"${email}",
"password":"${password}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Login API',
      apiUrl: '${LoginAndRegistrationGroup.baseUrl}/auth/login',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  String? roleName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.role.roleName''',
      ));
  int? roleId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.role.id''',
      ));
}

class CheckTokenCall {
  Future<ApiCallResponse> call({
    String? jwtToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'checkToken',
      apiUrl: '${LoginAndRegistrationGroup.baseUrl}/auth/check-token',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetUserInfoCall {
  Future<ApiCallResponse> call({
    String? jwtToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getUserInfo',
      apiUrl: '${LoginAndRegistrationGroup.baseUrl}/auth/user-info',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  String? roleName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.role.roleName''',
      ));
  int? roleId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.role.id''',
      ));
}

class PasswordRecoveryCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? password = '',
  }) async {
    final ffApiRequestBody = '''
{
  "email": "${email}",
  "password": "${password}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'PasswordRecovery',
      apiUrl:
          '${LoginAndRegistrationGroup.baseUrl}/account-info/reset-password-send-email',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class SendVerificationMailCall {
  Future<ApiCallResponse> call({
    String? email = '',
  }) async {
    final ffApiRequestBody = '''
{
  "email": "${email}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'SendVerificationMail',
      apiUrl:
          '${LoginAndRegistrationGroup.baseUrl}/auth/send-verification-email',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetJwtTokenByAccessTokenCall {
  Future<ApiCallResponse> call({
    String? refreshToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getJwtTokenByAccessToken',
      apiUrl:
          '${LoginAndRegistrationGroup.baseUrl}/auth/refreshtoken?refreshToken=${refreshToken}',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

/// End Login and Registration Group Code

/// Start Order Group Code

class OrderGroup {
  static String baseUrl = 'https://server.saudaline.kz/api/v1';
  static Map<String, String> headers = {};
  static MakeOrderCall makeOrderCall = MakeOrderCall();
  static MyOrdersCall myOrdersCall = MyOrdersCall();
  static OrderByIdCall orderByIdCall = OrderByIdCall();
}

class MakeOrderCall {
  Future<ApiCallResponse> call({
    dynamic? ordersJson,
    int? addressId,
    String? date = '',
    String? jwtToken = '',
    int? cityId = 0,
  }) async {
    final orders = _serializeJson(ordersJson, true);
    final ffApiRequestBody = '''
{
  "orderDetails": {
    "addressId": "${addressId}",
    "deliveryDate": "${date}",
    "cityId": ${FFAppState().cityId}
  },
  "ordersDtoRequestList": ${orders}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Make Order',
      apiUrl: '${OrderGroup.baseUrl}/orders/make-order',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class MyOrdersCall {
  Future<ApiCallResponse> call({
    String? jwtToken = '',
    String? status = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'MyOrders',
      apiUrl: '${OrderGroup.baseUrl}/orders/get-all-by-principal',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
        'Content-Type': 'application/json',
      },
      params: {
        'status': status,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class OrderByIdCall {
  Future<ApiCallResponse> call({
    String? jwtToken = '',
    int? orderId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'OrderById',
      apiUrl: '${OrderGroup.baseUrl}/orders/get-by-id',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
        'Content-Type': 'application/json',
      },
      params: {
        'orderId': orderId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  List? productsList(dynamic response) => getJsonField(
        response,
        r'''$.details''',
        true,
      ) as List?;
}

/// End Order Group Code

/// Start Product Group Code

class ProductGroup {
  static String baseUrl = 'https://server.saudaline.kz/api/v1';
  static Map<String, String> headers = {};
  static SearchProductsCall searchProductsCall = SearchProductsCall();
  static ProductsByCategoryCall productsByCategoryCall = ProductsByCategoryCall();
  static ProvidersProductsCall providersProductsCall = ProvidersProductsCall();
  static UpdateProductCall updateProductCall = UpdateProductCall();
  static CreateProductCall createProductCall = CreateProductCall();
  static DeleteProductByIdCall deleteProductByIdCall = DeleteProductByIdCall();
}

class SearchProductsCall {
  Future<ApiCallResponse> call({
    int? cityId = 1,
    String? keyword = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'SearchProducts',
      apiUrl: '${ProductGroup.baseUrl}/product/search-products',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'cityId': cityId,
        'keyword': keyword,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class ProductsByCategoryCall {
  Future<ApiCallResponse> call({
    int? categoryId,
    int? page = 0,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'ProductsByCategory',
      apiUrl: '${ProductGroup.baseUrl}/product/get-all-by-category',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'categoryId': categoryId,
        'page': page,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  List? productsList(dynamic response) => getJsonField(
        response,
        r'''$.list''',
        true,
      ) as List?;
  int? totalNumber(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.total_number''',
      ));
  int? numberOfPages(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.number_of_pages''',
      ));
  int? currentPage(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.current_page''',
      ));
}

class ProvidersProductsCall {
  Future<ApiCallResponse> call({
    String? jwtToken = '',
    int? page = 0,
    String? keyword = '0',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'ProvidersProducts',
      apiUrl: '${ProductGroup.baseUrl}/product/get-by-provider-principal',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {
        'page': page,
        'keyword': keyword,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  List? products(dynamic response) => getJsonField(
        response,
        r'''$.list''',
        true,
      ) as List?;
  int? totalNumber(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.total_number''',
      ));
  int? currentPage(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.current_page''',
      ));
}

class UpdateProductCall {
  Future<ApiCallResponse> call({
    int? productId,
    String? jwtToken = '',
    String? title = '',
    String? description = '',
    String? brand = '',
    bool? mainPhotoExist,
    String? mainPhotoUid = '',
    dynamic? mainPhotoJson,
    String? category = '',
    int? price,
    int? provider,
    String? article = '',
  }) async {
    final mainPhoto = _serializeJson(mainPhotoJson);
    final ffApiRequestBody = '''
{
  "title": "${title}",
  "description": "${description}",
  "brand": "${brand}",
  "mainPhotoExist": ${mainPhotoExist},
  "mainPhotoUid": "${mainPhotoUid}",
  "mainPhoto": ${mainPhoto},
  "category": "${category}",
  "price": ${price},
  "provider": ${provider},
  "article": ${article}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'UpdateProduct',
      apiUrl: '${ProductGroup.baseUrl}/product/update-product-by-modile?productId=${productId}',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class CreateProductCall {
  Future<ApiCallResponse> call({
    String? jwtToken = '',
    String? title = '',
    String? description = '',
    String? brand = '',
    bool? mainPhotoExist,
    String? mainPhotoUid = '',
    dynamic? mainPhotoJson,
    String? category = '',
    int? price,
    int? provider,
    String? article,
  }) async {
    final mainPhoto = _serializeJson(mainPhotoJson);
    final ffApiRequestBody = '''
{
  "title": "${title}",
  "description": "${description}",
  "brand": "${brand}",
  "mainPhotoExist": ${mainPhotoExist},
  "mainPhotoUid": "${mainPhotoUid}",
  "mainPhoto": ${mainPhoto},
  "category": "${category}",
  "price": ${price},
  "article": ${article},
  "provider": ${provider}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'CreateProduct',
      apiUrl: '${ProductGroup.baseUrl}/product/create-product-by-modile',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteProductByIdCall {
  Future<ApiCallResponse> call({
    int? productId,
    String? jwtToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'DeleteProductById',
      apiUrl: '${ProductGroup.baseUrl}/product/delete-product',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {
        'id': productId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

/// End Product Group Code

/// Start DeliveryDetails Group Code

class DeliveryDetailsGroup {
  static String baseUrl = 'https://server.saudaline.kz/api/v1';
  static Map<String, String> headers = {};
  static CustomersAddressesCall customersAddressesCall =
      CustomersAddressesCall();
  static AddNewDeliveryAddressCall addNewDeliveryAddressCall =
      AddNewDeliveryAddressCall();
  static DeleteDeliveryAddressCall deleteDeliveryAddressCall =
      DeleteDeliveryAddressCall();
  static UpdateDeliveryAddressCall updateDeliveryAddressCall =
      UpdateDeliveryAddressCall();
  static GetAddressByIdCall getAddressByIdCall = GetAddressByIdCall();
}

class CustomersAddressesCall {
  Future<ApiCallResponse> call({
    String? jwtToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Customers Addresses',
      apiUrl: '${DeliveryDetailsGroup.baseUrl}/delivery-details/get-my-address',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class AddNewDeliveryAddressCall {
  Future<ApiCallResponse> call({
    String? address = '',
    String? latitude = '',
    String? longitude = '',
    String? comment = '',
    String? fio = '',
    String? tel = '',
    String? jwtToken = '',
  }) async {
    final ffApiRequestBody = '''
{
  "address": "${address}",
  "latitude": "${latitude}",
  "longitude": "${longitude}",
  "comment": "${comment}",
  "fio": "${fio}",
  "tel": "${tel}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Add new Delivery Address',
      apiUrl: '${DeliveryDetailsGroup.baseUrl}/delivery-details/create-address',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteDeliveryAddressCall {
  Future<ApiCallResponse> call({
    int? addressId,
    String? jwtToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Delete Delivery Address',
      apiUrl: '${DeliveryDetailsGroup.baseUrl}/delivery-details/delete-address',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {
        'addressId': addressId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateDeliveryAddressCall {
  Future<ApiCallResponse> call({
    String? address = '',
    String? latitude = '',
    String? longitude = '',
    String? comment = '',
    String? fio = '',
    String? tel = '',
    int? addressId,
    String? jwtToken = '',
  }) async {
    final ffApiRequestBody = '''
{
  "address": "${address}",
  "latitude": "${latitude}",
  "longitude": "${longitude}",
  "comment": "${comment}",
  "fio": "${fio}",
  "tel": "${tel}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Update Delivery Address',
      apiUrl:
          '${DeliveryDetailsGroup.baseUrl}/delivery-details/update-address?addressId=${addressId}',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetAddressByIdCall {
  Future<ApiCallResponse> call({
    int? addressId,
    String? jwtToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Address By Id',
      apiUrl: '${DeliveryDetailsGroup.baseUrl}/delivery-details/get-by-id',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {
        'addressId': addressId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

/// End DeliveryDetails Group Code

/// Start Promotion Group Code

class PromotionGroup {
  static String baseUrl = 'https://server.saudaline.kz/api/v1';
  static Map<String, String> headers = {};
  static PromotionByIdCall promotionByIdCall = PromotionByIdCall();
  static DeletePromotionByIdCall deletePromotionByIdCall = DeletePromotionByIdCall();
  static DeleteProductFromPromotionByIdCall deleteProductFromPromotionByIdCall = DeleteProductFromPromotionByIdCall();
  static UpdateProductPromotionDiscountCall updateProductPromotionDiscountCall = UpdateProductPromotionDiscountCall();
  static AddDiscountToProductCall addDiscountToProductCall = AddDiscountToProductCall();
  static CreatePromotionCall createPromotionCall = CreatePromotionCall();
  static UpdatePromotionByIdCall updatePromotionByIdCall = UpdatePromotionByIdCall();
}

class PromotionByIdCall {
  Future<ApiCallResponse> call({
    int? promotionId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Promotion By Id',
      apiUrl: '${PromotionGroup.baseUrl}/promotion/get-by-id',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'promotionId': promotionId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  List? productsList(dynamic response) => getJsonField(
        response,
        r'''$.products''',
        true,
      ) as List?;
}

class DeletePromotionByIdCall {
  Future<ApiCallResponse> call({
    int? promotionId,
    String? jwtToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Delete Promotion By Id',
      apiUrl: '${PromotionGroup.baseUrl}/promotion/delete-promotion',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {
        'promotionId': promotionId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteProductFromPromotionByIdCall {
  Future<ApiCallResponse> call({
    int? productPromotionId,
    String? jwtToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Delete Product From Promotion By Id',
      apiUrl: '${PromotionGroup.baseUrl}/promotion-product/delete',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {
        'productPromotionId': productPromotionId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateProductPromotionDiscountCall {
  Future<ApiCallResponse> call({
    int? productPromotionId,
    int? productId,
    bool? isActive,
    int? discount,
    String? jwtToken = '',
  }) async {
    final ffApiRequestBody = '''
{
  "product": ${productId},
  "discount": ${discount},
  "isActive": ${isActive}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Update Product Promotion Discount',
      apiUrl:
          '${PromotionGroup.baseUrl}/promotion-product/update?productPromotionId=${productPromotionId}',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class AddDiscountToProductCall {
  Future<ApiCallResponse> call({
    int? productId,
    int? discount,
    int? promotionId,
    bool? isActive = true,
    String? jwtToken = '',
  }) async {
    final ffApiRequestBody = '''
{
  "product": ${productId},
  "discount": ${discount},
  "promotion": ${promotionId},
  "isActive": "true"
}''';
    return ApiManager.instance.makeApiCall(
      callName: ' Add Discount To Product',
      apiUrl:
          '${PromotionGroup.baseUrl}/promotion-product/create-products-promotion',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class CreatePromotionCall {
  Future<ApiCallResponse> call({
    String? title = '',
    String? subTitle = '',
    dynamic? photoJson,
    String? description = '',
    int? provider,
    String? startDate = '',
    String? finishDate = '',
    String? jwtToken = '',
    int? city
  }) async {
    final photo = _serializeJson(photoJson);
    final ffApiRequestBody = '''
{
  "title": "${title}",
  "subTitle": "${subTitle}",
  "photo": [
    ${photo}
  ],
  "description": "${description}",
  "provider": ${provider},
  "startDate": "${startDate}",
  "finishDate": "${finishDate}",
  "city": "${city}",
  "isActive": true
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Create Promotion',
      apiUrl: '${PromotionGroup.baseUrl}/promotion/create-promotion',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdatePromotionByIdCall {
  Future<ApiCallResponse> call({
    String? title = '',
    String? subTitle = '',
    dynamic? photoJson,
    String? description = '',
    int? provider,
    String? startDate = '',
    String? finishDate = '',
    int? promotionId,
    String? jwtToken = '',
    int? city,
  }) async {
    final photo = _serializeJson(photoJson);
    final ffApiRequestBody = '''
{
  "title": "${title}",
  "subTitle": "${subTitle}",
  "photo": [
    ${photo}
  ],
  "description": "${description}",
  "provider": ${provider},
  "startDate": "${startDate}00:00:00.00Z",
  "finishDate": "${finishDate}00:00:00.00Z",
  "city": $city,
  "isActive": true
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Update Promotion By Id',
      apiUrl:
          '${PromotionGroup.baseUrl}/promotion/update-promotion?promotionId=${promotionId}',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

/// End Promotion Group Code

/// Start Category Group Code

class CategoryGroup {
  static String baseUrl = 'http://server.saudaline.kz/api/v1';
  static Map<String, String> headers = {};
  static CategoriesByProviderIdCall categoriesByProviderIdCall =
      CategoriesByProviderIdCall();
  static GetCategoriesByProviderPrincipalCall
      getCategoriesByProviderPrincipalCall =
      GetCategoriesByProviderPrincipalCall();
  static GetCategoryTitlesByProviderCall getCategoryTitlesByProviderCall =
      GetCategoryTitlesByProviderCall();
}

class CategoriesByProviderIdCall {
  Future<ApiCallResponse> call({
    int? providerId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Categories By ProviderId',
      apiUrl: '${CategoryGroup.baseUrl}/categories/get-by-provider-id',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'providerId': providerId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetCategoriesByProviderPrincipalCall {
  Future<ApiCallResponse> call({
    String? jwtToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetCategoriesByProviderPrincipal',
      apiUrl: '${CategoryGroup.baseUrl}/categories/get-by-provider-principal',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  List? listCategory(dynamic response) => getJsonField(
        response,
        r'''$[:]''',
        true,
      ) as List?;
  List<String>? categoryTitleList(dynamic response) => (getJsonField(
        response,
        r'''$[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? categoryIdList(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
}

class GetCategoryTitlesByProviderCall {
  Future<ApiCallResponse> call({
    int? userId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetCategoryTitlesByProvider',
      apiUrl: '${CategoryGroup.baseUrl}/categories/get-titles-by-provider',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'userId': userId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? listOfTitles(dynamic response) => (getJsonField(
        response,
        r'''$''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

/// End Category Group Code

/// Start File Group Code

class FileGroup {
  static String baseUrl = 'https://server.saudaline.kz/api/v1';
  static Map<String, String> headers = {};
  static UploadMainPhotoCall uploadMainPhotoCall = UploadMainPhotoCall();
}

class UploadMainPhotoCall {
  Future<ApiCallResponse> call({
    FFUploadedFile? file,
    String? jwtToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'UploadMainPhoto',
      apiUrl: '${FileGroup.baseUrl}/file/upload-photos-by-mobile',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {
        'file': file,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

/// End File Group Code

/// Start Orders Group Code

class OrdersGroup {
  static String baseUrl = 'https://server.saudaline.kz/api/v1';
  static Map<String, String> headers = {};
  static GetProvidersOrdersCall getProvidersOrdersCall = GetProvidersOrdersCall();
  static AcceptOrderCall acceptOrderCall = AcceptOrderCall();
  static RejectOrderCall rejectOrderCall = RejectOrderCall();
}

class GetProvidersOrdersCall {
  Future<ApiCallResponse> call({
    String? jwtToken = '',
    int? userId,
    int? page = 1,
    String? status = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetProvidersOrders',
      apiUrl: '${OrdersGroup.baseUrl}/orders/get-all-orders',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {
        'userId': userId,
        'status': status,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  List? ordersList(dynamic response) => getJsonField(
        response,
        r'''$.list''',
        true,
      ) as List?;
}

class AcceptOrderCall {
  Future<ApiCallResponse> call({
    String? jwtToken = '',
    int? orderId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'AcceptOrder',
      apiUrl: '${OrdersGroup.baseUrl}/orders/accept-order?orderId=${orderId}',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      bodyType: BodyType.NONE,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class RejectOrderCall {
  Future<ApiCallResponse> call({
    String? jwtToken = '',
    int? orderId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'RejectOrder',
      apiUrl: '${OrdersGroup.baseUrl}/orders/reject-order?orderId=${orderId}',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

/// End Orders Group Code

/// Start Promotions Group Code

class PromotionsGroup {
  static String baseUrl = 'https://server.saudaline.kz/api/v1';
  static Map<String, String> headers = {};
  static GetProvidersPromotionsCall getProvidersPromotionsCall =
      GetProvidersPromotionsCall();
}

class GetProvidersPromotionsCall {
  Future<ApiCallResponse> call({
    String? jwtToken = '',
    int? userId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetProvidersPromotions',
      apiUrl: '${PromotionsGroup.baseUrl}/promotion/get-all-promotions',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {
        'userId': userId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

/// End Promotions Group Code

/// Start Tariff Group Code

class TariffGroup {
  static String baseUrl = 'https://server.saudaline.kz/api/v1';
  static Map<String, String> headers = {};
  static GetAllTariffsCall getAllTariffsCall = GetAllTariffsCall();
  static PostTarifRequestCall postTarifRequestCall = PostTarifRequestCall();
  static GetAllTransactionRefillCall getAllTransactionRefillCall =
      GetAllTransactionRefillCall();
  static GetAllTransactionDeductionsCall getAllTransactionDeductionsCall =
      GetAllTransactionDeductionsCall();
  static GetAllTariffRequestsCall getAllTariffRequestsCall =
      GetAllTariffRequestsCall();
}

class GetAllTariffsCall {
  Future<ApiCallResponse> call({
    String? jwtToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get All Tariffs',
      apiUrl: '${TariffGroup.baseUrl}/tariff/get-all',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class PostTarifRequestCall {
  Future<ApiCallResponse> call({
    String? jwtToken = '',
    int? tariffId,
    String? tel = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Post Tarif Request',
      apiUrl:
          '${TariffGroup.baseUrl}/tariff-request?tariffId=${tariffId}&tel=${tel}',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      bodyType: BodyType.NONE,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetAllTransactionRefillCall {
  Future<ApiCallResponse> call({
    int? page,
    int? userId,
    String? jwtToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetAllTransactionRefill',
      apiUrl:
          '${TariffGroup.baseUrl}/transaction-refill/get-all?page=${page}&userId=${userId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetAllTransactionDeductionsCall {
  Future<ApiCallResponse> call({
    int? page,
    int? userId,
    String? jwtToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetAllTransactionDeductions',
      apiUrl:
          '${TariffGroup.baseUrl}/transaction-deduction/get-all?page=${page}&userId=${userId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetAllTariffRequestsCall {
  Future<ApiCallResponse> call({
    int? page,
    int? userId,
    String? jwtToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetAllTariffRequests',
      apiUrl:
          '${TariffGroup.baseUrl}/tariff-request/get-all?page=${page}&userId=${userId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

/// End Tariff Group Code

class RegistrationSaudalineCall {
  static Future<ApiCallResponse> call({
    String? businessName = '',
    String? businessNumber = '',
    String? email = '',
    String? formBusiness = '',
    String? password = '',
    String? phoneNumber = '',
    String? userType = '',
    String? providerCategory = "1",
  }) async {
    final ffApiRequestBody = '''
{
  "businessName": "${businessName}",
  "businessNumber": "${businessNumber}",
  "email": "${email}",
  "formBusiness": "${formBusiness}",
  "password": "${password}",
  "phoneNumber": "${phoneNumber}",
  "userType": "${userType}",
  "providerCategory": 1
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Registration Saudaline',
      apiUrl: 'https://server.saudaline.kz/api/v1/auth/mobile-registration',
      callType: ApiCallType.POST,
      headers: {
        'Content-type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetAllCitiesByRegionCall {
  static Future<ApiCallResponse> call({
    String? regionName = 'Жамбыл',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get All Cities By Region',
      apiUrl:
          'http://server.saudaline.kz/api/v1/city/get-by-region-name?regionName=${regionName}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? citynameList(dynamic response) => (getJsonField(
        response,
        r'''$[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetAllProviderCategoryCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get All Provider Category',
      apiUrl:
          'https://server.saudaline.kz/api/v1/provider-category/get-all-provider-categories',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetAllRegionsCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get All Regions',
      apiUrl: 'http://server.saudaline.kz/api/v1/region/get-all',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class ProvidersCategoryCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'ProvidersCategory',
      apiUrl:
          'http://server.saudaline.kz/api/v1/provider-category/get-all-provider-categories',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetAllActivePromotionsCall {
  static Future<ApiCallResponse> call({
    int? cityId = 1,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get All Active Promotions',
      apiUrl: 'http://server.saudaline.kz/api/v1/promotion/get-active-promotions',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'cityId': cityId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static List? promotionList(dynamic response) => getJsonField(
        response,
        r'''$''',
        true,
      ) as List?;
}

class GetPopularProductsCall {
  static Future<ApiCallResponse> call({
    int? cityId = 1,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Popular Products',
      apiUrl: 'http://server.saudaline.kz/api/v1/product/get-popular-products',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'cityId': cityId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetProductByIdCall {
  static Future<ApiCallResponse> call({
    int? id,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Product By Id',
      apiUrl:
          'http://server.saudaline.kz/api/v1/product/get-by-id?productId=${id}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic? product(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
  static int? productId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.id''',
      ));
  static String? providerLogo(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.provider.logotype[:1].url''',
      ));
  static String? productImage(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.mainPhoto.url''',
      ));
  static String? productName(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.title''',
      ));

  static String? productArticle(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.article''',
      ));
  static int? discount(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.discount''',
      ));
  static int? discountPrice(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.discountprice''',
      ));
  static int? price(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.price''',
      ));
}

class ProductsByIdListCall {
  static Future<ApiCallResponse> call({
    String? ids = 'null',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Products By Id List',
      apiUrl: 'http://server.saudaline.kz/api/v1/product/get-all-by-ids',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'ids': ids,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class YandexMapGeocoderCall {
  static Future<ApiCallResponse> call({
    String? address = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Yandex Map Geocoder',
      apiUrl: 'https://geocode-maps.yandex.ru/1.x',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'apikey': "4f48692c-e2fb-4576-93cd-e9ed51c55534",
        'format': "json",
        'geocode': address,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
