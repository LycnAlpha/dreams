import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  final double lat;
  final double lan;
  const GoogleMapScreen({Key? key, required this.lat, required this.lan})
      : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  //final Completer<GoogleMapController> _controler = Completer();
  late GoogleMapController googleMapController;

  static const CameraPosition initialPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Set<Marker> markers = {};
  // static final Marker _kGooglePlaxMarker = Marker(
  //   markerId: MarkerId('kGooglePlex'),
  //   infoWindow: InfoWindow(title: 'This Is Place'),
  //   icon: BitmapDescriptor.defaultMarker,
  //   position: LatLng(37.42796133580664, -122.085749655962),
  // );
  // static const CameraPosition targetPosition = CameraPosition(
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     zoom: 14.4746,
  //     bearing: 192.0,
  //     tilt: 60);

  @override
  void initState() {
    markers.add(Marker(
        markerId: const MarkerId('selected position'),
        position: LatLng(widget.lat, widget.lan)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location Traker."),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(widget.lat, widget.lan), zoom: 14),
        mapType: MapType.normal,
        markers: markers,
        //markers: markerId: const MarkerId("selected position2"),position: LatLng(widget.lat, widget.lan),
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Position position = await _goToCurrntPosition();

          googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 14)));

          markers.clear();

          markers.add(Marker(
              markerId: const MarkerId('user currnt position'),
              position: LatLng(position.latitude, position.longitude)));

          setState(() {});
        },
        label: const Text("Your Position"),
        icon: const Icon(Icons.location_history),
      ),
    );
  }

  Future<Position> _goToCurrntPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("Location Service are disabled");
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permission are permenatly denied");
    }

    Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}
