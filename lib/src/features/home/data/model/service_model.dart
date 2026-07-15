class ServiceModel {
  final String serviceName;
  final double latitude;
  final double longitude;
  final String id;

  ServiceModel({
    required this.serviceName,
    required this.latitude,
    required this.longitude,
    required this.id,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      ServiceModel(
        serviceName: json["serviceName"] ?? '',
        // The API returns longitude value under the key "latitude"
        // and latitude value under the key "longitude".
        // We parse them into their correct physical representation fields here.
        latitude: (json["longitude"] as num?)?.toDouble() ?? 0.0,
        longitude: (json["latitude"] as num?)?.toDouble() ?? 0.0,
        id: json["id"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "serviceName": serviceName,
        "latitude": longitude, // Write back to the API schema
        "longitude": latitude,
        "id": id,
      };
}