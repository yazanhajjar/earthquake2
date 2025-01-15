import 'dart:async';
import 'package:earthquake_protection/models/markers.dart';
import 'package:earthquake_protection/providers/markers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

class Mapscreen extends ConsumerStatefulWidget {
  const Mapscreen({super.key});

  @override
  ConsumerState<Mapscreen> createState() => _MapscreenState();
}

class _MapscreenState extends ConsumerState<Mapscreen> {
  // final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  List<Marker> ourMarkers = [...allmarkers];
  Position? userLocation;

  static const CameraPosition initialPosition = CameraPosition(
    target: LatLng(34.8021, 38.9968), // Center of Syria
    zoom: 6.5,
  );

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    userLocation = await Geolocator.getCurrentPosition();

    ref.read(markersProvider.notifier).addMarker(Marker(
          markerId: const MarkerId('userLocation'),
          position: LatLng(userLocation!.latitude, userLocation!.longitude),
          infoWindow: const InfoWindow(title: 'My Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ));
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = ref.watch(markersProvider);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: initialPosition,
              markers: Set.from(markers),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
          ),
          Container(color: Theme.of(context).colorScheme.secondaryFixed,
            child: const Row(
              spacing: 10,
              children: [
                Icon(
                  Icons.location_on_sharp,
                  color: Colors.deepPurpleAccent,
                ),
                Text('Your location'),
                Icon(
                  Icons.location_on_sharp,
                  color: Colors.red,
                ),
                Text('Earthquake'),
                Icon(
                  Icons.location_on_sharp,
                  color: Colors.green,
                ),
                Text('Emergency'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
