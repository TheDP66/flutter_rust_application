import 'package:InOut/core/hive/barang.dart';
import 'package:flutter/material.dart';

class BarangHiveDataSource extends DataTableSource {
  final List<BarangHive> _barangs;

  BarangHiveDataSource(this._barangs);

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text("${index + 1}")),
      DataCell(Text(_barangs[index].name)),
      DataCell(Text(_barangs[index].expired_at.toString())),
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
