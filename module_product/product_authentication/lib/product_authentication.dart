library product_authentication;

import 'package:shared_launcher/shared_launcher.dart';
import 'package:flutter/material.dart';
import 'package:foundation_identifiers/foundation_identifiers.dart';
import 'package:product_authentication/src/authentication_app.dart';

export 'package:product_authentication/product_authentication.dart';

class AuthenticationProduct implements Product {
  @override
  ProductIdentifier productId = ProductIdentifier.AUTHENTICATION;

  @override
  Map<PageIdentifier, RegisteredPage> registeredPages = {
    PageIdentifier.LOGIN: RegisteredPage(
      PathIdentifier.LOGIN,
      (args) => LoginApp(),
    ),
  };

  @override
  RegisteredPage defaultPage = RegisteredPage(
    PathIdentifier.LOGIN,
    (args) => LoginApp(),
  );

  @override
  Future<void> onConfigureDependencies() async {}

  @override
  void onBuild(BuildContext context) {}
}
