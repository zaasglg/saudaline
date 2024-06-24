import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';

import '/index.dart';
import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'serialization_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  bool showSplashImage = true;

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) => appStateNotifier.showSplashImage
          ? Builder(
              builder: (context) => Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(
                    'assets/images/logo-black.3dd0c1b45c67d12b1064a6cd9bc8bca3.png',
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            )
          : NavBarPage(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => appStateNotifier.showSplashImage
              ? Builder(
                  builder: (context) => Container(
                    color: Colors.transparent,
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo-black.3dd0c1b45c67d12b1064a6cd9bc8bca3.png',
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                )
              : NavBarPage(currentPageName: "home",),
          routes: [
            FFRoute(
              name: 'HomePage',
              path: 'homePage',
              builder: (context, params) => params.isEmpty
                  ? NavBarPage(initialPage: 'HomePage')
                  : HomePageWidget(),
            ),
            FFRoute(
              name: 'RegistrationPage',
              path: 'registrationPage',
              builder: (context, params) => RegistrationPageWidget(),
            ),
            FFRoute(
              name: 'Catalog',
              path: 'catalog',
              builder: (context, params) => params.isEmpty
                  ? NavBarPage(initialPage: 'Catalog')
                  : CatalogWidget(),
            ),
            FFRoute(
              name: 'Basket',
              path: 'basket',
              builder: (context, params) => params.isEmpty
                  ? NavBarPage(initialPage: 'Basket')
                  : BasketWidget(),
            ),
            FFRoute(
              name: 'Profile',
              path: 'profile',
              builder: (context, params) => params.isEmpty
                  ? NavBarPage(initialPage: 'Profile')
                  : NavBarPage(
                      initialPage: 'Profile',
                      page: ProfileWidget(),
                    ),
            ),
            FFRoute(
              name: 'AboutUs',
              path: 'aboutUs',
              builder: (context, params) => AboutUsWidget(),
            ),
            FFRoute(
              name: 'FAQPage',
              path: 'fAQPage',
              builder: (context, params) => FAQPageWidget(),
            ),
            FFRoute(
              name: 'PaymentAndDeliveryInfo',
              path: 'paymentAndDeliveryInfo',
              builder: (context, params) => PaymentAndDeliveryInfoWidget(),
            ),
            FFRoute(
              name: 'ProvidersInfo',
              path: 'providersInfo',
              builder: (context, params) => ProvidersInfoWidget(),
            ),
            FFRoute(
              name: 'CustomersInfo',
              path: 'customersInfo',
              builder: (context, params) => CustomersInfoWidget(),
            ),
            FFRoute(
              name: 'ContactsInfo',
              path: 'contactsInfo',
              builder: (context, params) => ContactsInfoWidget(),
            ),
            FFRoute(
              name: 'ProductPage',
              path: 'productPage',
              builder: (context, params) => NavBarPage(
                initialPage: '',
                page: ProductPageWidget(
                  id: params.getParam('id', ParamType.int),
                ),
              ),
            ),
            FFRoute(
              name: 'ProviderPage',
              path: 'catalog/providerPage',
              builder: (context, params) => NavBarPage(
                initialPage: '',
                page: ProviderPageWidget(
                  providerId: params.getParam('providerId', ParamType.int),
                ),
              ),
            ),
            FFRoute(
              name: 'CategoryProviders',
              path: 'categoryProviders',
              builder: (context, params) => NavBarPage(
                initialPage: '',
                page: CategoryProvidersWidget(
                  categoryTitle:
                      params.getParam('categoryTitle', ParamType.String),
                  categoryId: params.getParam('categoryId', ParamType.int),
                ),
              ),
            ),
            FFRoute(
              name: 'Login',
              path: 'login',
              builder: (context, params) => LoginWidget(),
            ),
            FFRoute(
              name: 'ConfirmationOrder',
              path: 'confirmationOrder',
              builder: (context, params) => NavBarPage(
                initialPage: '',
                page: ConfirmationOrderWidget(),
              ),
            ),
            FFRoute(
              name: 'SelectingDeliveryAddress',
              path: 'selectingDeliveryAddress',
              builder: (context, params) => SelectingDeliveryAddressWidget(
                address: params.getParam('address', ParamType.String),
              ),
            ),
            FFRoute(
              name: 'myOrders',
              path: 'myOrders',
              builder: (context, params) => NavBarPage(
                initialPage: '',
                page: MyOrdersWidget(),
              ),
            ),
            FFRoute(
              name: 'CitySelectionPega',
              path: 'citySelectionPega',
              builder: (context, params) => CitySelectionPegaWidget(),
            ),
            FFRoute(
              name: 'searchPage',
              path: 'searchPage',
              builder: (context, params) => NavBarPage(
                initialPage: '',
                page: SearchPageWidget(),
              ),
            ),
            FFRoute(
              name: 'DeliveryAddresses',
              path: 'deliveryAddresses',
              builder: (context, params) => DeliveryAddressesWidget(),
            ),
            FFRoute(
              name: 'AddAddress',
              path: 'addAddress',
              builder: (context, params) => AddAddressWidget(
                addressId: params.getParam('addressId', ParamType.int),
              ),
            ),
            FFRoute(
              name: 'UpdateAddressPage',
              path: 'updateAddressPage',
              builder: (context, params) => UpdateAddressPageWidget(
                addressId: params.getParam('addressId', ParamType.int),
              ),
            ),
            FFRoute(
              name: 'SelectAddress',
              path: 'selectAddress',
              builder: (context, params) => SelectAddressWidget(),
            ),
            FFRoute(
              name: 'RecoveryPassword',
              path: 'recoveryPassword',
              builder: (context, params) => RecoveryPasswordWidget(),
            ),
            FFRoute(
              name: 'PromotionPage',
              path: 'promotionPage',
              builder: (context, params) => PromotionPageWidget(
                promotionId: params.getParam('promotionId', ParamType.int),
              ),
            ),
            FFRoute(
              name: 'ProductsByCategories',
              path: 'productsByCategories',
              builder: (context, params) => ProductsByCategoriesWidget(
                categoryName: params.getParam('categoryName', ParamType.String),
                categoryId: params.getParam('categoryId', ParamType.int),
              ),
            ),
            FFRoute(
              name: 'ProviderCategories',
              path: 'providerCategories',
              builder: (context, params) => ProviderCategoriesWidget(
                providerName: params.getParam('providerName', ParamType.String),
                providerId: params.getParam('providerId', ParamType.int),
              ),
            ),
            FFRoute(
              name: 'PincodePage',
              path: 'pincodePage',
              builder: (context, params) => PincodePageWidget(),
            ),
            FFRoute(
              name: 'PincodePageConfirm',
              path: 'pincodePageConfirm',
              builder: (context, params) => PincodePageConfirmWidget(
                pincode: params.getParam('pincode', ParamType.String),
              ),
            ),
            FFRoute(
              name: 'PincodeEntryPage',
              path: 'pincodeEntryPage',
              builder: (context, params) => PincodeEntryPageWidget(),
            ),
            FFRoute(
              name: 'ProvidersProducts',
              path: 'providersProducts',
              builder: (context, params) => ProvidersProductsWidget(),
            ),
            FFRoute(
              name: 'ProductEditPage',
              path: 'productEditPage',
              builder: (context, params) => ProductEditPageWidget(
                productId: params.getParam('productId', ParamType.int),
              ),
            ),
            FFRoute(
              name: 'ProductAddPage',
              path: 'productAddPage',
              builder: (context, params) => ProductAddPageWidget(),
            ),
            FFRoute(
              name: 'ProvidersOrders',
              path: 'providersOrders',
              builder: (context, params) => NavBarPage(
                initialPage: '',
                page: ProvidersOrdersWidget(),
              ),
            ),
            FFRoute(
              name: 'ProvidersPromotions',
              path: 'providersPromotions',
              builder: (context, params) => NavBarPage(
                initialPage: '',
                page: ProvidersPromotionsWidget(),
              ),
            ),
            FFRoute(
              name: 'PromotionPageProvider',
              path: 'promotionPageProvider',
              builder: (context, params) => PromotionPageProviderWidget(
                promotionId: params.getParam('promotionId', ParamType.int),
              ),
            ),
            FFRoute(
              name: 'ProviderOrderDetails',
              path: 'providerOrderDetails',
              builder: (context, params) => ProviderOrderDetailsWidget(
                order: params.getParam('order', ParamType.JSON),
                products: params.getParam<dynamic>('products', ParamType.JSON, true),
                address: "",
                longitude: "",
                latitude: "",
              ),
            ),
            FFRoute(
              name: 'AddProductToPromotion',
              path: 'addProductToPromotion',
              builder: (context, params) => AddProductToPromotionWidget(
                promotionId: params.getParam('promotionId', ParamType.int),
              ),
            ),
            FFRoute(
              name: 'PromotionAddPage',
              path: 'promotionAddPage',
              builder: (context, params) => PromotionAddPageWidget(),
            ),
            FFRoute(
              name: 'PromotionEditPage',
              path: 'promotionEditPage',
              builder: (context, params) => PromotionEditPageWidget(
                promotionId: params.getParam('promotionId', ParamType.int),
              ),
            ),
            FFRoute(
              name: 'MyTariff',
              path: 'myTariff',
              builder: (context, params) => MyTariffWidget(),
            ),
            FFRoute(
              name: 'Tariffs',
              path: 'tariffs',
              builder: (context, params) => TariffsWidget(
                myTariffId: params.getParam('myTariffId', ParamType.int),
              ),
            )
          ].map((r) => r.toRoute(appStateNotifier)).toList(),
        ),
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.extraMap.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, [
    bool isList = false,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouter.of(context).location;
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}
