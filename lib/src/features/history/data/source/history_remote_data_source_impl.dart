import 'dart:async';
import 'dart:io';
import 'package:delivery_app/src/core/utils/either.dart';
import 'package:delivery_app/src/core/utils/failure.dart';
import 'package:delivery_app/src/features/history/data/model/history_model.dart';
import 'package:delivery_app/src/features/history/data/source/history_remote_data_source.dart';
import 'package:dio/dio.dart';

class HistoryRemoteDataSourceImpl extends HistoryRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<Either<Failure, List<HistoryModel>>> getHistory() async {
    try {
      final response = await dio.get("https://6a54cf95e49d9eb2cc552bd5.mockapi.io/history");

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        List<HistoryModel> data = (response.data as List)
            .map((map) => HistoryModel.fromJson(map))
            .toList();
        return Right(data);
      } else {
        throw DioException(requestOptions: response.requestOptions);
      }
    } on TimeoutException catch (_) {
      return Left(const TimeOutFailure(message: 'Check your internet please !'));
    } on SocketException catch (_) {
      return Left(const SocketFailure(message: 'Internet yoq !'));
    } on FormatException catch (error) {
      return Left(Failure(message: error.message));
    } on DioException catch (error) {
      return Left(DioFailure(errorMessage: error.message));
    } catch (error) {
      return Left(const Failure(message: 'Xatolik yuzga keldi !'));
    }
  }

  @override
  Future<Either<Failure, HistoryModel>> createHistory({
    required String status,
    required String from,
    required String to,
  }) async {
    try {
      final response = await dio.post(
        "https://6a54cf95e49d9eb2cc552bd5.mockapi.io/history",
        data: {
          "status": status,
          "from": from,
          "to": to,
          "createdAt": DateTime.now().toIso8601String(),
        },
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        final data = HistoryModel.fromJson(response.data);
        return Right(data);
      } else {
        throw DioException(requestOptions: response.requestOptions);
      }
    } on TimeoutException catch (_) {
      return Left(const TimeOutFailure(message: 'Check your internet please !'));
    } on SocketException catch (_) {
      return Left(const SocketFailure(message: 'Internet yoq !'));
    } on FormatException catch (error) {
      return Left(Failure(message: error.message));
    } on DioException catch (error) {
      return Left(DioFailure(errorMessage: error.message));
    } catch (error) {
      return Left(const Failure(message: 'Xatolik yuzga keldi !'));
    }
  }

  @override
  Future<Either<Failure, HistoryModel>> updateHistoryStatus({
    required String id,
    required String status,
  }) async {
    try {
      final response = await dio.put(
        "https://6a54cf95e49d9eb2cc552bd5.mockapi.io/history/$id",
        data: {
          "status": status,
        },
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        final data = HistoryModel.fromJson(response.data);
        return Right(data);
      } else {
        throw DioException(requestOptions: response.requestOptions);
      }
    } on TimeoutException catch (_) {
      return Left(const TimeOutFailure(message: 'Check your internet please !'));
    } on SocketException catch (_) {
      return Left(const SocketFailure(message: 'Internet yoq !'));
    } on FormatException catch (error) {
      return Left(Failure(message: error.message));
    } on DioException catch (error) {
      return Left(DioFailure(errorMessage: error.message));
    } catch (error) {
      return Left(const Failure(message: 'Xatolik yuzga keldi !'));
    }
  }
}
