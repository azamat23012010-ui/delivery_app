import 'package:delivery_app/src/core/utils/either.dart';
import 'package:delivery_app/src/core/utils/failure.dart';
import 'package:delivery_app/src/features/home/data/model/service_model.dart';


abstract class HomeRepository {
  Future<Either<Failure, List<ServiceModel>>> getServiceLocations();
}
// ! Ota class function body ushamidi