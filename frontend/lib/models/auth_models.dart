class AuthResponseDTO {
  final String token;

  AuthResponseDTO({required this.token});

  factory AuthResponseDTO.fromJson(Map<String, dynamic> json) =>
      AuthResponseDTO(token: json['token']);
}

class UserResponseDTO {
  final int userId;
  final String name;
  final String email;
  final String celphone;
  final String role;
  final AuthResponseDTO auth;

  UserResponseDTO({
    required this.userId,
    required this.name,
    required this.email,
    required this.celphone,
    required this.role,
    required this.auth,
  });

  factory UserResponseDTO.fromJson(Map<String, dynamic> json) =>
      UserResponseDTO(
        userId: json['userId'],
        name: json['name'],
        email: json['email'],
        celphone: json['celphone'] ?? '',
        role: json['role'],
        auth: AuthResponseDTO.fromJson(json['auth']),
      );
}