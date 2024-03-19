import 'dart:developer';

import 'package:InOut/core/permissions/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CardLocation extends StatefulWidget {
  const CardLocation({super.key});

  @override
  State<CardLocation> createState() => _CardLocationState();
}

class _CardLocationState extends State<CardLocation> {
  late double lat = 0;
  late double long = 0;
  late bool isMocked = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 21,
        vertical: 18,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Latitude"),
                  Text(
                    "$lat",
                    style: const TextStyle(
                      fontSize: 21,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text("Longitude"),
                  Text(
                    "$long",
                    style: const TextStyle(
                      fontSize: 21,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isMocked
                  ? Row(
                      children: [
                        Icon(
                          Icons.warning,
                          color: Colors.red[800],
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          "Location\nMocked",
                          style: TextStyle(
                            color: Colors.red[800],
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
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
        ],
      ),
    );
  }
}
