import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config/api_config.dart';
import '../models/auth_models.dart';
import '../utils/api_error.dart';

class AuthService {
  final String _base = '${ApiConfig.baseUrl}/barber/auth';
  final _storage = const FlutterSecureStorage();

  Future<UserResponseDTO> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_base/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final user = UserResponseDTO.fromJson(jsonDecode(response.body));
      await _storage.write(key: 'jwt_token', value: user.auth.token);
      await _storage.write(key: 'user_role', value: user.role);
      await _storage.write(key: 'user_id', value: user.userId.toString());
      await _storage.write(key: 'user_name', value: user.name);
      return user;
    }
    throw Exception(ApiError.parse(response));
  }

  Future<UserResponseDTO> register({
    required String name,
    required String email,
    required String celphone,
    required String password,
    required String role,
  }) async {
    final response = await http.post(
      Uri.parse('$_base/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'celphone': celphone,
        'password': password,
        'role': role,
      }),
    );

    if (response.statusCode == 200) {
      final user = UserResponseDTO.fromJson(jsonDecode(response.body));
      await _storage.write(key: 'jwt_token', value: user.auth.token);
      await _storage.write(key: 'user_role', value: user.role);
      await _storage.write(key: 'user_id', value: user.userId.toString());
      await _storage.write(key: 'user_name', value: user.name);
      return user;
    }
    throw Exception(ApiError.parse(response));
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final token = await _storage.read(key: 'jwt_token');
    if (token == null) throw Exception('Usuário não autenticado');

    final response = await http.post(
      Uri.parse('$_base/change-password'),
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
      throw Exception(ApiError.parse(response));
    }
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  Future<int?> getUserId() async {
    final id = await _storage.read(key: 'user_id');
    return id != null ? int.parse(id) : null;
  }

  Future<String?> getUserName() async {
    return await _storage.read(key: 'user_name');
  }

  Future<bool> isAdmin() async {
    final role = await _storage.read(key: 'user_role');
    return role == 'admin';
  }

  Future<void> logout() async {
    await _storage.deleteAll();
  }
}