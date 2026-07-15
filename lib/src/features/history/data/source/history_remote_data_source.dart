import 'package:delivery_app/src/core/utils/either.dart';
import 'package:delivery_app/src/core/utils/failure.dart';
import 'package:delivery_app/src/features/history/data/model/history_model.dart';

abstract class HistoryRemoteDataSource {
  Future<Either<Failure, List<HistoryModel>>> getHistory();
  Future<Either<Failure, HistoryModel>> createHistory({
    required String status,
    required String from,
    required String to,
  });
  Future<Either<Failure, HistoryModel>> updateHistoryStatus({
    required String id,
    required String status,
  });
}
