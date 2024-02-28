class InsertBarangParams {
  String name;
  int price;
  int stock;
  String? expired_at;

  InsertBarangParams({
    required this.name,
    required this.price,
    required this.stock,
    this.expired_at,
  });
}

class GetBarangParams {
  String? name;

  GetBarangParams({
    this.name,
  });
}

class SyncBarangParams {
  List<Map<String, dynamic>> barang;

  SyncBarangParams({
    required this.barang,
  });
}
