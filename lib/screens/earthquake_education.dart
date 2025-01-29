import 'package:earthquake_protection/models/education.dart';
import 'package:earthquake_protection/providers/languagenumber.dart';
import 'package:earthquake_protection/screens/earthquakequiz.dart';
import 'package:earthquake_protection/screens/information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EarthquakeEducation extends ConsumerWidget {
  const EarthquakeEducation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var languagenumber = ref.read(languagenumberProvider);
    return InformationScreen(
      title: languagenumber == 0 ? 'Earthquake Education' : 'تعليمات الزلزال',
      information: languagenumber == 0
          ? earthquakeInformation
          : earthquakeInformationArbic,
      screen: const Earthquakequiz(),
    );
  }
}
