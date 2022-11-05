class AuthException implements Exception {
  final String code;
  final String message;

  AuthException(this.code, this.message);
}

class ApiException implements Exception {
  final String code;
  final String message;

  ApiException(this.code, this.message);
}
