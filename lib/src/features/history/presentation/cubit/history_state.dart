import 'package:delivery_app/src/features/history/data/model/history_model.dart';

enum HistoryStatus { initial, loading, success, error }

class HistoryState {
  final HistoryStatus status;
  final List<HistoryModel> historyList;
  final String? errorMessage;

  HistoryState({
    this.status = HistoryStatus.initial,
    this.historyList = const [],
    this.errorMessage,
  });

  HistoryState copyWith({
    HistoryStatus? status,
    List<HistoryModel>? historyList,
    String? errorMessage,
  }) {
    return HistoryState(
      status: status ?? this.status,
      historyList: historyList ?? this.historyList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
