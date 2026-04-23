import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../services/auth_service.dart';
import '../models/service_model.dart';
import '../utils/api_error.dart';

class ServicesService {
  final String _base = '${ApiConfig.baseUrl}/barber/services';
  final _auth = AuthService();

  Future<Map<String, String>> _authHeaders() async {
    final token = await _auth.getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<ServiceModel>> getAllServices() async {
    final response = await http.get(
      Uri.parse(_base),
      headers: await _authHeaders(),
    );
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => ServiceModel.fromJson(e)).toList();
    }
    throw Exception(ApiError.parse(response));
  }

  Future<ServiceModel> getServiceById(int id) async {
    final response = await http.get(
      Uri.parse('$_base/$id'),
      headers: await _authHeaders(),
    );
    if (response.statusCode == 200) {
      return ServiceModel.fromJson(jsonDecode(response.body));
    }
    throw Exception(ApiError.parse(response));
  }

  Future<ServiceModel> createService(ServiceModelDTO dto) async {
    final response = await http.post(
      Uri.parse(_base),
      headers: await _authHeaders(),
      body: jsonEncode(dto.toJson()),
    );
    if (response.statusCode == 201) {
      return ServiceModel.fromJson(jsonDecode(response.body));
    }
    throw Exception(ApiError.parse(response));
  }

  Future<ServiceModel> updateService(int id, ServiceModelDTO dto) async {
    final response = await http.put(
      Uri.parse('$_base/$id'),
      headers: await _authHeaders(),
      body: jsonEncode(dto.toJson()),
    );
    if (response.statusCode == 201) {
      return ServiceModel.fromJson(jsonDecode(response.body));
    }
    throw Exception(ApiError.parse(response));
  }
}