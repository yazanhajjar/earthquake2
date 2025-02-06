import 'package:earthquake_protection/models/storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguagenumberNotifier extends StateNotifier<int> {
  LanguagenumberNotifier() : super(0) {
    _initialize();
  }
  
  Future<void> _initialize() async {
    int initialLanguageNumber = await Storage.getvalue('languagenumber');
    state = initialLanguageNumber;
  }

  void changinglanguage() {
    if (state == 0) {
      state = 1;
      Storage.setvalue('languagenumber', 1);
    } else if (state == 1) {
      state = 0;
      Storage.setvalue('languagenumber', 0);
    }
  }
}

final languagenumberProvider =
    StateNotifierProvider<LanguagenumberNotifier, int>((ref) {
  return LanguagenumberNotifier();
});
