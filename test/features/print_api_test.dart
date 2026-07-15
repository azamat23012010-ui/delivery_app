import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Fetch and print both APIs data', () async {
    final dio = Dio();
    try {
      final res1 = await dio.get('https://6a4b93d8f5eab0bb6b630ac9.mockapi.io/api/v1/services');
      print('Original API Response: ${res1.data}');
    } catch (e) {
      print('Original API error: $e');
    }
    
    try {
      final res2 = await dio.get('https://6a54cf95e49d9eb2cc552bd5.mockapi.io/services');
      print('New API Response: ${res2.data}');
    } catch (e) {
      print('New API error: $e');
    }
  });
}
