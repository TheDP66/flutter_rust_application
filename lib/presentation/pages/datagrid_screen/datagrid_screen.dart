import 'dart:developer';
import 'dart:io';

import 'package:InOut/data/datasources/local/user_data_source.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DatagridScreen extends StatefulWidget {
  const DatagridScreen({super.key});

  @override
  State<DatagridScreen> createState() => _DatagridScreenState();
}

class _DatagridScreenState extends State<DatagridScreen> {
  late UserDataSource userDataSource = UserDataSource(userData: []);

  void _pickExcelFile() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      withData: true,
      dialogTitle: "Please choose Excel file",
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    print("=============================================================");
    print(pickedFile);

    if (pickedFile != null) {
      var bytes = await File(pickedFile.files.first.path!).readAsBytes();
      var excel = Excel.decodeBytes(bytes);

      List<User> users = [];

      for (var table in excel.tables.keys) {
        print(table); //sheet Name
        print(excel.tables[table]!.maxColumns);
        print(excel.tables[table]!.maxRows);

        excel.tables[table]!.rows.asMap().forEach(
          (key, row) {
            if (key != 0) {
              users.add(User(
                int.parse(row[0]!.value.toString()),
                row[1]!.value.toString(),
                int.parse(row[2]!.value.toString()),
              ));
            }
          },
        );
      }

      setState(() {
        userDataSource = UserDataSource(
          userData: users,
        );
      });
    }
  }

  void _submitUser() {
    for (var user in userDataSource.users) {
      log("${user.no}, ${user.name}, ${user.age}");
    }
  }

  @override
  void dispose() {
    super.dispose();
    userDataSource.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Excel to DataGrid"),
        actions: [
          IconButton(
            onPressed: _pickExcelFile,
            icon: const Icon(Icons.upload_file),
          ),
          IconButton(
            onPressed: _submitUser,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.flight),
          ),
          SfDataGrid(
            source: userDataSource,
            allowEditing: true,
            selectionMode: SelectionMode.single,
            navigationMode: GridNavigationMode.cell,
            editingGestureType: EditingGestureType.doubleTap,
            columns: <GridColumn>[
              GridColumn(
                allowEditing: false,
                columnName: 'no',
                label: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.centerRight,
                  child: const Text(
                    'No',
                  ),
                ),
              ),
              GridColumn(
                allowEditing: true,
                columnName: 'name',
                label: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.centerLeft,
                  child: const Text('Name'),
                ),
              ),
              GridColumn(
                allowEditing: true,
                columnName: 'age',
                width: 120,
                label: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.centerLeft,
                  child: const Text('Age'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text("Footer 1"), Text("Footer 2")],
          )
        ],
      ),
    );
  }
}
