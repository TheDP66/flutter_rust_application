import 'dart:developer';

import 'package:InOut/core/hive/barang.dart';
import 'package:InOut/core/hive/datasources/barang_hive_data_source.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class OfflinePackageDatatableView extends StatefulWidget {
  const OfflinePackageDatatableView({
    super.key,
    required this.barangs,
  });

  final List<BarangHive> barangs;

  @override
  State<OfflinePackageDatatableView> createState() =>
      _OfflinePackageDatatableViewState();
}

class _OfflinePackageDatatableViewState
    extends State<OfflinePackageDatatableView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 500,
      child: PaginatedDataTable2(
        availableRowsPerPage: const [2, 5, 10, 30, 100],
        rowsPerPage: _rowsPerPage,
        minWidth: 600,
        horizontalMargin: 20,
        checkboxHorizontalMargin: 12,
        columnSpacing: 0,
        wrapInCard: false,
        renderEmptyRowsInTheEnd: false,
        fit: FlexFit.tight,
        columns: const [
          DataColumn2(
            label: Text("No."),
            fixedWidth: 50,
          ),
          DataColumn2(
            label: Text("Name"),
            fixedWidth: 150,
          ),
          DataColumn2(
            label: Text("Exp. Date"),
            fixedWidth: 150,
          ),
          DataColumn2(
            label: Text("Qty"),
            numeric: true,
            fixedWidth: 100,
          ),
          DataColumn2(
            label: Text("Unit Price"),
            numeric: true,
          ),
        ],
        onRowsPerPageChanged: (value) {
          _rowsPerPage = value!;
          log(_rowsPerPage.toString());
        },
        initialFirstRowIndex: 0,
        onPageChanged: (rowIndex) {
          log((rowIndex / _rowsPerPage).toString());
        },
        empty: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            color: theme.colorScheme.background,
            child: const Text('No data'),
          ),
        ),
        source: BarangHiveDataSource(widget.barangs),
      ),
    );
  }
}
