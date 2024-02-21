import 'package:InOut/core/params/barang_params.dart';
import 'package:InOut/core/resources/data_state.dart';
import 'package:InOut/core/usecase/use_case.dart';
import 'package:InOut/domain/repository/barang_repository.dart';

class SyncBarangUseCase extends UseCase<DataState<String>, SyncBarangParams> {
  final BarangRepository barangRepository;

  SyncBarangUseCase(this.barangRepository);

  @override
  Future<DataState<String>> call(SyncBarangParams param) {
    return barangRepository.syncBarangRepository(param);
  }
}
