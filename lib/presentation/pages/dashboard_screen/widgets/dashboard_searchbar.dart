import 'package:flutter/cupertino.dart';

class DashboardSearchBar extends StatelessWidget {
  const DashboardSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: CupertinoSearchTextField(),
    );
  }
}
