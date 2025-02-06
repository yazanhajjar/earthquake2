import 'package:earthquake_protection/models/the_question.dart';
import 'package:earthquake_protection/providers/languagenumber.dart';
import 'package:earthquake_protection/screens/quizscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Medicalquiz extends ConsumerWidget {
  const Medicalquiz({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int languagenumber = ref.read(languagenumberProvider);

    return Quizscreen(
      title:
          languagenumber == 0 ? 'first aid Quiz' : 'اختبار الإسعافات ',
      question: languagenumber == 0 ? medicalQuestion : medicalQuestionarabic,
    );
  }
}
