import 'package:delivery_app/src/core/utils/either.dart';
import 'package:delivery_app/src/core/utils/failure.dart';
import 'package:delivery_app/src/core/utils/usecase.dart';
import 'package:delivery_app/src/features/history/data/model/history_model.dart';
import 'package:delivery_app/src/features/history/domain/repository/history_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateHistoryStatusParams extends Equatable {
  final String id;
  final String status;

  const UpdateHistoryStatusParams({
    required this.id,
    required this.status,
  });

  @override
  List<Object?> get props => [id, status];
}

class UpdateHistoryStatusUseCase extends UseCase<HistoryModel, UpdateHistoryStatusParams> {
  final HistoryRepository repository;

  UpdateHistoryStatusUseCase({required this.repository});

  @override
  Future<Either<Failure, HistoryModel>> call(UpdateHistoryStatusParams params) {
    return repository.updateHistoryStatus(
      id: params.id,
      status: params.status,
    );
  }
}
