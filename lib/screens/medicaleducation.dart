import 'package:earthquake_protection/models/education.dart';
import 'package:earthquake_protection/providers/languagenumber.dart';
import 'package:earthquake_protection/screens/information_screen.dart';
import 'package:earthquake_protection/screens/medicalquiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Medicaleducation extends ConsumerWidget {
  const Medicaleducation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int languagenumber = ref.read(languagenumberProvider);

    return InformationScreen(
      title: languagenumber == 0
          ? 'first aid Education'
          : 'تعليمات المساعدات الأولية',
      information:
          languagenumber == 0 ? medicalInformation : medicalInformationarabic,
      screen: const Medicalquiz(),
    );
  }
}
