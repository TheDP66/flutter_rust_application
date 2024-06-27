import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class User {
  User(
    this.no,
    this.name,
    this.age,
  );
  int no;
  String name;
  int age;
}

class UserDataSource extends DataGridSource {
  TextEditingController editingController = TextEditingController();
  dynamic newCellValue;

  UserDataSource({required List<User> userData}) {
    users = userData;
    _userData = userData
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              DataGridCell<int>(columnName: 'no', value: e.no),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<int>(columnName: 'age', value: e.age),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _userData = [];

  List<User> users = [];

  @override
  List<DataGridRow> get rows => _userData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: (dataGridCell.columnName == 'age')
            ? Alignment.centerRight
            : Alignment.centerLeft,
        padding: const EdgeInsets.all(16.0),
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }

  @override
  Widget? buildEditWidget(
    DataGridRow dataGridRow,
    RowColumnIndex rowColumnIndex,
    GridColumn column,
    submitCell,
  ) {
    // To set the value for TextField when cell is moved into edit mode.
    final String displayText = dataGridRow
            .getCells()
            .firstWhere((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            .value
            ?.toString() ??
        '';

    /// Returning the TextField with the numeric keyboard configuration.
    if (column.columnName != 'no') {
      return Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerRight,
          child: TextField(
            autofocus: true,
            controller: editingController..text = displayText,
            textAlign: TextAlign.right,
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(0),
                border: InputBorder.none,
                isDense: true),
            inputFormatters: column.columnName == "age"
                ? [FilteringTextInputFormatter.allow(RegExp('[0-9]'))]
                : null,
            keyboardType: column.columnName == "age"
                ? TextInputType.number
                : TextInputType.text,
            onChanged: (String value) {
              if (value.isNotEmpty) {
                if (column.columnName == "age") {
                  newCellValue = int.parse(value);
                } else {
                  newCellValue = value;
                }
              } else {
                newCellValue = null;
              }
            },
            onSubmitted: (String value) {
              /// Call [CellSubmit] callback to fire the canSubmitCell and
              /// onCellSubmit to commit the new value in single place.
              submitCell();
            },
          ));
    }
  }

  @override
  Future<void> onCellSubmit(
    DataGridRow dataGridRow,
    RowColumnIndex rowColumnIndex,
    GridColumn column,
  ) async {
    final dynamic oldValue = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            ?.value ??
        '';

    final int dataRowIndex = rows.indexOf(dataGridRow);

    if (newCellValue == null || oldValue == newCellValue) {
      return;
    }

    if (column.columnName != 'no') {
      rows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] = DataGridCell(
        columnName: column.columnName,
        value: newCellValue,
      );

      if (column.columnName == "name") {
        users[dataRowIndex].name = newCellValue;
      } else if (column.columnName == "age") {
        users[dataRowIndex].age = newCellValue as int;
      }
    }

    // To reset the new cell value after successfully updated to DataGridRow
    //and underlying mode.
    newCellValue = null;
  }
}
