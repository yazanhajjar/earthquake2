import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkersNotifier extends StateNotifier<List<Marker>> {
  MarkersNotifier() : super([]);
  void addMarker(Marker marker) {
    state = [
      for (final m in state)
        if (m.markerId != marker.markerId) m,
      marker
    ];
  }

  void deleteMarker(MarkerId markerId) {
    state = state.where((marker) => marker.markerId != markerId).toList();
  }
}

final markersProvider =
    StateNotifierProvider<MarkersNotifier, List<Marker>>((ref) {
  return MarkersNotifier();
});
