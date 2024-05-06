import 'dart:math';

import 'package:InOut/core/utils/formatter.dart';
import 'package:InOut/presentation/pages/attendance_screen/widgets/attendance_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  var companyLocation = GeoPoint(
    latitude: -7.2818693,
    longitude: 112.659575,
  );
  var companyRadius = 10.0;

  var oldLocation = GeoPoint(latitude: 0, longitude: 0);

  final mapController = MapController(
    initPosition: GeoPoint(
      latitude: -7.2818693,
      longitude: 112.659575,
    ),
  );

  var markerMap = <String, String>{};

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mapController.listenerMapSingleTapping.addListener(
        () async {
          var position = mapController.listenerMapSingleTapping.value;

          if (position != null) {
            await mapController.addMarker(
              position,
              markerIcon: const MarkerIcon(
                icon: Icon(
                  Icons.pin_drop,
                  color: Colors.blue,
                  size: 48,
                ),
              ),
            );

            // Add marker to map, hold information of marker
            var key = '${position.latitude}_${position.longitude}';
            markerMap[key] = markerMap.length.toString();
          }
        },
      );
    });
  }

  bool clockIn() {
    var radius = companyRadius * 0.000008;
    const p = 0.017453292519943295;

    double lat1 = companyLocation.latitude;
    double lon1 = companyLocation.longitude;
    double lat2 = oldLocation.latitude;
    double lon2 = oldLocation.longitude;

    double dLat = p * (lat2 - lat1);
    double dLon = p * (lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(p * lat1) * cos(p * lat2) * sin(dLon / 2) * sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    var distance = 12742 * c;

    print("================================================================");
    print("companyLocation: $companyLocation");
    print("oldLocation: $oldLocation");
    print("distance: $distance, radius: $radius");

    // ? false ? user inside : user outside
    return distance <= radius;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(21),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                height: 200,
                child: AttendanceMap(
                  companyLocation: companyLocation,
                  companyRadius: companyRadius,
                  mapController: mapController,
                  oldLocation: oldLocation,
                ),
              ),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                detailAttendance("Date", Formatter.monthDate(DateTime.now())),
                const SizedBox(width: 20),
                detailAttendance("Time", Formatter.time(DateTime.now())),
              ],
            ),
            const SizedBox(height: 7),
            const Divider(),
            const SizedBox(height: 28),
            const Expanded(child: SizedBox()),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.login),
                    label: const Text("Clock In"),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: theme.colorScheme.secondaryContainer,
                    ),
                    onPressed: () {},
                    icon: Icon(
                      Icons.logout,
                      color: theme.colorScheme.primary,
                    ),
                    label: Text(
                      "Clock Out",
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget detailAttendance(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
