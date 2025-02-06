import 'package:earthquake_protection/models/storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LightNotifier extends StateNotifier<bool> {
  LightNotifier() : super(true) {
    _initialize();
  }
  
  Future<void> _initialize() async {
    bool initialLanguageNumber = await Storage.getvalue('lightmode');
    state = initialLanguageNumber;
  }

  void changingMode() {
    if(state==false){
      state=true;
      Storage.setvalue('lightmode', true);
    }else if(state==true){
      state=false;
      Storage.setvalue('lightmode', false);
    }
  }
}

final lightProvider =
    StateNotifierProvider<LightNotifier, bool>((ref) {
  return LightNotifier();
});
