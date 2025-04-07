import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMap extends StatefulWidget {
  final DocumentSnapshot<Object?> place;
  const LocationMap({super.key, required this.place});

  @override
  State<LocationMap> createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationButtonEnabled: false,
      markers: {
        Marker(
          markerId: MarkerId(
            widget.place['address'],
          ),
          position: LatLng(
            widget.place['latitude'],
            widget.place['longitude'],
          ),
        )
      },
      initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.place['latitude'],
            widget.place['longitude'],
          ),
          zoom: 15),
    );
  }
}
