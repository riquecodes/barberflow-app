class ServiceModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final int duration;

  ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
    id: json['id'],
    name: json['name'],
    description: json['description'] ?? '',
    price: (json['price'] as num).toDouble(),
    duration: json['duration'],
  );
}

class ServiceModelDTO {
  final String name;
  final String description;
  final double price;
  final int duration;

  ServiceModelDTO({
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'price': price,
    'duration': duration,
  };
}