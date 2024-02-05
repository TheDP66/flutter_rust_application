import 'dart:io';

import 'package:InOut/core/services/pdf_api.dart';
import 'package:InOut/core/widgets/invoice_pdf_template.dart';
import 'package:InOut/data/models/invoice_model.dart';
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

    pdf.addPage(
      pw.MultiPage(
        theme: appTheme,
        header: (context) => Text("header"),
        build: (context) => [
          buildHeader(invoice.invoiceHeader, logo),
          SizedBox(height: 3 * PdfPageFormat.cm),
          buildTitle(invoice.invoiceInfo),
          buildInvoice(invoice),
          Divider(),
          buildSummary(invoice),
        ],
        footer: (context) => buildFooter(),
      ),
    );

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }
}
