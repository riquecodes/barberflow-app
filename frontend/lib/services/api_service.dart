// lib/services/api_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';

class ApiService {
  Future<dynamic> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/$endpoint'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro: ${response.statusCode}');
    }
  }
}