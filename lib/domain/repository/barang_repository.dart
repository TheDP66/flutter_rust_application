import 'package:InOut/core/params/barang_params.dart';
import 'package:InOut/core/resources/data_state.dart';
import 'package:InOut/domain/entities/barang_entity.dart';

abstract class BarangRepository {
  Future<DataState<BarangEntity>> insertBarangRepository(
    InsertBarangParams params,
  );

  Future<DataState<List<BarangEntity>>> getBarangRepository(
    GetBarangParams params,
  );

  Future<DataState<String>> syncBarangRepository(
    SyncBarangParams params,
  );
}
