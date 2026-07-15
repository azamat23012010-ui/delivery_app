import 'package:delivery_app/src/core/utils/either.dart';
import 'package:delivery_app/src/core/utils/failure.dart';
import 'package:delivery_app/src/core/utils/usecase.dart';
import 'package:delivery_app/src/features/history/data/model/history_model.dart';
import 'package:delivery_app/src/features/history/domain/repository/history_repository.dart';

class GetHistoryUseCase extends UseCase<List<HistoryModel>, NoParams> {
  final HistoryRepository repository;

  GetHistoryUseCase({required this.repository});

  @override
  Future<Either<Failure, List<HistoryModel>>> call(NoParams params) {
    return repository.getHistory();
  }
}
