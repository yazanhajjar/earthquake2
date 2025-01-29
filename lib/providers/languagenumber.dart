import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguagenumberNotifier extends StateNotifier<int> {
  LanguagenumberNotifier() : super(0);

  void changinglanguage() {
    if(state==0){
      state=1;
    }else if(state==1){
      state=0;
    }
  }
}

final languagenumberProvider =
    StateNotifierProvider<LanguagenumberNotifier, int>((ref) {
  return LanguagenumberNotifier();
});
