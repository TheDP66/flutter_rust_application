import 'package:InOut/presentation/pages/profile_screen/widgets/card_location.dart';
import 'package:InOut/presentation/pages/profile_screen/widgets/profile_scanner_button.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile App'),
      ),
      body: const Padding(
        padding: EdgeInsets.only(
          top: 21,
          left: 21,
          right: 21,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CardLocation(),
            SizedBox(height: 21),
            ProfileScannerButton(),
            // Container(
            //   height: 500,
            //   child: ProfileScannner(),
            // ),
            // TODO: belajar pakai fl_chart
            // const ProfileChart(),
          ],
        ),
      ),
    );
  }
}
