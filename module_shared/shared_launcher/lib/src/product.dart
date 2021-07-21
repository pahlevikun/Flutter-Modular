library app_feature;

import 'package:flutter/widgets.dart';
import 'package:foundation_identifiers/foundation_identifiers.dart';

abstract class Product {
  late final ProductIdentifier productId;

  late final Map<PageIdentifier, RegisteredPage> registeredPages;

  late final RegisteredPage defaultPage;

  Future<void> onConfigureDependencies();

  void onBuild(BuildContext context);
}

class RegisteredPage {
  late final String path;
  late final PageBuilder registerPage;

  RegisteredPage(this.path, this.registerPage);
}

typedef PageBuilder = Widget Function(dynamic args);
