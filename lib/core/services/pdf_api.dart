import 'dart:io';

import 'package:open_filex/open_filex.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    // final dir = await getExternalStorageDirectory();
    // final file = File('$dir/$name');
    // await file.writeAsBytes(bytes);

    // final dir = await getDownloadsDirectory();
    // final file = File('$dir/$name');
    // await file.writeAsBytes(bytes);

    final dir = Directory('/storage/emulated/0/Download');
    final file = File("${dir.path}/$name");
    await file.writeAsBytes(bytes);

    print("============================= save document");
    print(file);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    print("================================ open file");
    print(url);

    await OpenFilex.open(url);
  }
}
