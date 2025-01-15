import 'package:earthquake_protection/models/the_question.dart';
import 'package:earthquake_protection/screens/quizscreen.dart';
import 'package:flutter/material.dart';

class Firequiz extends StatelessWidget {
  const Firequiz({super.key});

  @override
  Widget build(BuildContext context) {
   return const Quizscreen(
      title: 'Fires Quiz',
      question: fireQuestion,
    );
  }
}