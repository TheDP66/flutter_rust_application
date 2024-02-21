import 'package:InOut/core/params/barang_params.dart';
import 'package:InOut/core/resources/data_state.dart';
import 'package:InOut/data/datasources/remote/barang_remote_data_source.dart';
import 'package:InOut/data/models/barang_model.dart';
import 'package:InOut/domain/entities/barang_entity.dart';
import 'package:InOut/domain/repository/barang_repository.dart';

class BarangRepositoryImpl implements BarangRepository {
  final BarangRemoteDataSource remoteDataSource;

  BarangRepositoryImpl(this.remoteDataSource);

  @override
  Future<DataState<List<BarangEntity>>> getBarangRepository(
    GetBarangParams params,
  ) async {
    try {
      Map<String, dynamic> response = await remoteDataSource.getBarangRemote(
        params,
      );

      List<BarangEntity> barangEntity = BarangModel.listFromJson(
        response["data"]["barang"],
      );

      return DataSuccess(barangEntity);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<BarangEntity>> insertBarangRepository(
    InsertBarangParams params,
  ) async {
    try {
      Map<String, dynamic> response = await remoteDataSource.insertBarangRemote(
        params,
      );

      BarangEntity barangEntity = BarangModel.fromJson(
        response["data"]["barang"],
      );

      return DataSuccess(barangEntity);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<String>> syncBarangRepository(
      SyncBarangParams params) async {
    try {
      Map<String, dynamic> response =
          await remoteDataSource.syncBarangRemote(params);

      String message = response["message"];

      return DataSuccess(message);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
