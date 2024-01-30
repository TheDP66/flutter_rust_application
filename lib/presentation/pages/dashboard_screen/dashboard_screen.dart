import 'package:InOut/presentation/pages/dashboard_screen/widgets/dashboard_appbar.dart';
import 'package:InOut/presentation/pages/dashboard_screen/widgets/dashboard_package_section.dart';
import 'package:InOut/presentation/pages/dashboard_screen/widgets/dashboard_searchbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late SharedPreferences prefs;
  String? token;

  @override
  void initState() {
    super.initState();
    _initializePrefs();
  }

  Future<void> _initializePrefs() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      token = prefs.getString("token");
    });
  }

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
              Text("token: $token"),
              ElevatedButton(
                onPressed: () {
                  prefs.remove("token");

                  setState(() {
                    token = prefs.getString("token");
                  });
                },
                child: const Text("remove token"),
              ),
              ElevatedButton(
                onPressed: () {
                  prefs.setString("token", "token");

                  setState(() {
                    token = prefs.getString("token");
                  });
                },
                child: const Text("set token"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    token = "LOLOL";
                  });
                },
                child: const Text("set string"),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
