import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../services/auth_service.dart';
import '../models/auth_models.dart';

class UserService {
  final String _base = '${ApiConfig.baseUrl}/barber/users';
  final _auth = AuthService();

  Future<Map<String, String>> _authHeaders() async {
    final token = await _auth.getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // PUT /barber/users/profile/{id}
  Future<UserResponseDTO> updateProfile({
    required int id,
    required String name,
    required String email,
    String? celphone,
  }) async {
    final response = await http.put(
      Uri.parse('$_base/profile/$id'),
      headers: await _authHeaders(),
      body: jsonEncode({
        'name': name,
        'email': email,
        'celphone': celphone ?? '',
        'role': 'client',
      }),
    );

    if (response.statusCode == 200) {
      return UserResponseDTO.fromJson(jsonDecode(response.body));
    }
    throw Exception('Erro ao atualizar perfil: ${response.statusCode}');
  }
}