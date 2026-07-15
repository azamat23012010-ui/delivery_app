import 'package:delivery_app/src/core/utils/either.dart';
import 'package:delivery_app/src/core/utils/failure.dart';
import 'package:delivery_app/src/features/history/data/model/history_model.dart';
import 'package:delivery_app/src/features/history/domain/repository/history_repository.dart';
import 'package:delivery_app/src/features/history/domain/usecase/create_history_usecase.dart';
import 'package:delivery_app/src/features/history/domain/usecase/get_history_usecase.dart';
import 'package:delivery_app/src/features/history/domain/usecase/update_history_status_usecase.dart';
import 'package:delivery_app/src/features/history/presentation/cubit/history_cubit.dart';
import 'package:delivery_app/src/features/history/presentation/cubit/history_state.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeHistoryRepository implements HistoryRepository {
  @override
  Future<Either<Failure, List<HistoryModel>>> getHistory() async {
    return Right([
      const HistoryModel(
        id: "1",
        status: "In Transit",
        from: "User Location",
        to: "Tashkent",
        createdAt: "2026-07-15T12:00:00Z",
      )
    ]);
  }

  @override
  Future<Either<Failure, HistoryModel>> createHistory({
    required String status,
    required String from,
    required String to,
  }) async {
    return Right(HistoryModel(
      id: "2",
      status: status,
      from: from,
      to: to,
      createdAt: "2026-07-15T12:05:00Z",
    ));
  }

  @override
  Future<Either<Failure, HistoryModel>> updateHistoryStatus({
    required String id,
    required String status,
  }) async {
    return Right(HistoryModel(
      id: id,
      status: status,
      from: "User Location",
      to: "Tashkent",
      createdAt: "2026-07-15T12:00:00Z",
    ));
  }
}

void main() {
  late HistoryCubit cubit;
  late GetHistoryUseCase getHistoryUseCase;
  late CreateHistoryUseCase createHistoryUseCase;
  late UpdateHistoryStatusUseCase updateHistoryStatusUseCase;
  late FakeHistoryRepository fakeRepository;

  setUp(() {
    fakeRepository = FakeHistoryRepository();
    getHistoryUseCase = GetHistoryUseCase(repository: fakeRepository);
    createHistoryUseCase = CreateHistoryUseCase(repository: fakeRepository);
    updateHistoryStatusUseCase = UpdateHistoryStatusUseCase(repository: fakeRepository);
    cubit = HistoryCubit(
      getHistoryUseCase: getHistoryUseCase,
      createHistoryUseCase: createHistoryUseCase,
      updateHistoryStatusUseCase: updateHistoryStatusUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  test('initial state should be HistoryState with initial status', () {
    expect(cubit.state.status, HistoryStatus.initial);
    expect(cubit.state.historyList, isEmpty);
  });

  test('getHistory should emit success state with history list', () async {
    await cubit.getHistory();
    expect(cubit.state.status, HistoryStatus.success);
    expect(cubit.state.historyList.length, 1);
    expect(cubit.state.historyList.first.id, "1");
  });

  test('createHistory should call usecase and reload history', () async {
    final result = await cubit.createHistory(
      status: "In Transit",
      from: "User Location",
      to: "Samarqand",
    );
    expect(result, isNotNull);
    expect(result!.id, "2");
    expect(result.status, "In Transit");
  });
}
