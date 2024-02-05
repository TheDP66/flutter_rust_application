import 'package:InOut/domain/entities/barang_entity.dart';
import 'package:InOut/domain/entities/user_entity.dart';

class Invoice {
  final InvoiceHeader invoiceHeader;
  final InvoiceInfo invoiceInfo;
  final List<BarangEntity> barangs;

  const Invoice({
    required this.invoiceHeader,
    required this.invoiceInfo,
    required this.barangs,
  });
}

class InvoiceHeader {
  final UserEntity user;

  const InvoiceHeader({
    required this.user,
  });
}

class InvoiceInfo {
  final String title;
  final String? description;

  const InvoiceInfo({
    required this.title,
    this.description,
  });
}
