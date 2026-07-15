import 'package:delivery_app/src/core/utils/either.dart';
import 'package:delivery_app/src/core/utils/failure.dart';
import 'package:delivery_app/src/features/history/data/model/history_model.dart';
import 'package:delivery_app/src/features/history/data/source/history_remote_data_source.dart';
import 'package:delivery_app/src/features/history/domain/repository/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryRemoteDataSource remoteDataSource;

  HistoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<HistoryModel>>> getHistory() {
    return remoteDataSource.getHistory();
  }

  @override
  Future<Either<Failure, HistoryModel>> createHistory({
    required String status,
    required String from,
    required String to,
  }) {
    return remoteDataSource.createHistory(status: status, from: from, to: to);
  }

  @override
  Future<Either<Failure, HistoryModel>> updateHistoryStatus({
    required String id,
    required String status,
  }) {
    return remoteDataSource.updateHistoryStatus(id: id, status: status);
  }
}
