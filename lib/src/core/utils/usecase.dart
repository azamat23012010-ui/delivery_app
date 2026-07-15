import 'package:delivery_app/src/core/utils/either.dart';
import 'package:equatable/equatable.dart';

// ignore: avoid_types_as_parameter_names
abstract class UseCase<Type, Params> {
  Future<Either<dynamic, Type>> call(Params params);
}

// ignore: avoid_types_as_parameter_names
abstract class StreamUseCase<Type, Params> {
  Stream<Type> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}