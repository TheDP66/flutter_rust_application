import 'package:InOut/core/params/barang_params.dart';
import 'package:InOut/core/resources/data_state.dart';
import 'package:InOut/core/resources/use_case.dart';
import 'package:InOut/domain/entities/barang_entity.dart';
import 'package:InOut/domain/repository/barang_repository.dart';

class GetBarangUseCase
    extends UseCase<DataState<List<BarangEntity>>, GetBarangParams> {
  final BarangRepository barangRepository;

  GetBarangUseCase(this.barangRepository);

  @override
  Future<DataState<List<BarangEntity>>> call(GetBarangParams param) {
    return barangRepository.getBarangRepository(param);
  }
}
