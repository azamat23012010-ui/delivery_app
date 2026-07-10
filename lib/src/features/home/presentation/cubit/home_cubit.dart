
import 'package:bloc/bloc.dart';
import 'package:delivery_app/src/core/utils/usecase.dart';
import 'package:delivery_app/src/features/home/domain/usecase/get_service_location.dart';
import 'package:delivery_app/src/features/home/presentation/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetServiceLocationUsecase usecase;
  HomeCubit({required this.usecase}) : super(HomeState());

  Future<void> getServices() async {
    emit(HomeState(status: HomeStatus.loading));
    final result = await usecase.call(NoParams());

    if (result.isRight) {
      emit(HomeState(status: HomeStatus.success, shaharlar: result.right));
    } else {
      emit(HomeState(
          status: HomeStatus.error, errorMessage: result.left.message));
    }
  }
}