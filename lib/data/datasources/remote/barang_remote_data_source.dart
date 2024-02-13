import 'package:InOut/core/params/barang_params.dart';

abstract class BarangRemoteDataSource {
  Future<Map<String, dynamic>> insertBarangRemote(
    InsertBarangParams params,
  );

  Future<Map<String, dynamic>> getBarangRemote(
    GetBarangParams params,
  );
}
