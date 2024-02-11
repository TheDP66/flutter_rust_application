import 'package:InOut/core/resources/data_state.dart';
import 'package:InOut/domain/use_cases/logout_user_usecase.dart';
import 'package:InOut/domain/use_cases/me_user_usecase.dart';
import 'package:InOut/domain/use_cases/update_user_usecase.dart';
import 'package:InOut/presentation/bloc/account_screen/account_screen_event.dart';
import 'package:InOut/presentation/bloc/account_screen/account_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScreenBloc extends Bloc<AccountScreenEvent, AccountScreenState> {
  final LogoutUserUseCase logoutUserUseCase;
  final MeUserUseCase meUserUseCase;
  final UpdateUserUseCase updateUserUseCase;

  AccountScreenBloc({
    required this.logoutUserUseCase,
    required this.meUserUseCase,
    required this.updateUserUseCase,
  }) : super(AccountInitial()) {
    on<LogoutUser>((event, emit) async {
      emit(LogoutLoading());

      DataState dataState = await logoutUserUseCase(());

      if (dataState is DataSuccess) {
        emit(LogoutLoaded(dataState.data));
      }

      if (dataState is DataFailed) {
        emit(LogoutError(dataState.error!));
      }
    });

    on<FetchMeUser>((event, emit) async {
      emit(AccountLoading());

      DataState dataState = await meUserUseCase(());

      if (dataState is DataSuccess) {
        emit(AccountLoaded(dataState.data));
      }

      if (dataState is DataFailed) {
        emit(AccountError(dataState.error!));
      }
    });

    on<UpdateUser>((event, emit) async {
      emit(UpdateUserLoading());

      DataState dataState = await updateUserUseCase(event.params);

      if (dataState is DataSuccess) {
        // await Future.delayed(Duration(seconds: 2));

        emit(UpdateUserLoaded(dataState.data));
      }

      if (dataState is DataFailed) {
        emit(UpdateUserError(dataState.error!));
      }
    });
  }
}
