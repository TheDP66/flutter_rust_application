import 'package:InOut/domain/entities/barang_entity.dart';
import 'package:InOut/presentation/pages/dashboard_screen/widgets/dashboard_package_card.dart';
import 'package:flutter/cupertino.dart';

class DashboardPackageSection extends StatelessWidget {
  const DashboardPackageSection({
    super.key,
    required this.barangs,
  });

  final List<BarangEntity> barangs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          "Packages",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          itemCount: barangs.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return DashboardPackageCard(
              name: barangs[index].name,
              price: barangs[index].price,
              stock: barangs[index].stock,
              expiredDate: barangs[index].expiredAt,
            );
          },
        ),
      ],
    );
  }
}
