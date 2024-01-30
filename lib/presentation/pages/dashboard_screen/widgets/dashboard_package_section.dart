import 'package:InOut/presentation/pages/dashboard_screen/widgets/dashboard_package_card.dart';
import 'package:flutter/cupertino.dart';

class DashboardPackageSection extends StatelessWidget {
  const DashboardPackageSection({
    super.key,
    required this.barangList,
  });

  final List<Map<String, dynamic>> barangList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Packages",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Column(
          children: barangList
              .map(
                (barang) => DashboardPackageCard(
                  name: barang["name"],
                  price: barang["price"],
                  stock: barang["stock"],
                  expiredDate: barang["expiredAt"],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
