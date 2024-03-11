import 'dart:developer';

import 'package:InOut/core/permissions/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.payload});

  final String? payload;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late double lat = 0;
  late double long = 0;
  late bool isMocked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile App'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("lat: $lat"),
            Text("long: $long"),
            Text("isMocked: $isMocked"),
            TextButton(
              onPressed: () async {
                if (await geolocatorService() == true) {
                  log("location service");

                  if (await geolocatorPermission() == true) {
                    Position position = await Geolocator.getCurrentPosition();

                    setState(() {
                      lat = position.latitude;
                      long = position.longitude;
                      isMocked = position.isMocked;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(20),
                        content: Text("Can't get location"),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(20),
                      content: Text("Location services are disabled"),
                    ),
                  );
                }
              },
              child: const Text("Get Location"),
            ),
          ],
        ),
      ),
    );
  }
}
