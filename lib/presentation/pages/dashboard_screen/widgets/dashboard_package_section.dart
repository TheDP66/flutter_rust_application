import 'package:InOut/domain/entities/barang_entity.dart';
import 'package:InOut/presentation/pages/dashboard_screen/widgets/dashboard_card_view.dart';
import 'package:InOut/presentation/pages/dashboard_screen/widgets/dashboard_datatable_view.dart';
import 'package:InOut/presentation/pages/dashboard_screen/widgets/dashboard_export_button.dart';
import 'package:flutter/material.dart';

class DashboardPackageSection extends StatefulWidget {
  const DashboardPackageSection({
    super.key,
    required this.barangs,
  });

  final List<BarangEntity> barangs;

  @override
  State<DashboardPackageSection> createState() =>
      _DashboardPackageSectionState();
}

class _DashboardPackageSectionState extends State<DashboardPackageSection> {
  bool _isCardView = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Packages",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 21,
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isCardView = !_isCardView;
                    });
                  },
                  icon: Icon(_isCardView
                      ? Icons.grid_on_rounded
                      : Icons.table_rows_rounded),
                ),
                const DashboardExportButton(),
              ],
            )
          ],
        ),
        const SizedBox(height: 12),
        _isCardView
            ? DashboardCardView(
                barangs: widget.barangs,
              )
            : DashboardDatatableView(
                barangs: widget.barangs,
              ),
      ],
    );
  }
}
