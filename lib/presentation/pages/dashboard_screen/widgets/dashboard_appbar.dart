import 'package:InOut/presentation/pages/account_screen/account_screen.dart';
import 'package:flutter/material.dart';

class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      leadingWidth: 42,
      floating: true,
      automaticallyImplyLeading: false,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.grey[100],
      surfaceTintColor: Colors.grey[100],
      leading: Padding(
        padding: const EdgeInsets.only(
          left: 14,
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AccountScreen(),
              ),
            );
          },
          child: CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey[600],
            child: const Icon(
              Icons.person,
              size: 23,
              color: Colors.white,
            ),
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(
          top: 30,
          bottom: 20,
          right: 28,
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
    );
  }
}
