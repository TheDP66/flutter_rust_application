import 'dart:io';

import 'package:InOut/core/services/pdf_api.dart';
import 'package:InOut/core/widgets/report_pdf_template.dart';
import 'package:InOut/data/models/report_model.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class ReportPdfApi {
  static Future<File> generate(
    String title,
    Report report,
    ByteData signature,
  ) async {
    final pdf = pw.Document();

    final currenDate = DateTime.now();

    // Logo
    final imgLogo = await rootBundle.load('assets/images/icon.png');
    final imageBytesLogo = imgLogo.buffer.asUint8List();
    final logo = pw.Image(pw.MemoryImage(imageBytesLogo));

    // Signature
    final signatureBytesLogo = signature.buffer.asUint8List();
    final sign = pw.Image(pw.MemoryImage(signatureBytesLogo));

    var appTheme = ThemeData.withFont(
      base: Font.ttf(await rootBundle.load("assets/fonts/Poppins-Regular.ttf")),
      bold: Font.ttf(await rootBundle.load("assets/fonts/Poppins-Bold.ttf")),
    );

    pdf.addPage(
      pw.MultiPage(
        theme: appTheme,
        header: (context) => buildHeader(report.reportHeader, logo),
        build: (context) => [
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildInfo(report.reportInfo, currenDate),
          SizedBox(height: 2 * PdfPageFormat.cm),
          buildTitle(report.reportTitle),
          buildReport(report.barangs),
          Divider(),
          buildSummary(report.barangs, currenDate),
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildSignature(report.reportInfo.user, sign),
        ],
        footer: (context) => buildFooter(),
      ),
    );

    return PdfApi.saveDocument(name: '$title.pdf', pdf: pdf);
  }
}
