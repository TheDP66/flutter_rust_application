import 'package:InOut/core/params/barang_params.dart';
import 'package:InOut/core/services/pdf_api.dart';
import 'package:InOut/core/utils/formatter.dart';
import 'package:InOut/core/utils/report_pdf_api.dart';
import 'package:InOut/data/models/company_mode.dart';
import 'package:InOut/data/models/report_model.dart';
import 'package:InOut/presentation/bloc/dashboard_screen/dashboard_screen_bloc.dart';
import 'package:InOut/presentation/bloc/dashboard_screen/dashboard_screen_event.dart';
import 'package:InOut/presentation/bloc/dashboard_screen/dashboard_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardExportButton extends StatelessWidget {
  const DashboardExportButton({super.key});

  void _generateOpenPdf(String title, Report report) async {
    final pdfFile = await ReportPdfApi.generate(title, report);

    PdfApi.openFile(pdfFile);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardScreenBloc, DashboardScreenState>(
      builder: (context, state) {
        if (state is ExportPackageLoading) {
          return TextButton.icon(
            onPressed: null,
            icon: Container(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.grey,
              ),
            ),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey,
            ),
            label: const Text("Exporting..."),
          );
        }

        if (state is ExportPackageError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(20),
                content: Text(state.message),
              ),
            );
          });
        }

        if (state is ExportPackageLoaded) {
          final title = "report-${Formatter.date(DateTime.now())}";

          final report = Report(
            reportHeader: ReportHeader(
              company: Company(
                  name: "Your Company Name", email: "your@company.email"),
            ),
            reportInfo: ReportInfo(
              user: state.user,
            ),
            reportTitle: const ReportTitle(
              title: "REPORT",
              description:
                  "Inclusive of all barang and their respective total price, with a specific emphasis on the total losses incurred from expired barang.",
            ),
            barangs: state.barang,
          );

          _generateOpenPdf(title, report);
        }

        return TextButton.icon(
          onPressed: () async {
            BlocProvider.of<DashboardScreenBloc>(context).add(
              PrepExportPackage(
                GetBarangParams(
                  name: null,
                ),
              ),
            );
          },
          icon: const Icon(Icons.print),
          label: const Text("Export"),
        );
      },
    );
  }
}
