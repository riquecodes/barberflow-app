class AppointmentModelDTO {
  final String date;
  final String time;
  final String? serviceName;
  final double servicePrice;

  AppointmentModelDTO({
    required this.date,
    required this.time,
    this.serviceName,
    required this.servicePrice,
  });

  factory AppointmentModelDTO.fromJson(Map<String, dynamic> json) =>
      AppointmentModelDTO(
        date: json['date'],
        time: json['time'],
        serviceName: json['serviceName'],
        servicePrice: (json['servicePrice'] as num).toDouble(),
      );
}

class CreateAppointmentDTO {
  final int userId;
  final int serviceId;
  final String date;
  final String time;

  CreateAppointmentDTO({
    required this.userId,
    required this.serviceId,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'serviceId': serviceId,
    'date': date,
    'time': time,
  };
}