import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
            child: Text("set token"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                token = "LOLOL";
              });
            },
            child: Text("set string"),
          ),
        ],
      ),
    );
  }
}
