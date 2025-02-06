
import 'package:earthquake_protection/models/storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextSizeNotifier extends StateNotifier<int>{
TextSizeNotifier():super(0) {
    _initialize();
  }
  
  Future<void> _initialize() async {
    int initialLanguageNumber = await Storage.getvalue('text');
    state = initialLanguageNumber;
  }

changingvalue(int x){
  state=x;
  Storage.setvalue('text', x);
}
}

final textsizeProvider=StateNotifierProvider<TextSizeNotifier,int>((ref) {
  return TextSizeNotifier();
},);




