import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_rust_application/core/utils/dio_provider.dart';
import 'package:flutter_rust_application/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_rust_application/data/datasources/remote/auth_remote_data_source_impl.dart';
import 'package:flutter_rust_application/domain/use_cases/register_user_usecase.dart';
import 'package:flutter_rust_application/presentation/bloc/register_user/register_user_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt inject = GetIt.instance;

setup() async {
  // env
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print("Error .env: $e");
  }

  // service
  inject.registerSingleton<DioProvider>(DioProvider());

  // repository
  inject.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  // use case
  inject.registerLazySingleton(
    () => RegisterUserUseCase(inject()),
  );

  // data source
  inject.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  // bloc
  inject.registerFactory(() => RegisterUserBloc(registerUserUseCase: inject()));
}
