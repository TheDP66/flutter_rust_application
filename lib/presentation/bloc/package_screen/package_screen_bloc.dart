import 'package:InOut/core/resources/data_state.dart';
import 'package:InOut/domain/use_cases/insert_barang_usecase.dart';
import 'package:InOut/presentation/bloc/package_screen/package_screen_event.dart';
import 'package:InOut/presentation/bloc/package_screen/package_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PackageScreenBloc extends Bloc<PackageScreenEvent, PackageScreenState> {
  final InsertBarangUseCase insertBarangUseCase;

  PackageScreenBloc({required this.insertBarangUseCase})
      : super(PackageInitial()) {
    on<InsertBarang>((event, emit) async {
      emit(PackageLoading());

      DataState dataState = await insertBarangUseCase(event.params);

      if (dataState is DataSuccess) {
        emit(PackageLoaded(dataState.data));
      }

      if (dataState is DataFailed) {
        emit(PackageError(dataState.error!));
      }
    });
  }
}
