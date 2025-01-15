import 'package:google_maps_flutter/google_maps_flutter.dart';

class Emergencyplace {
  final String image;
  final String name;
  final String location;
  final LatLng latLng;
  final String phone;

  Emergencyplace(
      {required this.image,
      required this.name,
      required this.location,
      required this.latLng,
      required this.phone});
}

List<Emergencyplace> emergencePlaces = [
  Emergencyplace(
      image: r'lib\images\alraziHospital.jpg',
      name: 'AL raze hospital',
      location: 'Damascuse _ maza',
      latLng: const LatLng(33.505264855629086, 36.2606621740241),
      phone: '+963116118445'),
  Emergencyplace(
      image: r'lib\images\AlshamiHospital.jpg',
      name: 'AL shami hospital',
      location: 'Damascuse _ malki',
      latLng: const LatLng(33.52093502882398, 36.26834561566861),
      phone: '+963113735090'),
  Emergencyplace(
      image: r'lib\images\alzaaimhospital.jpg',
      name: 'ALzaaim hospital',
      location: 'Syria _ Homs',
      latLng: const LatLng(34.715924291841944, 36.71478852947052),
      phone: '+963312757301'),
];
