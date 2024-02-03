import 'package:InOut/core/params/barang_params.dart';
import 'package:InOut/core/resources/data_state.dart';
import 'package:InOut/core/usecase/use_case.dart';
import 'package:InOut/domain/entities/barang_entity.dart';
import 'package:InOut/domain/repository/barang_repository.dart';

class InsertBarangUseCase
    extends UseCase<DataState<BarangEntity>, InsertBarangParams> {
  final BarangRepository barangRepository;

  InsertBarangUseCase(this.barangRepository);

  @override
  Future<DataState<BarangEntity>> call(InsertBarangParams param) {
    return barangRepository.insertBarangRepository(param);
  }
}
