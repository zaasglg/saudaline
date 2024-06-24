import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/nav/nav.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  await FlutterFlowTheme.initialize();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppStateof(BuildContext context) => context.findAncestorStateOfType<_MyAppState>()!;

  static of(BuildContext context) {}
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  bool displaySplashImage = true;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);

    Future.delayed(const Duration(milliseconds: 2),
            () => setState(() => _appStateNotifier.stopShowingSplashImage()));
  }

  void setThemeMode(ThemeMode mode) => setState(() {
    _themeMode = mode;
    FlutterFlowTheme.saveThemeMode(mode);
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('ru'),
        const Locale('en')
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: EasySplashScreen(
        durationInSeconds: 3,
        logo: Image.asset('assets/images/logo.png'),
        logoWidth: 120,
        backgroundColor: const Color(0xfff7931e),
        showLoader: true,
        loaderColor: Colors.white,
        navigator: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'SaudaLine',
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en', '')],
          theme: ThemeData(
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
          ),
          themeMode: _themeMode,
          routerConfig: _router,
        ),
      ),
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage, this.page, this.currentPageName}) : super(key: key);

  final String? initialPage;
  final Widget? page;
  final String? currentPageName;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {

  String currentPageName = "home";

  @override
  void initState() {
    super.initState();

    currentPageName = widget.currentPageName ?? "home";
  }

  final Map<String, Widget> pagesProvider = {
    "home": const HomePageWidget(),
    "catalog": const CatalogWidget(),
    "profile": const ProfileWidget(),
  };

  final Map<String, Widget> pages = {
    "home": const HomePageWidget(),
    "catalog": const CatalogWidget(),
    "cart": const BasketWidget(),
    "profile": const ProfileWidget()
  };

  List<Widget> get destinations {
    return [
      const NavigationDestination(
        selectedIcon: Icon(CupertinoIcons.house_fill, color: Colors.white),
        icon: Icon(CupertinoIcons.home),
        label: 'Главная',
      ),
      const NavigationDestination(
        selectedIcon: Icon(CupertinoIcons.arrow_up_bin_fill, color: Colors.white,),
        icon: Icon(CupertinoIcons.arrow_up_bin),
        label: 'Каталог',
      ),
      NavigationDestination(
        selectedIcon: _buildBadgeIcon(FFAppState().cardProducts.length, true),
        icon: _buildBadgeIcon(FFAppState().cardProducts.length, false),
        label: 'Корзина',
      ),
      const NavigationDestination(
        selectedIcon: Icon(CupertinoIcons.person_fill, color: Colors.white,),
        icon: Icon(CupertinoIcons.person),
        label: 'Профиль',
      ),
    ];
  }

  final List<Widget> destinationsProvider = [
    const NavigationDestination(
      selectedIcon: Icon(CupertinoIcons.house_fill, color: Colors.white),
      icon: Icon(CupertinoIcons.home),
      label: 'Главная',
    ),
    const NavigationDestination(
      selectedIcon: Icon(CupertinoIcons.arrow_up_bin_fill, color: Colors.white,),
      icon: Icon(CupertinoIcons.arrow_up_bin),
      label: 'Каталог',
    ),
    const NavigationDestination(
      selectedIcon: Icon(CupertinoIcons.person_fill, color: Colors.white,),
      icon: Icon(CupertinoIcons.person),
      label: 'Профиль',
    ),
  ];


  @override
  Widget build(BuildContext context) {
    bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            if (FFAppState().isProvider) {
              if (index == 0) {
                currentPageName = "home";
              } else if (index == 1) {
                currentPageName = "catalog";
              } else if (index == 2) {
                currentPageName = "profile";
              }
            } else {
              if (index == 0) {
                currentPageName = "home";
              } else if (index == 1) {
                currentPageName = "catalog";
              } else if (index == 2) {
                currentPageName = "cart";
              } else {
                currentPageName = "profile";
              }
            }
            // currentPageIndex = index;
          });

          print(FFAppState().isProvider);
        },
        selectedIndex: FFAppState().isProvider
            ? pagesProvider.keys.toList().indexOf(currentPageName)
            : pages.keys.toList().indexOf(currentPageName),
        backgroundColor: isDarkMode ? Colors.black12 : Colors.white12,
        indicatorColor: FlutterFlowTheme.of(context).primary,
        destinations: FFAppState().isProvider ? destinationsProvider : destinations,
      ),
      body: FFAppState().isProvider ? pagesProvider[currentPageName] : pages[currentPageName],
    );
  }


  Widget _buildBadgeIcon(int count, bool isSelected) {
    return Badge(
      child: isSelected
          ? const Icon(CupertinoIcons.cart_fill, color: Colors.white)
          : const Icon(CupertinoIcons.cart),
      label: Text("$count"),
    );
  }
}
