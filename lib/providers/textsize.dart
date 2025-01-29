
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextSizeNotifier extends StateNotifier<int>{
TextSizeNotifier():super(0);

changingvalue(int x){
  state=x;
}
}

final textsizeProvider=StateNotifierProvider<TextSizeNotifier,int>((ref) {
  return TextSizeNotifier();
},);




