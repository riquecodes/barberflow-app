import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config/api_config.dart';
import '../models/auth_response_dto.dart';
import '../models/user_response_dto.dart';

class AuthService {
  final String _base = '${ApiConfig.baseUrl}/barber/auth';
  final _storage = const FlutterSecureStorage();

  // POST /barber/auth/login
  Future<AuthResponseDTO> login(String email, String password) async {
    final uri = Uri.parse('$_base/login');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final auth = AuthResponseDTO.fromJson(data);

      // Salva o token seguro no dispositivo
      await _storage.write(key: 'jwt_token', value: auth.token);

      return auth;
    } else {
      throw Exception('Login falhou: ${response.statusCode}');
    }
  }

  // POST /barber/auth/register
  Future<UserResponseDTO> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final uri = Uri.parse('$_base/register');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return UserResponseDTO.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Registro falhou: ${response.statusCode}');
    }
  }

  // POST /barber/auth/change-password  (requer token)
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final token = await _storage.read(key: 'jwt_token');
    if (token == null) throw Exception('Usuário não autenticado');

    final uri = Uri.parse('$_base/change-password');

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao alterar senha: ${response.statusCode}');
    }
  }

  // Utilitário — recupera o token salvo
  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  // Logout — limpa o token
  Future<void> logout() async {
    await _storage.delete(key: 'jwt_token');
  }
}