
import 'package:bloc/bloc.dart';
import 'package:delivery_app/src/core/utils/usecase.dart';
import 'package:delivery_app/src/features/home/data/model/service_model.dart';
import 'package:delivery_app/src/features/home/domain/usecase/get_service_location.dart';
import 'package:delivery_app/src/features/home/presentation/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetServiceLocationUsecase usecase;
  HomeCubit({required this.usecase}) : super(HomeState());

  Future<void> getServices() async {
    emit(state.copyWith(status: HomeStatus.loading));
    final result = await usecase.call(NoParams());

    if (result.isRight) {
      emit(state.copyWith(status: HomeStatus.success, shaharlar: result.right));
    } else {
      emit(state.copyWith(
          status: HomeStatus.error, errorMessage: result.left.message));
    }
  }

  void searchServices(String query) {
    if (query.trim().isEmpty) {
      emit(state.copyWith(
        filteredServices: const [],
        searchQuery: query,
      ));
      return;
    }

    final queryLower = query.toLowerCase().trim();
    final startsWithList = state.shaharlar.where((service) {
      return service.serviceName.toLowerCase().startsWith(queryLower);
    }).toList();

    final containsList = state.shaharlar.where((service) {
      final nameLower = service.serviceName.toLowerCase();
      return !nameLower.startsWith(queryLower) && nameLower.contains(queryLower);
    }).toList();

    emit(state.copyWith(
      filteredServices: [...startsWithList, ...containsList],
      searchQuery: query,
    ));
  }

  void selectService(ServiceModel service) {
    emit(state.copyWith(
      selectedService: () => service,
      searchQuery: service.serviceName,
      filteredServices: const [],
    ));
  }

  void clearSearch() {
    emit(state.copyWith(
      selectedService: () => null,
      searchQuery: '',
      filteredServices: const [],
    ));
  }
}