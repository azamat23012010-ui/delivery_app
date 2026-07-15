import 'package:bloc/bloc.dart';
import 'package:delivery_app/src/core/utils/usecase.dart';
import 'package:delivery_app/src/features/history/data/model/history_model.dart';
import 'package:delivery_app/src/features/history/domain/usecase/create_history_usecase.dart';
import 'package:delivery_app/src/features/history/domain/usecase/get_history_usecase.dart';
import 'package:delivery_app/src/features/history/domain/usecase/update_history_status_usecase.dart';
import 'package:delivery_app/src/features/history/presentation/cubit/history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final GetHistoryUseCase getHistoryUseCase;
  final CreateHistoryUseCase createHistoryUseCase;
  final UpdateHistoryStatusUseCase updateHistoryStatusUseCase;

  HistoryCubit({
    required this.getHistoryUseCase,
    required this.createHistoryUseCase,
    required this.updateHistoryStatusUseCase,
  }) : super(HistoryState());

  Future<void> getHistory() async {
    emit(state.copyWith(status: HistoryStatus.loading));
    final result = await getHistoryUseCase.call(NoParams());

    if (result.isRight) {
      final list = List<HistoryModel>.from(result.right);
      // Sort history items so latest added are on top.
      // Since mockapi gives auto-incrementing integer IDs or timestamps, sorting by id or createdAt is good.
      try {
        list.sort((a, b) {
          final aId = int.tryParse(a.id);
          final bId = int.tryParse(b.id);
          if (aId != null && bId != null) {
            return bId.compareTo(aId);
          }
          return b.id.compareTo(a.id);
        });
      } catch (_) {}
      emit(state.copyWith(status: HistoryStatus.success, historyList: list));
    } else {
      emit(state.copyWith(status: HistoryStatus.error, errorMessage: result.left.message));
    }
  }

  Future<HistoryModel?> createHistory({
    required String status,
    required String from,
    required String to,
  }) async {
    final result = await createHistoryUseCase.call(
      CreateHistoryParams(status: status, from: from, to: to),
    );

    if (result.isRight) {
      await getHistory();
      return result.right;
    }
    return null;
  }

  Future<void> updateHistoryStatus({
    required String id,
    required String status,
  }) async {
    final result = await updateHistoryStatusUseCase.call(
      UpdateHistoryStatusParams(id: id, status: status),
    );

    if (result.isRight) {
      await getHistory();
    }
  }
}
