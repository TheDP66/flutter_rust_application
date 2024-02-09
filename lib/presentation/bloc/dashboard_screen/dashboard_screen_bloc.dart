import 'package:InOut/core/resources/data_state.dart';
import 'package:InOut/domain/use_cases/get_barang_usecase.dart';
import 'package:InOut/domain/use_cases/me_user_usecase.dart';
import 'package:InOut/presentation/bloc/dashboard_screen/dashboard_screen_event.dart';
import 'package:InOut/presentation/bloc/dashboard_screen/dashboard_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreenBloc
    extends Bloc<DashboardScreenEvent, DashboardScreenState> {
  final GetBarangUseCase getBarangUseCase;
  final MeUserUseCase meUserUseCase;

  DashboardScreenBloc({
    required this.getBarangUseCase,
    required this.meUserUseCase,
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

    on<PrepExportPackage>((event, emit) async {
      emit(ExportPackageLoading());

      DataState dataBarang = await getBarangUseCase(event.params);
      DataState dataUser = await meUserUseCase({});

      if (dataBarang is DataSuccess && dataUser is DataSuccess) {
        emit(ExportPackageLoaded(dataBarang.data, dataUser.data));
      } else {
        emit(
          ExportPackageError(dataBarang.error ?? dataUser.error!),
        );
      }
    });

    on<FetchMeUser>((event, emit) async {
      emit(MeLoading());

      DataState dataState = await meUserUseCase(());

      if (dataState is DataSuccess) {
        emit(MeLoaded(dataState.data));
      }

      if (dataState is DataFailed) {
        emit(MeError(dataState.error!));
      }
    });
  }
}
