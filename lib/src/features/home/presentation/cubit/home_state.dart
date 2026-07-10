import 'package:delivery_app/src/features/home/data/model/service_model.dart';

class HomeState {
  final HomeStatus status;
  final List<ServiceModel> shaharlar;
  final String? errorMessage;

  HomeState(
      {this.shaharlar = const [], this.status = HomeStatus.initial, this.errorMessage});
}

enum HomeStatus { initial, loading, error, success }