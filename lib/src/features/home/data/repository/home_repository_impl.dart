import 'package:delivery_app/src/core/utils/either.dart';
import 'package:delivery_app/src/core/utils/failure.dart';
import 'package:delivery_app/src/features/home/data/model/service_model.dart';
import 'package:delivery_app/src/features/home/data/source/home_data_source.dart';
import 'package:delivery_app/src/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeDataSource source;

  HomeRepositoryImpl({required this.source});

  @override
  Future<Either<Failure, List<ServiceModel>>> getServiceLocations() async {
    final result = await source.getServiceLocations();

    if (result.isRight) {
      return Right(result.right);
    } else {
      return Left(result.left);
    }
  }
}