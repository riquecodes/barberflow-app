import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../services/auth_service.dart';
import '../models/appointment_model.dart';

class AppointmentService {
  final String _base = '${ApiConfig.baseUrl}/barber/agendamentos'; // ← plural corrigido
  final _auth = AuthService();

  Future<Map<String, String>> _authHeaders() async {
    final token = await _auth.getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // GET /barber/agendamentos/disponiveis?date=2025-04-19
  Future<List<String>> getAvailableTimes(DateTime date) async {
    final formatted =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    final uri = Uri.parse('$_base/disponiveis?date=$formatted');

    final response = await http.get(uri, headers: await _authHeaders());

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.cast<String>();
    }
    throw Exception('Erro ao buscar horários: ${response.statusCode}');
  }

  // GET /barber/agendamentos/meus
  Future<List<AppointmentModelDTO>> getMyAppointments() async {
    final response = await http.get(
      Uri.parse('$_base/meus'),
      headers: await _authHeaders(),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => AppointmentModelDTO.fromJson(e)).toList();
    }
    throw Exception('Erro ao buscar agendamentos: ${response.statusCode}');
  }

  // POST /barber/agendamentos
  Future<void> createAppointment(CreateAppointmentDTO dto) async {
    final response = await http.post(
      Uri.parse(_base),
      headers: await _authHeaders(),
      body: jsonEncode(dto.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao criar agendamento: ${response.statusCode}');
    }
  }

  // DELETE /barber/agendamentos/{id}
  Future<void> cancelAppointment(int id) async {
    final response = await http.delete(
      Uri.parse('$_base/$id'),
      headers: await _authHeaders(),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao cancelar agendamento: ${response.statusCode}');
    }
  }
}