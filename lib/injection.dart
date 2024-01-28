import 'package:InOut/core/utils/dio_provider.dart';
import 'package:InOut/data/datasources/auth_remote_data_source.dart';
import 'package:InOut/data/datasources/remote/auth_remote_data_source_impl.dart';
import 'package:InOut/data/repositories/auth_repository_impl.dart';
import 'package:InOut/domain/repository/auth_repository.dart';
import 'package:InOut/domain/use_cases/register_user_usecase.dart';
import 'package:InOut/presentation/bloc/register_screen/register_screen_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

final inject = GetIt.instance;

setup() async {
  try {
    // env
    print("Setting up env...");
    await dotenv.load(fileName: ".env");

    // service
    print("Setting up service...");
    inject.registerSingleton<DioProvider>(DioProvider());

    // data source
    print("Setting up data source...");
    inject.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(),
    );

    // repository
    print("Setting up repo...");
    inject.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(inject()),
    );

    // use case
    print("Setting up use case...");
    inject.registerLazySingleton(
      () => RegisterUserUseCase(inject()),
    );

    // bloc
    print("Setting up bloc...");
    inject.registerFactory(
      () => RegisterScreenBloc(registerUserUseCase: inject()),
    );
  } catch (e) {
    print("Error setup: $e");
  }
}
