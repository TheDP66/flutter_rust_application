import 'dart:io';

import 'package:InOut/core/services/pdf_api.dart';
import 'package:InOut/data/models/invoice_model.dart';
import 'package:InOut/domain/entities/user_entity.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class InvoicePdfApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = pw.Document();

    final imgLogo = await rootBundle.load('assets/images/icon.png');
    final imageBytesLogo = imgLogo.buffer.asUint8List();
    final logo = pw.Image(pw.MemoryImage(imageBytesLogo));

    var appTheme = ThemeData.withFont(
      base: Font.ttf(await rootBundle.load("assets/fonts/Poppins-Regular.ttf")),
      bold: Font.ttf(await rootBundle.load("assets/fonts/Poppins-Bold.ttf")),
    );

    pdf.addPage(pw.MultiPage(
      theme: appTheme,
      build: (context) => [
        buildHeader(invoice, logo),
        SizedBox(height: 3 * PdfPageFormat.cm),
        Divider(),
      ],
      // footer: (context) => buildFooter(invoice),
    ));

    print("================================== generate finished");

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static Widget buildHeader(Invoice invoice, Image logo) {
    return pw.Column(
      children: [
        pw.SizedBox(height: 1 * PdfPageFormat.cm),
        pw.Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildUserData(invoice.user),
            pw.Container(
              height: 50,
              width: 50,
              child: logo,
            ),
          ],
        ),
      ],
    );
  }

  static Widget buildUserData(UserEntity user) {
    return pw.Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      pw.Text(
        user.name!,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      pw.SizedBox(height: 1 * PdfPageFormat.mm),
      pw.Text(user.email!),
    ]);
  }
}
