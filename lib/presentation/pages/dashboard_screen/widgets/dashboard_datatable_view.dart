import 'package:InOut/data/datasources/local/barang_local_data_source.dart';
import 'package:InOut/domain/entities/barang_entity.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class DashboardDatatableView extends StatefulWidget {
  const DashboardDatatableView({
    super.key,
    required this.barangs,
  });

  final List<BarangEntity> barangs;

  @override
  State<DashboardDatatableView> createState() => _DashboardDatatableViewState();
}

class _DashboardDatatableViewState extends State<DashboardDatatableView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  bool _sortAscending = true;
  int? _sortColumnIndex;
  bool _initialized = false;
  PaginatorController? _controller;

  @override
  Widget build(BuildContext context) {
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
          print(_rowsPerPage);
        },
        initialFirstRowIndex: 0,
        onPageChanged: (rowIndex) {
          print(rowIndex / _rowsPerPage);
        },
        empty: Center(
            child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.grey[200],
                child: const Text('No data'))),
        source: BarangLocalDataSource(widget.barangs),
      ),
    );
  }
}
