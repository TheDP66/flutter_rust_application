import 'package:InOut/core/utils/formatter.dart';
import 'package:InOut/data/models/company_mode.dart';
import 'package:InOut/data/models/report_model.dart';
import 'package:InOut/domain/entities/barang_entity.dart';
import 'package:InOut/domain/entities/user_entity.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

// ? Report header
Widget buildHeader(ReportHeader report, Image logo) {
  return pw.Column(
    children: [
      pw.Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildCompanyData(report.company),
          pw.Container(
            height: 100,
            width: 100,
            child: logo,
          ),
        ],
      ),
    ],
  );
}

Widget buildCompanyData(Company company) {
  return pw.Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    pw.Text(
      company.name,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    pw.SizedBox(height: 1 * PdfPageFormat.mm),
    pw.Text(company.email),
  ]);
}

// ? Report info
Widget buildInfo(ReportInfo report, DateTime currenDate) {
  return pw.Column(
    children: [
      pw.Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildUserData(report.user),
          buildReportDetail(currenDate),
        ],
      ),
    ],
  );
}

Widget buildUserData(UserEntity user) {
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

Widget buildReportDetail(DateTime currenDate) {
  final titles = <String>[
    'Expired Date:',
  ];
  final data = <String>[
    Formatter.date(currenDate),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: List.generate(titles.length, (index) {
      final title = titles[index];
      final value = data[index];

      return buildText(title: title, value: value, width: 200);
    }),
  );
}

// ? Report detail
Widget buildTitle(ReportTitle report) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        report.title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 0.5 * PdfPageFormat.cm),
      Text(report.description ?? ""),
      SizedBox(height: 0.8 * PdfPageFormat.cm),
    ],
  );
}

Widget buildReport(List<BarangEntity> barangs) {
  final headers = [
    "Name",
    "Exp. Date",
    "Quantity",
    "Unit Price",
    "Total",
  ];

  final data = barangs.map((barang) {
    final total = barang.price! * barang.stock!;

    return [
      barang.name,
      barang.expired_at ?? "-",
      barang.stock,
      Formatter.price(barang.price!),
      Formatter.price(total),
    ];
  }).toList();

  return pw.TableHelper.fromTextArray(
    headers: headers,
    data: data,
    border: null,
    headerStyle: TextStyle(fontWeight: FontWeight.bold),
    headerDecoration: const BoxDecoration(color: PdfColors.grey300),
    cellHeight: 30,
    cellAlignments: {
      0: Alignment.centerLeft,
      1: Alignment.centerRight,
      2: Alignment.centerRight,
      3: Alignment.centerRight,
      4: Alignment.centerRight,
    },
  );
}

Widget buildSummary(List<BarangEntity> barangs, DateTime currentDate) {
  final netTotal = barangs
      .map((barang) => barang.price! * barang.stock!)
      .reduce((barang1, barang2) => barang1 + barang2);

  final expTotal = barangs.map((barang) {
    if (barang.expired_at == null) return 0;

    DateTime expDate = DateTime.parse(barang.expired_at!);

    // exp date has passed
    if (currentDate.isAfter(expDate)) {
      return barang.price! * barang.stock!;
    }
    // barang not exp
    else {
      return 0;
    }
  }).reduce((barang1, barang2) => barang1 + barang2);

  final total = netTotal - expTotal;

  return Container(
    alignment: Alignment.centerRight,
    child: Row(
      children: [
        Spacer(flex: 5),
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildText(
                title: 'Net total',
                value: Formatter.price(netTotal),
                unite: true,
              ),
              buildText(
                title: 'Exp. total',
                value: Formatter.price(expTotal),
                unite: true,
              ),
              Divider(),
              buildText(
                title: 'Total amount',
                titleStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                value: Formatter.price(total),
                unite: true,
              ),
              SizedBox(height: 2 * PdfPageFormat.mm),
              Container(height: 1, color: PdfColors.grey400),
              SizedBox(height: 0.5 * PdfPageFormat.mm),
              Container(height: 1, color: PdfColors.grey400),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildText({
  required String title,
  required String value,
  double width = double.infinity,
  TextStyle? titleStyle,
  bool unite = false,
}) {
  final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

  return Container(
    width: width,
    child: Row(
      children: [
        Expanded(child: Text(title, style: style)),
        Text(value, style: unite ? style : null),
      ],
    ),
  );
}

Widget buildFooter() {
  return Text("");
}
