import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../services/auth_service.dart';
import '../utils/api_error.dart';

class RatingService {
  final String _base = '${ApiConfig.baseUrl}/barber/rating';
  final _auth = AuthService();

  Future<Map<String, String>> _authHeaders() async {
    final token = await _auth.getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<void> createRating({
    required int stars,
    String? comment,
    int? serviceId,
  }) async {
    final response = await http.post(
      Uri.parse(_base),
      headers: await _authHeaders(),
      body: jsonEncode({
        'estrelas': stars,
        'comentario': comment,
        'serviceId': serviceId,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(ApiError.parse(response));
    }
  }
}
