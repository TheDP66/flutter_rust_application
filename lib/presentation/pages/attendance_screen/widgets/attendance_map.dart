import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';

class AttendanceMap extends StatefulWidget {
  AttendanceMap({
    super.key,
    required this.mapController,
    required this.oldLocation,
    required this.companyLocation,
    required this.companyRadius,
  });

  final GeoPoint companyLocation;
  final double companyRadius;
  final MapController mapController;
  GeoPoint oldLocation;

  @override
  State<AttendanceMap> createState() => _AttendanceMapState();
}

class _AttendanceMapState extends State<AttendanceMap> {
  void drawCompanyLocation() async {
    await widget.mapController.drawCircle(CircleOSM(
      key: "company",
      centerPoint: widget.companyLocation,
      radius: widget.companyRadius,
      color: Colors.blue,
      strokeWidth: 0.3,
    ));
  }

  void updateUserLocation() async {
    Position position = await Geolocator.getCurrentPosition();

    var userLocation = GeoPoint(
      latitude: position.latitude,
      longitude: position.longitude,
    );

    await widget.mapController.changeLocationMarker(
      oldLocation: widget.oldLocation,
      newLocation: userLocation,
      iconAnchor: IconAnchor(
        anchor: Anchor.top,
      ),
      markerIcon: const MarkerIcon(
        icon: Icon(
          Icons.location_pin,
          color: Colors.red,
          size: 48,
        ),
      ),
    );

    await widget.mapController.goToLocation(userLocation);

    setState(() {
      widget.oldLocation = userLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        OSMFlutter(
          controller: widget.mapController,
          mapIsLoading: const Center(
            child: CircularProgressIndicator(),
          ),
          osmOption: OSMOption(
            zoomOption: const ZoomOption(
              initZoom: 19,
              minZoomLevel: 19,
              maxZoomLevel: 19,
              stepZoom: 0,
            ),
            userLocationMarker: UserLocationMaker(
              personMarker: const MarkerIcon(
                icon: Icon(Icons.personal_injury),
              ),
              directionArrowMarker: const MarkerIcon(
                icon: Icon(
                  Icons.location_on,
                  color: Colors.black,
                  size: 48,
                ),
              ),
            ),
            roadConfiguration: const RoadOption(
              roadColor: Colors.green,
            ),
            markerOption: MarkerOption(
              defaultMarker: const MarkerIcon(
                icon: Icon(
                  Icons.person_pin_circle,
                  color: Colors.black,
                  size: 48,
                ),
              ),
            ),
            showDefaultInfoWindow: false,
            showZoomController: false,
            enableRotationByGesture: false,
            showContributorBadgeForOSM: false,
            isPicker: false,
          ),
          onMapIsReady: (isReady) async {
            if (isReady) {
              drawCompanyLocation();
              updateUserLocation();
            }
          },
        ),
        Positioned(
          right: 1,
          top: 1,
          child: IconButton(
            onPressed: () {
              updateUserLocation();
            },
            icon: const Icon(Icons.refresh),
          ),
        ),
      ],
    );
  }
}
