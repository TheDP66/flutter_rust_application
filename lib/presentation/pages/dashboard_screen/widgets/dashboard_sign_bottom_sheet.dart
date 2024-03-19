import 'dart:typed_data';
import 'dart:ui';

import 'package:InOut/core/services/pdf_api.dart';
import 'package:InOut/core/utils/formatter.dart';
import 'package:InOut/core/utils/report_pdf_api.dart';
import 'package:InOut/data/models/company_mode.dart';
import 'package:InOut/data/models/report_model.dart';
import 'package:InOut/domain/entities/barang_entity.dart';
import 'package:InOut/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class DashboardSignBottomSheet extends StatefulWidget {
  final List<BarangEntity> barangs;
  final UserEntity user;

  const DashboardSignBottomSheet({
    super.key,
    required this.barangs,
    required this.user,
  });

  @override
  State<DashboardSignBottomSheet> createState() =>
      _DashboardSignBottomSheetState();
}

class _DashboardSignBottomSheetState extends State<DashboardSignBottomSheet> {
  final _keySignPad = GlobalKey<SfSignaturePadState>();
  var signed = false;

  void _generateOpenPdf(String title, Report report, ByteData signature) async {
    final pdfFile = await ReportPdfApi.generate(title, report, signature);

    PdfApi.openFile(pdfFile);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 6,
              left: 12,
              right: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Sign report",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.clear),
                  label: const Text("Clear"),
                  onPressed: signed == false
                      ? null
                      : () async {
                          _keySignPad.currentState?.clear();

                          setState(() {
                            signed = false;
                          });
                        },
                ),
              ],
            ),
          ),
          SfSignaturePad(
            key: _keySignPad,
            backgroundColor: Colors.white,
            maximumStrokeWidth: 5,
            minimumStrokeWidth: 5,
            onDraw: (offset, datetime) {},
            onDrawStart: () {
              setState(() {
                signed = true;
              });

              return false;
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
            ),
            width: double.infinity,
            child: FilledButton(
              onPressed: () async {
                // Get image from sign pad
                final image = await _keySignPad.currentState?.toImage();
                final signature =
                    await image!.toByteData(format: ImageByteFormat.png);

                // Prep for export pdf
                final title = "report-${Formatter.date(DateTime.now())}";

                final report = Report(
                  reportHeader: ReportHeader(
                    company: Company(
                        name: "Your Company Name", email: "your@company.email"),
                  ),
                  reportInfo: ReportInfo(
                    user: widget.user,
                  ),
                  reportTitle: const ReportTitle(
                    title: "REPORT",
                    description:
                        "Inclusive of all barang and their respective total price, with a specific emphasis on the total losses incurred from expired barang.",
                  ),
                  barangs: widget.barangs,
                );

                _generateOpenPdf(title, report, signature!);
              },
              child: Text("Download pdf"),
            ),
          ),
        ],
      ),
    );
  }
}
