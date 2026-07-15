import 'package:delivery_app/src/features/history/data/model/history_model.dart';
import 'package:delivery_app/src/features/history/domain/entities/history_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tHistoryModel = HistoryModel(
    id: "1",
    status: "In Transit",
    from: "User Location",
    to: "Tashkent",
    createdAt: "2026-07-15T12:54:35.123Z",
  );

  test('should be a subclass of HistoryEntity', () async {
    expect(tHistoryModel, isA<HistoryEntity>());
  });

  group('fromJson', () {
    test('should return a valid model when JSON is provided', () async {
      final Map<String, dynamic> jsonMap = {
        "id": "1",
        "status": "In Transit",
        "from": "User Location",
        "to": "Tashkent",
        "createdAt": "2026-07-15T12:54:35.123Z",
      };

      final result = HistoryModel.fromJson(jsonMap);

      expect(result, tHistoryModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      final result = tHistoryModel.toJson();

      final expectedMap = {
        "status": "In Transit",
        "from": "User Location",
        "to": "Tashkent",
        "createdAt": "2026-07-15T12:54:35.123Z",
      };

      expect(result, expectedMap);
    });
  });
}
