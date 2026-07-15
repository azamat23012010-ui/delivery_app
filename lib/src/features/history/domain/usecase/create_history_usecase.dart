import 'package:delivery_app/src/core/utils/either.dart';
import 'package:delivery_app/src/core/utils/failure.dart';
import 'package:delivery_app/src/core/utils/usecase.dart';
import 'package:delivery_app/src/features/history/data/model/history_model.dart';
import 'package:delivery_app/src/features/history/domain/repository/history_repository.dart';
import 'package:equatable/equatable.dart';

class CreateHistoryParams extends Equatable {
  final String status;
  final String from;
  final String to;

  const CreateHistoryParams({
    required this.status,
    required this.from,
    required this.to,
  });

  @override
  List<Object?> get props => [status, from, to];
}

class CreateHistoryUseCase extends UseCase<HistoryModel, CreateHistoryParams> {
  final HistoryRepository repository;

  CreateHistoryUseCase({required this.repository});

  @override
  Future<Either<Failure, HistoryModel>> call(CreateHistoryParams params) {
    return repository.createHistory(
      status: params.status,
      from: params.from,
      to: params.to,
    );
  }
}
