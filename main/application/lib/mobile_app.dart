library mobile_app;

import 'package:alice/alice.dart';
import 'package:shared_manifest/manifest.dart';
import 'package:shared_router/shared_router.dart';
import 'package:main_product_registry/main_product_registry.dart';
import 'package:shared_utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foundation_injector/foundation_injector.dart';
import 'package:lib_event/lib_event.dart';
import 'package:lib_network/lib_network.dart';
import 'package:lib_storage_auth_token/lib_authentication_token.dart';
import 'package:product_splash/product_splash.dart';

Future<void> configureMobileApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  try {
    await configureDependencies();
    runApp(MobileApp());
  } catch (error) {
    Logger.debug('Setup has been failed before starting app >> $error');
  }
}

Future<void> configureDependencies() async {
  await configureAuthTokenInjection();
  await configureEventInjection();
  await configureRouterInjection();
  await configureNetworkInjection();
  products.forEach((element) async {
    await element.onConfigureDependencies();
  });
}

class MobileApp extends StatefulWidget {
  @override
  _MobileAppState createState() => _MobileAppState();
}

class _MobileAppState extends State<MobileApp> {
  final _alice = Injector.instance<Alice>();
  final _route = Injector.instance<AppRouteRegistry>();

  @override
  Widget build(BuildContext context) {
    _initOnBuild(context);
    return MaterialApp(
      debugShowCheckedModeBanner: BuildConfig.DEBUG,
      navigatorKey: _alice.getNavigatorKey(),
      home: SplashProduct().defaultPage.registerPage(null),
      onGenerateRoute: _route.router.generator,
    );
  }

  void _initOnBuild(BuildContext context) {
    _route.initRouter();
    products.forEach((element) {
      element.onBuild(context);
    });
  }
}
