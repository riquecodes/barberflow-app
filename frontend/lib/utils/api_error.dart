import 'dart:convert';

class ApiError {
  static String parse(dynamic response) {
    try {
      final body = jsonDecode(response.body);
      if (body is Map && body.containsKey('error')) {
        return body['error'];
      }
      return 'Erro inesperado. Tente novamente.';
    } catch (_) {
      return 'Erro inesperado. Tente novamente.';
    }
  }
}