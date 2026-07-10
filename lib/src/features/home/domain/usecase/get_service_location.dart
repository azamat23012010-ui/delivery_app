import 'package:delivery_app/src/core/utils/either.dart';
import 'package:delivery_app/src/core/utils/failure.dart';
import 'package:delivery_app/src/core/utils/usecase.dart';
import 'package:delivery_app/src/features/home/data/model/service_model.dart';
import 'package:delivery_app/src/features/home/domain/repository/home_repository.dart';

class GetServiceLocationUsecase extends UseCase<List<ServiceModel>, NoParams> {

  final HomeRepository repository;

  GetServiceLocationUsecase({required this.repository});

  @override
  Future<Either<Failure, List<ServiceModel>>> call(NoParams params) {
    return repository.getServiceLocations();
  }
}