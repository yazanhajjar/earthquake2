import 'package:earthquake_protection/models/education.dart';
import 'package:earthquake_protection/screens/information_screen.dart';
import 'package:earthquake_protection/screens/medicalquiz.dart';
import 'package:flutter/material.dart';

class Medicaleducation extends StatelessWidget {
  const Medicaleducation({super.key});

  @override
  Widget build(BuildContext context) {
    return InformationScreen(
      title: 'Medical Education',
      information: medicalInformation, screen: const Medicalquiz(),
    );
  }
}
