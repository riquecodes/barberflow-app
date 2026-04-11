class AuthResponseDTO {
  final String token;

  AuthResponseDTO({required this.token});

  factory AuthResponseDTO.fromJson(Map<String, dynamic> json) {
    return AuthResponseDTO(token: json['token']);
  }
}