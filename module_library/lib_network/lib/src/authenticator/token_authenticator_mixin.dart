import 'dart:async';

import 'package:foundation_authenticator/foundation_authenticator.dart';
import 'package:lib_network/src/authenticator/token_authenticator_model.dart';

mixin TokenAuthenticatorMixin<String> {
  AuthenticationStatus _authenticationStatus = AuthenticationStatus.initial;

  late TokenStorage<String> _tokenStorage;

  String? _token;

  final StreamController<AuthenticationStatus> _controller =
      StreamController<AuthenticationStatus>.broadcast()
        ..add(AuthenticationStatus.initial);

  set tokenStorage(TokenStorage<String> tokenStorage) {
    _tokenStorage = tokenStorage..read().then(_updateStatus);
  }

  Future<String?> get token async {
    if (_authenticationStatus != AuthenticationStatus.initial) return _token;
    await authenticationStatus.first;
    return _token;
  }

  Stream<AuthenticationStatus> get authenticationStatus async* {
    yield _authenticationStatus;
    yield* _controller.stream;
  }

  Future<void> setToken(String? token) async {
    if (token == null) return clearToken();
    await _tokenStorage.write(token);
    _updateStatus(token);
  }

  Future<void> revokeToken() async {
    await _tokenStorage.delete();
    if (_authenticationStatus != AuthenticationStatus.unauthenticated) {
      _authenticationStatus = AuthenticationStatus.unauthenticated;
      _controller.add(_authenticationStatus);
    }
  }

  Future<void> clearToken() async {
    await _tokenStorage.delete();
    _updateStatus(null);
  }

  Future<void> close() => _controller.close();

  void _updateStatus(String? token) {
    _authenticationStatus = token != null
        ? AuthenticationStatus.authenticated
        : AuthenticationStatus.unauthenticated;
    _token = token;
    _controller.add(_authenticationStatus);
  }
}
