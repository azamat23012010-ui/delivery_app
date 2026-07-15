import 'package:delivery_app/src/features/home/data/model/service_model.dart';

enum HomeStatus { initial, loading, error, success }

class HomeState {
  final HomeStatus status;
  final List<ServiceModel> shaharlar;
  final List<ServiceModel> filteredServices;
  final ServiceModel? selectedService;
  final String searchQuery;
  final String? errorMessage;

  HomeState({
    this.status = HomeStatus.initial,
    this.shaharlar = const [],
    this.filteredServices = const [],
    this.selectedService,
    this.searchQuery = '',
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<ServiceModel>? shaharlar,
    List<ServiceModel>? filteredServices,
    ServiceModel? Function()? selectedService,
    String? searchQuery,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      shaharlar: shaharlar ?? this.shaharlar,
      filteredServices: filteredServices ?? this.filteredServices,
      selectedService: selectedService != null ? selectedService() : this.selectedService,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}