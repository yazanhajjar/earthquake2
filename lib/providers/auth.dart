import 'package:earthquake_protection/models/storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginNotifier extends StateNotifier<bool> {
  LoginNotifier() : super(true) {
    _initialize();
  }
  
  Future<void> _initialize() async {
    bool initialLanguageNumber = await Storage.getvalue('login');
    state = initialLanguageNumber;
  }

  void changingloginstate() {
    if(state==false){
      state=true;
      Storage.setvalue('login', true);
    }else if(state==true){
      state=false;
      Storage.setvalue('login', false);
    }
  }
}

final loginProvider =
    StateNotifierProvider<LoginNotifier, bool>((ref) {
  return LoginNotifier();
});
