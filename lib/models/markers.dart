import 'package:earthquake_protection/models/earthquakelist.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<Marker> allmarkers = [
   Marker(
    markerId: const MarkerId('earthquake location'),
    position:  earthquakeList.last.latLng,
    infoWindow: const InfoWindow(title: 'earthquake Location'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
  ),
   Marker(
    markerId: const MarkerId('hospital location'),
    position: const LatLng(34.72739934564, 36.717994517147),
    infoWindow: const InfoWindow(title: 'hospital location'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
  ),

];
