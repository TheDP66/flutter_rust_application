import 'package:InOut/core/services/pdf_api.dart';
import 'package:InOut/core/utils/invoice_pdf_api.dart';
import 'package:InOut/data/models/invoice_model.dart';
import 'package:InOut/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class DashboardExportButton extends StatelessWidget {
  const DashboardExportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () async {
        final invoice = Invoice(
          user: UserEntity(
            name: "User 1",
            email: "user1@mail.com",
          ),
        );

        final pdfFile = await InvoicePdfApi.generate(invoice);

        print("=============================== pdf saved");

        PdfApi.openFile(pdfFile);
      },
      icon: const Icon(Icons.print),
      label: const Text("Export"),
    );
  }
}
