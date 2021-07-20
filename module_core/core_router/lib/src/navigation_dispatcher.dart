import 'package:core_router/core_router.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:foundation_identifiers/foundation_identifiers.dart';

class NavigationDispatcher {
  final AppRouteRegistry _internalRoute;
  late FluroRouter _router;

  NavigationDispatcher(this._internalRoute) {
    _router = _internalRoute.router;
  }

  void back(context, {dynamic result}) {
    _router.pop(context, result);
  }

  Future<dynamic> goToSplash(BuildContext context) async {
    return _router.navigateTo(
      context,
      PathIdentifier.SPLASH,
      clearStack: true,
      transition: TransitionType.material,
    );
  }

  Future<dynamic> goToLogin(BuildContext context) async {
    return _router.navigateTo(
      context,
      PathIdentifier.LOGIN,
      transition: TransitionType.material,
    );
  }
}
