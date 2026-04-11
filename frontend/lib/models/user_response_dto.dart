import 'auth_response_dto.dart';

class UserResponseDTO {
  final String userId;
  final String name;
  final String? celphone;
  final String? email;
  final String? role;
  final AuthResponseDTO? auth; // make nullable

  UserResponseDTO({
    required this.userId,
    required this.name,
    this.celphone,
    this.email,
    this.role,
    this.auth,
  });

  factory UserResponseDTO.fromJson(Map<String, dynamic> json) {
    return UserResponseDTO(
      userId: json['userId'],
      name: json['name'],
      celphone: json['celphone'],
      email: json['email'],
      role: json['role'],
      auth: json['auth'] != null ? AuthResponseDTO.fromJson(json['auth']) : null,
    );
  }
}