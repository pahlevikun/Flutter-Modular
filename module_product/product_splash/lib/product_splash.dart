library product_splash;

import 'package:shared_launcher/shared_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foundation_identifiers/foundation_identifiers.dart';
import 'package:product_splash/src/splash_app.dart';

export 'package:product_splash/product_splash.dart';

class SplashProduct implements Product {
  @override
  ProductIdentifier productId = ProductIdentifier.SPLASH;

  @override
  Map<PageIdentifier, RegisteredPage> registeredPages = {
    PageIdentifier.SPLASH: RegisteredPage(
      PathIdentifier.SPLASH,
      (args) => SplashApp(),
    )
  };

  @override
  RegisteredPage defaultPage = RegisteredPage(
    PathIdentifier.SPLASH,
    (args) => SplashApp(),
  );

  @override
  Future<void> onConfigureDependencies() async {}

  @override
  void onBuild(BuildContext context) {}
}
