import 'package:delivery_app/src/features/history/domain/entities/history_entity.dart';

class HistoryModel extends HistoryEntity {
  const HistoryModel({
    required super.id,
    required super.status,
    required super.from,
    required super.to,
    required super.createdAt,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      HistoryModel(
        id: json["id"]?.toString() ?? '',
        status: json["status"]?.toString() ?? '',
        from: json["from"]?.toString() ?? '',
        to: json["to"]?.toString() ?? '',
        createdAt: json["createdAt"]?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "from": from,
        "to": to,
        "createdAt": createdAt,
      };
}
