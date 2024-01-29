import 'package:flutter/cupertino.dart';
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
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            SliverAppBar(
              title: Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                ),
                child: Center(
                  child: Hero(
                    tag: "icon-tag",
                    child: Image.asset(
                      "assets/images/icon.png",
                      height: 85,
                    ),
                  ),
                ),
              ),
              floating: true,
              pinned: true,
              automaticallyImplyLeading: false,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(200),
                child: Container(
                  height: 200,
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(child: CupertinoSearchTextField()),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ];
        },
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
            SizedBox(
              height: 10000,
            ),
          ],
        ),
      ),
    );
  }
}
