import 'package:InOut/core/widgets/package_card.dart';
import 'package:InOut/domain/entities/barang_entity.dart';
import 'package:flutter/material.dart';

class DashboardCardView extends StatelessWidget {
  const DashboardCardView({
    super.key,
    required this.barangs,
  });

  final List<BarangEntity> barangs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(top: 0),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: barangs.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return PackageCard(
              name: barangs[index].name,
              price: barangs[index].price,
              stock: barangs[index].stock,
              expiredDate: barangs[index].expired_at,
            );
          },
        ),
        const SizedBox(
          height: 80,
          child: Center(
            child: Opacity(
              opacity: .7,
              child: Text("End of Items"),
            ),
          ),
        ),
      ],
    );
  }
}
