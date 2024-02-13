import 'package:InOut/domain/entities/barang_entity.dart';
import 'package:flutter/material.dart';

class BarangLocalDataSource extends DataTableSource {
  final List<BarangEntity> _barangs;

  BarangLocalDataSource(this._barangs);

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text("${index + 1}")),
      DataCell(Text(_barangs[index].name!)),
      DataCell(Text(_barangs[index].expiredAt.toString())),
      DataCell(Text(_barangs[index].stock.toString())),
      DataCell(Text(_barangs[index].price.toString())),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _barangs.length;

  @override
  int get selectedRowCount => 0;
}
