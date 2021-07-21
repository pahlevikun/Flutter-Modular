import 'package:shared_launcher/shared_launcher.dart';
import 'package:shared_router_registry/shared_router_registry.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foundation_identifiers/foundation_identifiers.dart';

class AppRouteRegistry {
  final FluroRouter router;

  AppRouteRegistry(this.router);

  initRouter() {
    _initSplashRoutes();
    _initAuthenticationRoutes();
  }

  void _initSplashRoutes() {
    products
        .firstWhere((element) => element.productId == ProductIdentifier.SPLASH)
        .registeredPages
        .forEach((key, value) {
      _registerRoute(value);
    });
  }

  void _initAuthenticationRoutes() {
    products
        .firstWhere(
            (element) => element.productId == ProductIdentifier.AUTHENTICATION)
        .registeredPages
        .forEach((key, value) {
      _registerRoute(value);
    });
  }

  void _registerRoute(RegisteredPage page) {
    router.define(
      page.path,
      transitionType: TransitionType.material,
      handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, dynamic> parameters) {
          return page.registerPage(parameters);
        },
      ),
    );
  }
}
