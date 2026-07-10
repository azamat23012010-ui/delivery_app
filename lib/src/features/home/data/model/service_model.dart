class ServiceModel {
  String name;
  double lat;
  double long;
  String id;

  ServiceModel({
    required this.name,
    required this.lat,
    required this.long,
    required this.id,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        name: json["name"] ?? '',
        lat: json["lat"]?.toDouble() ?? 0.0,
        long: json["long"]?.toDouble() ?? 0.0,
        id: json["id"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lat": lat,
        "long": long,
        "id": id,
      };
}