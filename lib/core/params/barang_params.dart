class InsertBarangParams {
  String name;
  String price;
  String stock;
  String expiredAt;

  InsertBarangParams({
    required this.name,
    required this.price,
    required this.stock,
    required this.expiredAt,
  });
}

class GetBarangParams {
  String? name;

  GetBarangParams({
    this.name,
  });
}
