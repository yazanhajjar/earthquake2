import 'package:flutter_riverpod/flutter_riverpod.dart';

class LightNotifier extends StateNotifier<bool> {
  LightNotifier() : super(true);

  void changingMode() {
    if(state==false){
      state=true;
    }else if(state==true){
      state=false;
    }
  }
}

final lightProvider =
    StateNotifierProvider<LightNotifier, bool>((ref) {
  return LightNotifier();
});
