import 'package:InOut/presentation/pages/dashboard_screen/widgets/dashboard_appbar.dart';
import 'package:InOut/presentation/pages/dashboard_screen/widgets/dashboard_package_section.dart';
import 'package:InOut/presentation/pages/dashboard_screen/widgets/dashboard_searchbar.dart';
import 'package:InOut/presentation/pages/package_screen/package_screen.dart';
import 'package:flutter/material.dart';

List<Map<String, dynamic>> barangList = [
  {
    "id": 1,
    "name": "Barang 1",
    "price": "100000",
    "stock": "10",
    "expiredAt": "05/01/2025",
  },
  {
    "id": 2,
    "name": "Barang 2",
    "price": "200000",
    "stock": "20",
    "expiredAt": "05/02/2025",
  },
  {
    "id": 3,
    "name": "Barang 3",
    "price": "300000",
    "stock": "30",
    "expiredAt": "05/03/2025",
  },
  {
    "id": 4,
    "name": "Barang 4",
    "price": "400000",
    "stock": "40",
    "expiredAt": "05/04/2025",
  },
];

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            const DashboardAppBar(),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          child: Column(
            children: [
              const DashboardSearchBar(),
              const SizedBox(
                height: 28,
              ),
              DashboardPackageSection(barangList: barangList),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const PackageScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
