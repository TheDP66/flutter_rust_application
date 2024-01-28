import 'package:InOut/core/resources/data_state.dart';
import 'package:InOut/domain/use_cases/login_user_usecase.dart';
import 'package:InOut/presentation/bloc/login_screen/login_screen_event.dart';
import 'package:InOut/presentation/bloc/login_screen/login_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  final LoginUserUseCase loginUserUseCase;

  LoginScreenBloc({
    required this.loginUserUseCase,
  }) : super(LoginUserInitial()) {
    on<FetchLoginUser>((event, emit) async {
      emit(LoginUserLoading());

      DataState dataState = await loginUserUseCase(event.params);

      if (dataState is DataSuccess) {
        emit(LoginUserLoaded(dataState.data));
      }

      if (dataState is DataFailed) {
        emit(LoginUserError(dataState.error!));
      }
    });
  }
}
