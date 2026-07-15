import 'package:equatable/equatable.dart';

class HistoryEntity extends Equatable {
  final String id;
  final String status;
  final String from;
  final String to;
  final String createdAt;

  const HistoryEntity({
    required this.id,
    required this.status,
    required this.from,
    required this.to,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, status, from, to, createdAt];
}
