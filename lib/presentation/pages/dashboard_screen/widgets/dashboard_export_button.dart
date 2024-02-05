import 'package:InOut/core/services/pdf_api.dart';
import 'package:InOut/core/utils/invoice_pdf_api.dart';
import 'package:InOut/data/models/invoice_model.dart';
import 'package:InOut/domain/entities/barang_entity.dart';
import 'package:InOut/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class DashboardExportButton extends StatelessWidget {
  const DashboardExportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () async {
        final invoice = Invoice(
          invoiceHeader: InvoiceHeader(
            user: UserEntity(
              name: "User 1",
              email: "user1@mail.com",
            ),
          ),
          invoiceInfo: const InvoiceInfo(
            title: "INVOICE",
          ),
          barangs: [
            BarangEntity(
              name: "Barang 1",
              price: 11000,
              stock: 110,
            ),
            BarangEntity(
              name: "Barang 2",
              price: 22000,
              stock: 220,
            ),
            BarangEntity(
              name: "Barang 3",
              price: 33000,
              stock: 330,
            ),
            BarangEntity(
              name: "Barang 4",
              price: 44000,
              stock: 440,
            ),
            BarangEntity(
              name: "Barang 5",
              price: 55000,
              stock: 550,
            ),
          ],
        );

        final pdfFile = await InvoicePdfApi.generate(invoice);

        PdfApi.openFile(pdfFile);
      },
      icon: const Icon(Icons.print),
      label: const Text("Export"),
    );
  }
}
