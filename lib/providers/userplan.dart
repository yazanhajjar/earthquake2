import 'package:earthquake_protection/models/storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlanNotifier extends StateNotifier<List<String>> {
  PlanNotifier() : super([]){
    _initialize();
  }

Future<void> _initialize() async {
    List<String> initplan = await Storage.getvalue('plan');
    state = initplan;
  }

  void editplan(List<String> plan) {
    state = plan;
  }
}

final planProvider = StateNotifierProvider<PlanNotifier, List<String>>((ref) {
  return PlanNotifier();
});
