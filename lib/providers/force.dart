import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:earthquake_protection/models/storage.dart';

class ForceNotifier extends StateNotifier<int> {
  ForceNotifier() : super(1) {
    _initialize();
  }

  Future<void> _initialize() async {
    int initialForce = await Storage.getvalue('force');
    state = initialForce;
  }

  void setForce(int newForce) {
    state = newForce;
    Storage.setvalue('force', newForce);
  }
}

final forceProvider = StateNotifierProvider<ForceNotifier, int>((ref) {
  return ForceNotifier();
});
