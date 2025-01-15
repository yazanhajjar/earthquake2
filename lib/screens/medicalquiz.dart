import 'package:earthquake_protection/models/the_question.dart';
import 'package:earthquake_protection/screens/quizscreen.dart';
import 'package:flutter/material.dart';

class Medicalquiz extends StatelessWidget {
  const Medicalquiz({super.key});

  @override
  Widget build(BuildContext context) {
    return const Quizscreen(
      title: 'Medical Quiz',
      question: medicalQuestion,
    );
  }
}