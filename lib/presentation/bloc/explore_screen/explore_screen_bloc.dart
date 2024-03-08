import 'package:InOut/core/resources/data_state.dart';
import 'package:InOut/domain/use_cases/me_user_usecase.dart';
import 'package:InOut/domain/use_cases/sync_barang_usecase.dart';
import 'package:InOut/presentation/bloc/explore_screen/explore_screen_event.dart';
import 'package:InOut/presentation/bloc/explore_screen/explore_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreScreenBloc extends Bloc<ExploreScreenEvent, ExploreScreenState> {
  final SyncBarangUseCase syncBarangUseCase;
  final MeUserUseCase meUserUseCase;

  ExploreScreenBloc({
    required this.syncBarangUseCase,
    required this.meUserUseCase,
  }) : super(ExploreInitial()) {
    on<SyncBarang>((event, emit) async {
      emit(SyncLoading());

      DataState dataState = await syncBarangUseCase(event.params);

      if (dataState is DataSuccess) {
        emit(SyncLoaded(dataState.data));
      }

      if (dataState is DataFailed) {
        emit(SyncError(dataState.error!));
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
