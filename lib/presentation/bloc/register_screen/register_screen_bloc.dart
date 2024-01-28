import 'package:InOut/core/resources/data_state.dart';
import 'package:InOut/domain/use_cases/register_user_usecase.dart';
import 'package:InOut/presentation/bloc/register_screen/register_screen_event.dart';
import 'package:InOut/presentation/bloc/register_screen/register_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreenBloc
    extends Bloc<RegisterScreenEvent, RegisterScreenState> {
  final RegisterUserUseCase registerUserUseCase;

  RegisterScreenBloc({
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
