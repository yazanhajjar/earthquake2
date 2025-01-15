import 'package:flutter_riverpod/flutter_riverpod.dart';

class PagenumberNotifer extends StateNotifier<int>{
  PagenumberNotifer():super(0);

    void selectedpage(int val) {
    
      state = val;
  }
  
}



final pagenumberProvider = StateNotifierProvider<PagenumberNotifer,int>((ref) {
  return PagenumberNotifer();
});