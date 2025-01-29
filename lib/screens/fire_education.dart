import 'package:earthquake_protection/models/education.dart';
import 'package:earthquake_protection/providers/languagenumber.dart';
import 'package:earthquake_protection/screens/firequiz.dart';
import 'package:earthquake_protection/screens/information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FireEducation extends ConsumerWidget {
  const FireEducation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int languagenumber = ref.read(languagenumberProvider);

    return InformationScreen(
      title: languagenumber == 0 ? 'Fires Education' : 'تعليمات الحرائق',
      information:
          languagenumber == 0 ? fireInformation : fireInformationarabic,
      screen: const Firequiz(),
    );
  }
}
