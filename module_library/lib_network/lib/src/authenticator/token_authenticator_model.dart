class RevokeTokenException implements Exception {}

class AuthToken {
  const AuthToken({
    required this.accessToken,
    this.tokenType = 'bearer',
    this.expiresIn,
    this.refreshToken,
    this.scope,
  });

  final String accessToken;

  final String? tokenType;

  final int? expiresIn;

  final String? refreshToken;

  final String? scope;
}

enum AuthenticationStatus { initial, unauthenticated, authenticated }
