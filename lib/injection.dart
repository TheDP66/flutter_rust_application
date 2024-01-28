import 'package:InOut/core/services/dio_provider.dart';
import 'package:InOut/data/datasources/auth_remote_data_source.dart';
import 'package:InOut/data/datasources/remote/auth_remote_data_source_impl.dart';
import 'package:InOut/data/repositories/auth_repository_impl.dart';
import 'package:InOut/domain/repository/auth_repository.dart';
import 'package:InOut/domain/use_cases/login_user_usecase.dart';
import 'package:InOut/domain/use_cases/register_user_usecase.dart';
import 'package:InOut/presentation/bloc/login_screen/login_screen_bloc.dart';
import 'package:InOut/presentation/bloc/register_screen/register_screen_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

final inject = GetIt.instance;

setup() async {
  try {
    // env
    await dotenv.load(fileName: ".env");

    // service
    inject.registerSingleton<DioProvider>(DioProvider());

    // data source
    inject.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(),
    );

    // repository
    inject.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(inject()),
    );

    // use case
    inject.registerLazySingleton(
      () => RegisterUserUseCase(inject()),
    );
    inject.registerLazySingleton(
      () => LoginUserUseCase(inject()),
    );

    // bloc
    inject.registerFactory(
      () => RegisterScreenBloc(
        registerUserUseCase: inject(),
        loginUserUseCase: inject(),
      ),
    );
    inject.registerFactory(
      () => LoginScreenBloc(
        loginUserUseCase: inject(),
      ),
    );
  } catch (e) {
    print("Injection error: $e");
  }
}
