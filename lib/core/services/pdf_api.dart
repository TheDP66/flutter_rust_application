import 'dart:io';

import 'package:open_filex/open_filex.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = Directory('/storage/emulated/0/Download');
    final file = File("${dir.path}/$name");
    await file.writeAsBytes(bytes);

    print(file);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFilex.open(url);
  }
}
