import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  final String code;
  final String errorCode;

  const Failure({this.message = '', this.code = '', this.errorCode = ''});

  @override
  List<Object> get props => [message, errorCode, code];
}

class ServerFailure extends Failure {
  final num statusCode;
  final String errorMessage;

  ServerFailure(
    String s, {
    this.errorMessage = '',
    this.statusCode = 0,
    super.errorCode = '',
  }) : super(message: errorMessage, code: statusCode.toString());
}

class DioFailure extends Failure {
  final String? errorMessage;
  final bool? exists;

  const DioFailure({this.errorMessage, this.exists, super.errorCode})
      : super(message: errorMessage ?? '');
}

class ParsingFailure extends Failure {
  final String? errorMessage;

  const ParsingFailure({this.errorMessage = ''})
      : super(message: errorMessage ?? '');
}

class IOFailure extends Failure {
  final String errorMessage;
  const IOFailure({this.errorMessage = ''}) : super(message: errorMessage);
}

class TimeOutFailure extends Failure {
  const TimeOutFailure({super.message});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

class QueryFailure extends Failure {
  const QueryFailure({required super.message});
}

class SocketFailure extends Failure {
  const SocketFailure({super.message});
}