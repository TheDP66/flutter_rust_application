import 'package:bloc/bloc.dart';
import 'package:flutter_rust_application/core/resources/data_state.dart';
import 'package:flutter_rust_application/domain/use_cases/register_user_usecase.dart';
import 'package:flutter_rust_application/presentation/bloc/register_user/register_user_event.dart';
import 'package:flutter_rust_application/presentation/bloc/register_user/register_user_state.dart';

class RegisterUserBloc extends Bloc<RegisterUserEvent, RegisterUserState> {
  final RegisterUserUseCase registerUserUseCase;

  RegisterUserBloc({
    required this.registerUserUseCase,
  }) : super(RegisterUserInintial()) {
    on<FetchRegisterUser>((event, emit) async {
      emit(RegisterUserLoading());

      DataState dataState = await registerUserUseCase(event.params);

      if (dataState is DataSuccess) {
        emit(RegisterUserLoaded(dataState.data));
      }

      if (dataState is DataFailed) {
        emit(RegisterUserError(dataState.error!));
      }
    });
  }
}
