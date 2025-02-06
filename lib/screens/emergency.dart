import 'package:earthquake_protection/models/emergencylist.dart';
import 'package:earthquake_protection/providers/language.dart';
import 'package:earthquake_protection/providers/light.dart';
import 'package:earthquake_protection/providers/markers.dart';
import 'package:earthquake_protection/providers/pagenumber.dart';
import 'package:earthquake_protection/providers/textsize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EmergencyScreen extends ConsumerWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map thetext = ref.read(languageProvider);
    int size = ref.read(textsizeProvider);
    bool mode = ref.read(lightProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mode
            ? Theme.of(context).colorScheme.secondaryFixedDim
            : const Color.fromRGBO(0, 180, 216, 1),
        title: Text(
          thetext['Emergency Places'],
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: mode
          ? Theme.of(context).colorScheme.primary
          : Color.fromRGBO(202, 240, 248, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...emergencePlaces.map((e) {
              return SizedBox(
                width: double.infinity,
                height: 300,
                child: InkWell(
                  onTap: () {
                    ref.watch(pagenumberProvider.notifier).selectedpage(1);
                    ref.watch(markersProvider.notifier).addMarker(
                          Marker(
                            markerId: const MarkerId('emergency'),
                            position: e.latLng,
                            infoWindow: const InfoWindow(title: 'Emergency'),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueGreen),
                          ),
                        );
                    Navigator.pop(context);
                  },
                  child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    color: Theme.of(context).colorScheme.secondaryFixedDim,
                    margin: const EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.asset(
                              e.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Container(
                              width: double.infinity,
                              height: 100,
                              color: Colors.black45,
                            ),
                          ),
                          Positioned(
                            bottom: 16,
                            left: 16,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24 + size.toDouble(),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      e.location,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16 + size.toDouble(),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      'phone: ${e.phone}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16 + size.toDouble(),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
