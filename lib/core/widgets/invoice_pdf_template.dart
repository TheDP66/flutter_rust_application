import 'package:InOut/core/utils/formatter.dart';
import 'package:InOut/data/models/invoice_model.dart';
import 'package:InOut/domain/entities/user_entity.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

Widget buildHeader(InvoiceHeader invoice, Image logo) {
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

Widget buildTitle(InvoiceInfo invoice) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'INVOICE',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 0.8 * PdfPageFormat.cm),
      Text(invoice.description ?? "-"),
      SizedBox(height: 0.8 * PdfPageFormat.cm),
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

Widget buildInvoice(Invoice invoice) {
  final headers = [
    "Name",
    "Quantity",
    "Unit Price",
    "Total",
  ];

  final data = invoice.barangs.map((barang) {
    final total = barang.price! * barang.stock!;

    return [
      barang.name,
      barang.stock,
      'Rp${barang.price}',
      'Rp$total',
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
      5: Alignment.centerRight,
    },
  );
}

Widget buildSummary(Invoice invoice) {
  final total = invoice.barangs
      .map((barang) => barang.price! * barang.stock!)
      .reduce((barang1, barang2) => barang1 + barang2);

  return Container(
    alignment: Alignment.centerRight,
    child: Row(
      children: [
        Spacer(flex: 6),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildText(
                title: 'Total amount due',
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
  return Text("FOOTER");
}
