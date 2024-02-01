import 'package:InOut/core/resources/data_state.dart';
import 'package:InOut/domain/use_cases/get_barang_usecase.dart';
import 'package:InOut/presentation/bloc/dashboard_screen/dashboard_screen_event.dart';
import 'package:InOut/presentation/bloc/dashboard_screen/dashboard_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreenBloc
    extends Bloc<DashboardScreenEvent, DashboardScreenState> {
  final GetBarangUseCase getBarangUseCase;

  DashboardScreenBloc({
    required this.getBarangUseCase,
  }) : super(DashboardInitial()) {
    on<FetchBarang>((event, emit) async {
      emit(DashboardLoading());

      DataState dataState = await getBarangUseCase(event.params);

      if (dataState is DataSuccess) {
        emit(DashboardLoaded(dataState.data));
      }

      if (dataState is DataFailed) {
        emit(DashboardError(dataState.error!));
      }
    });
  }
}
