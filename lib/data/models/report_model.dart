import 'package:InOut/data/models/company_mode.dart';
import 'package:InOut/domain/entities/barang_entity.dart';
import 'package:InOut/domain/entities/user_entity.dart';

class Report {
  final ReportHeader reportHeader;
  final ReportInfo reportInfo;
  final ReportTitle reportTitle;
  final List<BarangEntity> barangs;

  const Report({
    required this.reportHeader,
    required this.reportInfo,
    required this.reportTitle,
    required this.barangs,
  });
}

class ReportHeader {
  final Company company;

  const ReportHeader({
    required this.company,
  });
}

class ReportInfo {
  final UserEntity user;

  const ReportInfo({
    required this.user,
  });
}

class ReportTitle {
  final String title;
  final String? description;

  const ReportTitle({
    required this.title,
    this.description,
  });
}
