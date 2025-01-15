import 'package:google_maps_flutter/google_maps_flutter.dart';

class Earthquake {
  final DateTime time;
  final double force;
  final String location;
  final LatLng latLng;
  Earthquake(
      {required this.time,
      required this.force,
      required this.location,
      required this.latLng});
}

List<Earthquake> earthquakeList = [
  Earthquake(
      time: DateTime.now(),
      force: 2.5,
      location: 'syria-homs',
      latLng: const LatLng(34.72739934564288, 36.717994517147424)),
  Earthquake(
      time: DateTime.now(),
      force: 4,
      location: 'syria-latakia',
      latLng: const LatLng(35.63721137054389, 36.288650680951726)),
  Earthquake(
      time: DateTime.utc(1940, 9, 7),
      force: 6.5,
      location: 'syria-damascuse',
      latLng: const LatLng(33.52073833202845, 36.28042905822221)),
];
