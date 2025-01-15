import 'package:earthquake_protection/models/education.dart';
import 'package:earthquake_protection/screens/firequiz.dart';
import 'package:earthquake_protection/screens/information_screen.dart';
import 'package:flutter/material.dart';

class FireEducation extends StatelessWidget {
  const FireEducation({super.key});

  @override
  Widget build(BuildContext context) {
    return InformationScreen(
      title: 'Fires Education',
      information: fireInformation, screen: const Firequiz(),
    );
  }
}
