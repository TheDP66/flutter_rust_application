import 'package:InOut/core/services/dio_provider.dart';
import 'package:InOut/data/datasources/auth_remote_data_source.dart';
import 'package:InOut/data/datasources/barang_remote_data_source.dart';
import 'package:InOut/data/datasources/remote/auth_remote_data_source_impl.dart';
import 'package:InOut/data/datasources/remote/barang_remote_data_source_impl.dart';
import 'package:InOut/data/datasources/remote/user_remote_data_source_impl.dart';
import 'package:InOut/data/datasources/user_remote_data_source.dart';
import 'package:InOut/data/repositories/auth_repository_impl.dart';
import 'package:InOut/data/repositories/barang_repository_impl.dart';
import 'package:InOut/data/repositories/user_repository_impl.dart';
import 'package:InOut/domain/repository/auth_repository.dart';
import 'package:InOut/domain/repository/barang_repository.dart';
import 'package:InOut/domain/repository/user_repository.dart';
import 'package:InOut/domain/use_cases/get_barang_usecase.dart';
import 'package:InOut/domain/use_cases/insert_barang_usecase.dart';
import 'package:InOut/domain/use_cases/login_user_usecase.dart';
import 'package:InOut/domain/use_cases/logout_user_usecase.dart';
import 'package:InOut/domain/use_cases/me_user_usecase.dart';
import 'package:InOut/domain/use_cases/register_user_usecase.dart';
import 'package:InOut/presentation/bloc/account_screen/account_screen_bloc.dart';
import 'package:InOut/presentation/bloc/dashboard_screen/dashboard_screen_bloc.dart';
import 'package:InOut/presentation/bloc/login_screen/login_screen_bloc.dart';
import 'package:InOut/presentation/bloc/package_screen/package_screen_bloc.dart';
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
    inject.registerLazySingleton<BarangRemoteDataSource>(
      () => BarangRemoteDataSourceImpl(),
    );
    inject.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(),
    );

    // repository
    inject.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(inject()),
    );
    inject.registerLazySingleton<BarangRepository>(
      () => BarangRepositoryImpl(inject()),
    );
    inject.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(inject()),
    );

    // use case
    inject.registerLazySingleton(
      () => RegisterUserUseCase(inject()),
    );
    inject.registerLazySingleton(
      () => LoginUserUseCase(inject()),
    );
    inject.registerLazySingleton(
      () => GetBarangUseCase(inject()),
    );
    inject.registerLazySingleton(
      () => InsertBarangUseCase(inject()),
    );
    inject.registerLazySingleton(
      () => LogoutUserUseCase(inject()),
    );
    inject.registerLazySingleton(
      () => MeUserUseCase(inject()),
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
    inject.registerFactory(
      () => DashboardScreenBloc(
        getBarangUseCase: inject(),
        meUserUseCase: inject(),
      ),
    );
    inject.registerFactory(
      () => PackageScreenBloc(
        insertBarangUseCase: inject(),
      ),
    );
    inject.registerFactory(
      () => AccountScreenBloc(
        logoutUserUseCase: inject(),
        meUserUseCase: inject(),
      ),
    );
  } catch (e) {
    print("Injection error: $e");
  }
}
