import 'package:InOut/core/params/auth_params.dart';
import 'package:InOut/core/resources/data_state.dart';
import 'package:InOut/core/resources/use_case.dart';
import 'package:InOut/domain/entities/token_entity.dart';
import 'package:InOut/domain/repository/auth_repository.dart';

class RefreshTokenUseCase
    extends UseCase<DataState<TokenEntity>, RefreshTokenParams> {
  final AuthRepository authRepository;

  RefreshTokenUseCase(this.authRepository);

  @override
  Future<DataState<TokenEntity>> call(RefreshTokenParams param) {
    return authRepository.refreshTokenRepository(param);
  }
}
